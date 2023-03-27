%import surface and image
radius=60;
yLength=300;
lengthRes=200;
thetaRes=200;
zOffsetRad = 10;
scale = 0.3;
movePlotX = 0;
movePlotY = 100;

armPoints=createSurface(1,radius,yLength,lengthRes,thetaRes); %%INPUT is 0 for cylinder, 1 for non-cylinder
[v,u,paths] = getXYFromIm("C:\Code\Capstone\WEIm.png",scale, 0); %image, scale, downsample rate

%zuv=ones(length(u))*41;

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
projectedPoints = zeros(size(cell2mat(paths))+[2*length(paths) 1]);
cylindricalPath = zeros(size(cell2mat(paths))+[2*length(paths) 1]);

prevK=0;
for j=1:length(paths)
    k=dsearchn(tfCords,cell2mat(paths(j)) + [movePlotX movePlotY]);
    projectedPoints(prevK+2:prevK+length(k)+1,:) = armXZY(k,:);
    cylindricalPath(prevK+2:prevK+length(k)+1,:) = armPoints(k,:);

    %find first point in cylindical coords
    begPointPathCyl = armPoints(k(1),:);
    %increase radius for offset
    begPointPathCyl(1) = begPointPathCyl(1)+zOffsetRad;
    %offset from arm surface and convert to xzy again
    zOffsetPoint = [begPointPathCyl(1).*cos(begPointPathCyl(2)),begPointPathCyl(1).*sin(begPointPathCyl(2)),begPointPathCyl(3)];
    projectedPoints(prevK+1,:) = zOffsetPoint;
    cylindricalPath(prevK+1,:) = begPointPathCyl;
    
    %Update prevK
    prevK = prevK+length(k)+2;
    
    %find final point in cylindrical coords
    endPointPathCyl = armPoints(k(end),:);
    %increase radius for offset
    endPointPathCyl(1)= endPointPathCyl(1)+zOffsetRad;
    %offset from arm surface and convert to xzy again
    zOffsetPoint = [endPointPathCyl(1).*cos(endPointPathCyl(2)),endPointPathCyl(1).*sin(endPointPathCyl(2)),endPointPathCyl(3)];
    projectedPoints(prevK,:) = zOffsetPoint;
    cylindricalPath(prevK,:) = endPointPathCyl;
end
%use index to reverse transform points on unwrapped surface to original
%surface
% projectedPoints=armXZY(k,:);

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
%scatter3(projectedPoints(:,1),projectedPoints(:,3),projectedPoints(:,2),'o','filled','red');
plot3(projectedPoints(:,1),projectedPoints(:,3),projectedPoints(:,2),'-o','Color','b','MarkerSize',7,...
    'MarkerFaceColor','#D9FFFF')
axis equal
hold off

figure
plot3(cylindricalPath(:,1).*cos(cylindricalPath(:,2)),cylindricalPath(:,3),cylindricalPath(:,1).*sin(cylindricalPath(:,2)),'-o','Color','b','MarkerSize',7,...
    'MarkerFaceColor','#D9FFFF')
axis equal



