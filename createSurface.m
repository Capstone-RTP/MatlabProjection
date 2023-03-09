function armPoints=createSurface(type,radius,length,lengthRes,thetaRes)
    %cylinder
    if type == 0
        r=radius;
        y=linspace(0,length,lengthRes);
        theta=linspace(0,2*pi,thetaRes);
        
        %memory allocation
        armPoints=zeros(lengthRes*thetaRes,3);

        %defining points
        armPoints(:,1)=r;
        armPoints(:,2)=repmat(theta',lengthRes,1);
        for ii=0:thetaRes:thetaRes*lengthRes-lengthRes
            armPoints(ii+1:ii+thetaRes,3)=y((ii/thetaRes+1));
        end
    end

    %cylinder with growing and then shrinking radius
    if type == 1
        y=linspace(0,length,lengthRes);
        theta=linspace(0,2*pi,thetaRes);

        %memory allocation
        armPoints=zeros(lengthRes*thetaRes,3);

        %defining points
        armPoints(1:lengthRes*thetaRes/2,1)=linspace(radius*0.75,radius,lengthRes*thetaRes/2);
        armPoints(lengthRes*thetaRes/2+1:lengthRes*thetaRes,1)=linspace(radius,radius*0.75,lengthRes*thetaRes/2);
        armPoints(:,2)=repmat(theta',lengthRes,1);
        for ii=0:thetaRes:thetaRes*lengthRes-lengthRes
            armPoints(ii+1:ii+thetaRes,3)=y((ii/thetaRes+1));
        end
    
    end

end

