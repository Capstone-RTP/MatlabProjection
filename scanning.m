function [scanPath,plotPoints] = scanning(x1, x2, y1, y2,thRes,yRes)
    
    pulsesPerRev = 200;
    degreesPerRev = 360;
    yPitch = 8; %mm/rev

    thetaN2 = 520;
    thetaN1 = 20;
    %After theta being zeroed, which should be on the positive x axis
    %After y is zeroed
    %based on set resolution, make array of scanning positions
    thetaPoints = linspace(x1,x2,thRes)*thetaN2*pulsesPerRev/thetaN1/degreesPerRev;
    thetaPoints = round(thetaPoints);
    yPoints = linspace(y1,y2,yRes)*pulsesPerRev/yPitch;
    yPoints = round(yPoints);

    plotTheta = linspace(x1,x2,thRes)*pi/180;
    plotY = linspace(y1,y2,yRes);
       plotPoints = combvec(plotTheta,plotY)';
    plotPoints(:, 2:3) = plotPoints;
    plotPoints(:,1) = 40;
    
    %Ordered points from data
%     scanPath = repelem(yPoints,thRes)';
%     scanPath(:,3) = scanPath;
%     scanPath(:,1) = 0;
%     thetaPoints = thetaPoints';
%     for i = 0:yRes-1
%         if(mod(i,2))
%         scanPath(i*thRes+1:i*thRes+thRes,2) = flip(thetaPoints);
%         else
%         scanPath(i*thRes+1:i*thRes+thRes,2) = thetaPoints;
%         end
%     end
scanPath = repelem(thetaPoints,yRes)';
    scanPath(:,2) = scanPath;
    scanPath(:,1) = 0;
    yPoints = yPoints';
    for i = 0:thRes-1
        if(mod(i,2))
        scanPath(i*yRes+1:i*yRes+yRes,3) = flip(yPoints);
        else
        scanPath(i*yRes+1:i*yRes+yRes,3) = yPoints;
        end
    end
end


