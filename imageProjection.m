%import surface and image
armPoints=createSurface(0); %%INPUT is 0 for cylinder, 1 for non-cylinder
[v u] = getXYFromIm("test_tattoo.png",0.2, 0); %image, scale, downsample rate
zuv=ones(length(u))*41;

%Convert R theta y values into x,z,y
armXZY=zeros(size(armPoints));
armXZY(:,1)=armPoints(:,1).*cos(armPoints(:,2));
armXZY(:,2)=armPoints(:,1).*sin(armPoints(:,2));
armXZY(:,3)=armPoints(:,3);

%Flatten surface
for i=0:length(armXZY)/length(unique(armXZY(:,3)))-1
    tfCordsSt1 = sqrt((armXZY(i*100+2:i*100+100,1)-armXZY(i*100+1:i*100+99,1)).^2+(armXZY(i*100+2:i*100+100,2)-armXZY(i*100+1:i*100+99,2)).^2);
    tfCords(i*100+2:i*100+100,1) = cumsum(tfCordsSt1);
    tfCords(i*100+1:i*100+100,2)= armXZY(i*100+1:i*100+100,3);
end

%find closest points on flattened/unwrapped surface 
k=dsearchn(tfCords,[u,v]);

%use index to reverse transform points on unwrapped surface to original
%surface
bustanut=armXZY(k,:);

%plots
tfCords4Plot = tfCords;
tfCords4Plot(:,3) = 40;
scatter3(u,v,zuv,'green')
hold on
scatter3(tfCords4Plot(:,1),tfCords4Plot(:,2),tfCords4Plot(:,3),'red')
hold off
figure
scatter3(armXZY(:,1),armXZY(:,3),armXZY(:,2))
hold on
scatter3(bustanut(:,1),bustanut(:,3),bustanut(:,2),'green')
xlabel('X Axis')
ylabel("Y Axis")
zlabel('Z Axis')
hold off