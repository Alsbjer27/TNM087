%% 1. 2D Fourier spectrum

cTP = imread('characterTestPattern.tif');
cTP = im2double(cTP);
figure;
imshow(cTP)
% 1.1) 
% Log transformation
F1 = fftshift(fft2(cTP));
A1 = log(1+abs(F1));
Spec1 = A1/max(A1(:));
figure;
imshow(Spec1)
%imwrite(Spec1, 'Spec1.tif')
% 1.2)
cTP_shift = circshift(cTP,[100,-200]);
figure;
imshow(cTP_shift)
F2 = fftshift(fft2(cTP_shift));
A2 = log(1 + abs(F2));
Spec2 = A2/max(A2(:));
figure;
imshow(Spec2)
imwrite(Spec2, 'Spec2.tif')

% 1.3) Written in document.

% 1.4)
cTP_rot = imrotate(cTP, 15, 'bicubic');
figure;
imshow(cTP_rot)
F3 = fftshift(fft2(cTP_rot));
A3 = log(1 + abs(F3));
Spec3 = A3/max(A3(:));
figure;
imshow(Spec3)
imwrite(Spec3,'Spec3.tif')

% 1.5) Written in document.

% 1.6)

cTP2 = imread('characterTestPattern_2.tif');
cTP2 = im2double(cTP2);
F4 = fftshift(fft2(cTP2));
A4 = log(1 + abs(F4));
Spec4 = A4/max(A4(:));
figure;
imshow(Spec4);
imwrite(Spec4, 'Spec4.tif');

% 1.7) Written in document.

% 1.8) Written in document.

% 1.9) 
cTP3 = imread("characterTestPattern_3.tif");
cTP3 = im2double(cTP3);
figure
imshow(cTP3)
F5 = fftshift(fft2(cTP3));
A5 = log(1 + abs(F5));
Spec5 = A5 / max(A5(:));
figure;
imshow(Spec5);
imwrite(Spec5,'Spec5.tif')









