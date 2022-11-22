function [x,y] = getXYFromIm(im, scale, sample_rate)
%create surface

%function = image getXYFromIm
%extract xyz points%
image=imread(im);
imageRe = imresize(image, scale);
imBW=imbinarize(imageRe);
% imshowpair(image,imBW,'montage');
imBW=(imBW);
imComp = imcomplement(imBW);
imSkel = bwskel(imComp);


[L,n] = bwboundaries(imSkel,8);

% rc={n}
% 
% for ii=1:9
% [r c] = find(L=ii)
% rc{ii}=[r c]
% 
% scatter(r,c)
% 
% 
% 
% 
% end


for k = 1:length(L)
   boundary = L{k};
   
   plot(boundary(:,2), -boundary(:,1), 'black', 'LineWidth', 2)
   hold on
   
end


[x y] = find(imSkel);

if sample_rate ~=0
 y = downsample(y, sample_rate);
 x=downsample(x,sample_rate);
end


scatter(y,-x,".")
end






