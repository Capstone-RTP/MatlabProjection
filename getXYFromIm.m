%Sample_rate of 1 seems to be best
function [x,y] = getXYFromIm(im, scale, sample_rate)
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

%     [L,n] = bwboundaries(imSkel,8);
%
%     for k = 1:length(L)
%         boundary = L{k};
%
%         plot(boundary(:,2), -boundary(:,1), 'black', 'LineWidth', 2)
%         hold on
%
%     end

%Find points that is associaated with the solid lines
[x,y] = find(imSkel);
if sample_rate ~=0
    y = downsample(y, sample_rate);
    x=downsample(x,sample_rate);
end

% figure
% scatter(y,-x,".")
% axis equal
end






