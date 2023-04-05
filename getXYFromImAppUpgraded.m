%Sample_rate of 1 seems to be best
function [paths] = getXYFromImAppUpgraded(im, scale,xRed,yRed)
%Create surface
%Extract xyz points%
image=imread(im);
imageGrey = im2gray(image);
imageRe = imresize(imageGrey, scale);
%Find black and white image
imBW=imbinarize(imageRe);
%Complement image
imComp = imcomplement(imBW);
%Skeletonize
imSkel = bwskel(imComp);
imSkel = flipud(imSkel);
%find continuous lines
cc=bwconncomp(fliplr(imSkel));
foundPaths=1;
paths = cell(cc.NumObjects,1);
dist=0;
for j=1:cc.NumObjects
    [yi,xi] = ind2sub(size(imSkel),cc.PixelIdxList{j});
    pairedIn = [xi./xRed, yi./yRed];
    while size(pairedIn,1)>1
        ordAndConn = zeros(size(pairedIn,1),2);
        closestIdx = 1;
        for i=1:size(pairedIn,1)-1
            ordAndConn(i,:) = pairedIn(closestIdx,:);
            pairedIn(closestIdx,:) = [];
            if(size(pairedIn,1)>1)
                [closestIdx,dist]=dsearchn(pairedIn,ordAndConn(i,:));
            elseif(size(pairedIn,1)==1)
                ordAndConn(i+1,:) = pairedIn;
                pairedIn = [];
                if(pdist([ordAndConn(1,:);ordAndConn(end,:)])<2)
                    ordAndConn(end+1,:) = ordAndConn(1,:);
                end
            end
            if(dist>2)
                break;
            end
        end
        if(dist<2)
            ordAndConn( ~any(ordAndConn,2), : ) = [];
            paths{j} = ordAndConn;
        else
            ordAndConn( ~any(ordAndConn,2), : ) = [];
            paths{cc.NumObjects +foundPaths} = ordAndConn;
            foundPaths=foundPaths+1;
        end
    end
end
paths = paths(~cellfun(@isempty, paths));
hold on
for j=1:length(paths)
    continuousPath = paths{j};
    plot(continuousPath(:,1),continuousPath(:,2))
end
hold off
end






