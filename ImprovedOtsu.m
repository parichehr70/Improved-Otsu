clc;clear;
I=im2double(imread('101_3.tif'));
counts = imhist(I,256);
p = counts / sum(counts);
Pr0 = cumsum(p);
TMean = cumsum(p .* (1:256)');
TotalMean = TMean(end);
OVar=(Pr0 .* (1 - Pr0)).*(((TMean./Pr0)-((TotalMean-TMean)./(1-Pr0))).^2);
MaxOVal = max(OVar);
Index = find(OVar == MaxOVal);
OtsuLevel = (Index - 1) / (255);
NVar=(Pr0 .* (1 - Pr0)).*(((TMean./Pr0)-((TotalMean-TMean)./(1-Pr0))).^2 +((TMean./Pr0)-TotalMean).^2 +(((TotalMean-TMean)./(1-Pr0))-TotalMean)).^2;
MaxNVal = max(NVar);
Index = find(NVar == MaxNVal);
NewLevel = (Index - 1) / (255);
OtsuImage=im2bw(I,OtsuLevel);
NewImage=im2bw(I,NewLevel);
subplot(1,2,1)
imshow(OtsuImage);
title('Otsu method')
subplot(1,2,2)
imshow(NewImage);
title('New method')
