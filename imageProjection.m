%import surface and image
radius=60;
yLength=300;
lengthRes=200;
thetaRes=200;
armPoints=createSurface(0,radius,yLength,lengthRes,thetaRes); %%INPUT is 0 for cylinder, 1 for non-cylinder
[v,u] = getXYFromIm("testIM.jpg",0.3, 0); %image, scale, downsample rate

zuv=ones(length(u))*41;

%Convert R theta y values into x,z,y
armXZY=zeros(size(armPoints));
armXZY(:,1)=armPoints(:,1).*cos(armPoints(:,2));
armXZY(:,2)=armPoints(:,1).*sin(armPoints(:,2));
armXZY(:,3)=armPoints(:,3);

%Flatten surface
for i=0:lengthRes-1
    tfCordsSt1 = sqrt((armXZY(i*thetaRes+2:i*thetaRes+thetaRes ,1)-armXZY(i*thetaRes+1:i*thetaRes+thetaRes-1,1)).^2+(armXZY(i*thetaRes+2:i*thetaRes+thetaRes,2)-armXZY(i*thetaRes+1:i*thetaRes+thetaRes-1,2)).^2);
    tfCords(i*thetaRes+2:i*thetaRes+thetaRes,1) = cumsum(tfCordsSt1);
    tfCords(i*thetaRes+1:i*thetaRes+thetaRes,2)= armXZY(i*thetaRes+1:i*thetaRes+thetaRes,3);
end

%find closest points on flattened/unwrapped surface 
k=dsearchn(tfCords,[u,v]);

%use index to reverse transform points on unwrapped surface to original
%surface
projectedPoints=armXZY(k,:);

% %plots
% tfCords4Plot = tfCords;
% tfCords4Plot(:,3) = 40;
% figure;
% scatter3(u,v,zuv,'green')
% hold on
% scatter3(tfCords4Plot(:,1),tfCords4Plot(:,2),tfCords4Plot(:,3),'blue')
% axis equal
% hold off
% figure
scatter3(armXZY(:,1),armXZY(:,3),armXZY(:,2),'filled')
axis equal
hold on
scatter3(projectedPoints(:,1),projectedPoints(:,3),projectedPoints(:,2),'o','filled','red')
axis equal
xlabel('X Axis')
ylabel("Y Axis")
zlabel('Z Axis')
hold off