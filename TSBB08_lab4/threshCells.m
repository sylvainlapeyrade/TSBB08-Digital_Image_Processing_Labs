im = imread('cells.tif');
histo = hist(im(:),[0:255]);
T = mean(mean(im))

Tmid = mid_way(histo, T)
%Tmid = 52
imTmid = im>Tmid;

Tmid2 = least_error(histo, T)
imTmid2 = im>Tmid2;

figure(1)
colormap(gray(256))
subplot(2,2,1), imagesc(im, [0 255]);
axis image; colorbar
title('original image');
subplot(2,2,2), plot(0:255, histo, '.-r');
axis tight; grid
title('histogram');
subplot(2,2,3), imagesc(imTmid, [0 1]);
axis image; colorbar
title('mid-way thresholded image'); 
subplot(2,2,4), imagesc(imTmid2, [0 1]);
axis image; colorbar
title('least-error thresholded image');