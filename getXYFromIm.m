%Sample_rate of 1 seems to be best
function [x,y,paths] = getXYFromIm(im, scale, sample_rate)
%Create surface
%Extract xyz points%
image=imread(im);
imageGrey = rgb2gray(image);
imageRe = imresize(imageGrey, scale);
%Find black and white image
imBW=imbinarize(imageRe);
%Complement image
imComp = imcomplement(imBW);
%Skeletonize
imSkel = bwskel(imComp);
%find continuous lines
cc=bwconncomp(imSkel);

paths = cell(cc.NumObjects,1);
hold on
for j=1:cc.NumObjects
    [yi,xi] = ind2sub(size(imSkel),cc.PixelIdxList{j});

    pairedIn = [xi, yi];
    ordAndConn = zeros(length(xi),2);
    closestIdx = 1;

    for i=1:size(ordAndConn,1)-1
        ordAndConn(i,:) = pairedIn(closestIdx,:);
        pairedIn(closestIdx,:) = [];
        if(size(pairedIn,1)>1)
            [closestIdx,dist]=dsearchn(pairedIn,ordAndConn(i,:));
        else
            ordAndConn(i+1,:) = pairedIn;
            if(pdist([ordAndConn(1,:);ordAndConn(end,:)])<2)
                ordAndConn(end+1,:) = ordAndConn(1,:);
            end
        end
    end
    paths{j} = ordAndConn;
    continuousPath = paths{j};
    plot(continuousPath(:,1),continuousPath(:,2));
end
hold off



%     [L,n] = bwboundaries(imSkel,8);
%     figure; 
%     hold on
%     for k = 1:length(paths)
%         continuousPath = paths{k};
%         plot(continuousPath(:,1),continuousPath(:,2));
%     end
%     hold off

%Find points that is associaated with the solid lines
[x,y] = find(imSkel);
if sample_rate ~=0
    y = downsample(y, sample_rate);
    x=downsample(x,sample_rate);
end

end






