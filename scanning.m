function [scanPath,plotPoints] = scanning(x1, x2, y1, y2,thRes,yRes)
    
    pulsesPerRev = 200;
    degreesPerRev = 360;
    yPitch = 8; %mm/rev

    thetaN2 = 520;
    thetaN1 = 16;
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
    scanPath = combvec(thetaPoints,yPoints)';
    scanPath(:,2:3) = scanPath;
    scanPath(:,1) = 0;
end


