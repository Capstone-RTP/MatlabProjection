%Sample_rate of 1 seems to be best
function [paths] = getXYFromImApp(im, scale)
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

paths = cell(cc.NumObjects,1);
for j=1:cc.NumObjects
    [yi,xi] = ind2sub(size(imSkel),cc.PixelIdxList{j});

    pairedIn = [xi./4, yi./2];
    ordAndConn = zeros(length(xi),2);
    closestIdx = 1;

    for i=1:size(ordAndConn,1)-1
        ordAndConn(i,:) = pairedIn(closestIdx,:);
        pairedIn(closestIdx,:) = [];
        if(size(pairedIn,1)>1)
            closestIdx=dsearchn(pairedIn,ordAndConn(i,:));
        else
            ordAndConn(i+1,:) = pairedIn;
            if(pdist([ordAndConn(1,:);ordAndConn(end,:)])<2)
                ordAndConn(end+1,:) = ordAndConn(1,:);
            end
        end
    end
    paths{j} = ordAndConn;
end

end






