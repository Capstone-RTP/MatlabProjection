function [scanPath,plotPoints] = scanning(x1, x2, y1, y2,thRes,yRes)

pulsesPerRev = 200;
degreesPerRev = 360;
yPitch = 12; %mm/rev

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


%Ordered points from data
scanPath = repelem(thetaPoints,yRes)';
plotPoints = repelem(plotTheta,yRes)';
scanPath(:,2) = scanPath;
scanPath(:,1) = 0;
plotPoints(:,2) = plotPoints;
plotPoints(:,1) = 25;
yPoints = yPoints';
plotY = plotY';

for i = 0:thRes-1
    if(mod(i,2))
        scanPath(i*yRes+1:i*yRes+yRes,3) = flip(yPoints);
        plotPoints(i*yRes+1:i*yRes+yRes,3) = flip(plotY);
    else
        scanPath(i*yRes+1:i*yRes+yRes,3) = yPoints;
        plotPoints(i*yRes+1:i*yRes+yRes,3) = plotY;
    end
end
end


