function armPoints=createSurface(type)
if type == 0

r=30;
y=linspace(0,100,100);
theta=linspace(0,2*pi,100);

armPoints=zeros(10000,3);

armPoints(:,1)=r;
armPoints(:,2)=repmat(theta',100,1);

for ii=0:100:9900
armPoints(ii+1:ii+100,3)=y((ii/100+1));
end
end

if type == 1
r=30;
    y=linspace(0,100,100);
    theta=linspace(0,2*pi,100);
    
    armPoints=zeros(10000,3);
    armPoints(1:5000,1)=linspace(20,30,5000);
    armPoints(5001:10000,1)=linspace(30,20,5000);
    armPoints(:,2)=repmat(theta',100,1);
    
    for ii=0:100:9900
        armPoints(ii+1:ii+100,3)=y((ii/100+1));
    end 

end


end

