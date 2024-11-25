% Version 2

%% 1. Testing different box filters
testImage = imread('TestPattern.tif');
testImage = im2double(testImage);
%imshow(testImage)
matrix9 = ones(9)/9^2;
% 1.1) 
Image1 = filter2(matrix9, testImage);
figure(1);
imshow(Image1);
imwrite(Image1, 'Image1.tif');
% 1.2)
matrix21 = ones(21)/21^2;
Image2 = filter2(matrix21, testImage);
figure(2);
imshow(Image2);
imwrite(Image2, 'Image2.tif');
% 1.3)
gaussFilter = fspecial("gaussian",29,4.8);
Image3 = filter2(gaussFilter, testImage);
figure(3)
imshow(Image3)
imwrite(Image3,'Image3.tif')

% 1.4 & 1.5 Answered in document

% 1.6) 
Image4 = imfilter(testImage,matrix21,"symmetric");
figure(4)
imshow(Image4)
imwrite(Image4, 'Image4.tif')
% 1.7)
impulse = zeros(21,21);
impulse(11,11) = 1;
highpass = impulse - matrix21;
Image5 = imfilter(testImage, highpass, "symmetric");
figure(5)
imshow(Image5)
imwrite(Image5, 'Image5.tif')
meanIm5 = mean(Image5(:)) % Close to zero

% 1.8) Answered in document

% 1.9) 
Image6 = Image5 + testImage;
figure(6)
imshow(Image6);
imwrite(Image6, 'Image6.tif')

%% 2. Testing Sobel filters and graident:
testImage = imread('TestPattern.tif');
testImage = im2double(testImage);
SobX = [-1 -2 -1; 0 0 0; 1 2 1];
SobY = [-1 0 1; -2 0 2; -1 0 1];
% 2.10)
Image7 = filter2(SobX, testImage);
figure(1)
imshow(Image7)
imwrite(Image7, 'Image7.tif')
% 2.11)
Image8 = filter2(SobY, testImage);
figure(2)
imshow(Image8)
imwrite(Image8, 'Image8.tif')
% 2.12)
Image9 = sqrt((Image8.^2)+(Image7.^2));
figure(3)
imshow(Image9)
imwrite(Image9, 'Image9.tif')
%% Spatial filtering
im = imread('zoneplate.tif');
%im = im2double(im);

lp1 = fspecial('gaussian', 35, 5.8);
lp2 = fspecial('gaussian', 43, 7.2);

[olp, ohp, obr, obp, oum, ohb] = myfilter(im, lp1, lp2);

figure(1);
imshow(olp), title('Lowpass');
figure(2)
imshow(ohp), title('Highpass');
figure(3)
imshow(obr), title('Bandreject');
figure(4)
imshow(obp,[]), title('Bandpass');
figure(5)
imshow(oum), title('Unsharp Masking')
figure(6)
imshow(ohb), title('Highboost');

% subplot(2, 3, 1), imshow(olp), title('Lowpass (lp1)');
% subplot(2, 3, 2), imshow(ohp), title('Highpass');
% subplot(2, 3, 3), imshow(obr), title('Bandreject');
% subplot(2, 3, 4), imshow(imadjust(obp)), title('Bandpass (contrast stretched)');
% subplot(2, 3, 5), imshow(oum), title('Unsharp Masking');
% subplot(2, 3, 6), imshow(ohb), title('Highboost');

%% EliminateObjects 


test1 = im2double(imread('test1.tif'));
test2 = im2double(imread('test2.tif'));
test3 = im2double(imread('test3.tif'));
test4 = im2double(imread('test4.tif'));

% % test1
% figure(1);
% imshow(eliminateobjects(test1, 1)), title('Test1, q=1');
% figure(2)
% imshow(eliminateobjects(test1, 2)), title('Test1, q=2');
% figure(3)
% imshow(eliminateobjects(test1, 5)), title('Test1, q=5');
% figure(4)
% imshow(eliminateobjects(test1, 6)), title('Test1, q=6');

% % test2
% figure(1)
% imshow(eliminateobjects(test2, 1)), title('Test2, q=1');
% figure(2)
% imshow(eliminateobjects(test2, 4)), title('Test2, q=4');
% figure(3)
% imshow(eliminateobjects(test2, 6)), title('Test2, q=6');
% figure(4)
% imshow(eliminateobjects(test2, 7)), title('Test2, q=7');

% % test3
figure(1)
imshow(eliminateobjects(test3, 11)), title('Test3, q=11');
figure(2)
imshow(eliminateobjects(test3, 19)), title('Test3, q=19');
figure(3)
imshow(eliminateobjects(test3, 31)), title('Test3, qS=31');
figure(4)
imshow(eliminateobjects(test3, 43)), title('Test3, q=43');

% % test4 
% figure(1)
% imshow(eliminateobjects(test4, 2)), title('Test4, q=2');
% figure(2)
% imshow(eliminateobjects(test4, 3)), title('Test4, q=3');
% figure(3)
% imshow(eliminateobjects(test4, 5)), title('Test4, q=5');
% figure(4)
% imshow(eliminateobjects(test4, 6)), title('Test4, q=6');






