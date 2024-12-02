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

%% 2 Period and Frequency

% 2.1) 
v2 = imread('verticalbars_2.tif');
%imshow(v2)
F6 = fftshift(fft2(v2));
A6 = log(1 + abs(F6));
Spec6 = A6 / max(A6(:));
figure
imshow(Spec6);

% 2.2) Written in document.

% 2.3)
v4 = imread('verticalbars_4.tif');
figure
imshow(v4)

%% 3. Importance of the spectrum and the phase angle

E1 = imread('Einstein1.jpg');
E1 = im2double(E1);

E2 = imread("Einstein2.jpg");
E2 = im2double(E2);

% 3.4)
F7 = fftshift(fft2(E1));
F8 = fftshift(fft2(E2));

angleF7 = angle(F7);
angleF8 = angle(F8);

Spec7 = abs(F7);
Spec8 = abs(F8);

E1_E2 = real(ifft2(Spec7.*exp(1i*angleF8)));
figure;
imshow(E1_E2)
imwrite(E1_E2, 'E1_E2.tif')

E2_E1 = real(ifft2(Spec8.*exp(1i*angleF7)));
figure;
imshow(E2_E1);
imwrite(E2_E1, 'E2_E1.tif')

%% Test FilterFreq

im = imread('Einstein1.jpg'); 
D01 = 40; 
[olp, ohp1, ohp2] = FilterFreq(im, D01);

% figure;
% imshow(olp, []), title('Lowpass Filtered: cutoff 40');
% figure;
imshow(ohp1, []), title('Highpass Filtered (Approach 1): cutoff 40');
figure;
imshow(ohp2, []), title('Highpass Filtered (Approach 2): cutoff 40');

% D02 = 80;
% 
% [olp_2, ohp1_2, ohp2_2] = FilterFreq(im, D02);
% 
% % figure;
% % imshow(olp_2, []), title('Lowpass Filtered: cutoff 80');
% figure;
% imshow(ohp1_2, []), title('Highpass Filtered (Approach 1): cutoff 80');
% figure;
% imshow(ohp2_2, []), title('Highpass Filtered (Approach 2): cutoff 80');


% D03 = 120;
% 
% [olp_3, ohp1_3, ohp2_3] = FilterFreq(im, D03);
% 
% % figure;
% % imshow(olp_3, []), title('Lowpass Filtered: cutoff 120');
% figure;
% imshow(ohp1_3, []), title('Highpass Filtered (Approach 1): cutoff 120');
% figure;
% imshow(ohp2_3, []), title('Highpass Filtered (Approach 2): cutoff 120');








