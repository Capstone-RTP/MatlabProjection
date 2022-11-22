%import surface and image
armPoints=createSurface();

%Convert R theta y values into x,z,y
armXZY=zeros(10000,3);
armXZY(:,1)=armPoints(:,1).*cos(armPoints(:,2));
armXZY(:,2)=armPoints(:,1).*sin(armPoints(:,2));
armXZY(:,3)=armPoints(:,3);

%Flatten surface
for i=0:length(armXZY)/length(unique(armXZY(:,3)))-1
    tfCordsSt1 = sqrt((armXZY(i*100+2:i*100+100,1)-armXZY(i*100+1:i*100+99,1)).^2+(armXZY(i*100+2:i*100+100,2)-armXZY(i*100+1:i*100+99,2)).^2);
    tfCords(i*100+2:i*100+100,1) = cumsum(tfCordsSt1);
    tfCords(i*100+1:i*100+100,2)= armXZY(i*100+1:i*100+100,3);
end
%angled line
u=transpose(linspace(2,100,100));
v=[u(1:50);-u(1:50)+u(75)];
k=dsearchn(tfCords,[u,v]);

zuv=ones([length(u),1])*41;

bustanut=armXZY(k,:);

scatter3(armXZY(:,1),armXZY(:,3),armXZY(:,2))
hold on
tfCords4Plot = tfCords;
tfCords4Plot(:,3) = 40;
scatter3(tfCords4Plot(:,1),tfCords4Plot(:,2),tfCords4Plot(:,3),'red')
scatter3(u,v,zuv,'green')
scatter3(bustanut(:,1),bustanut(:,3),bustanut(:,2),'green')
hold off
