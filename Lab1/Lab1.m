%% 1. Basic image operations and data types
% 1.A)
Image = imread('book-cover.tif');
%imshow(Image);
max(Image(:));

% 1.B) & 1.C)
Image2 = Image/16;
max(Image2(:));
%imshow(Image2)

% 1.D) & 1.E)
Image3 = Image2*16;
figure(2)
imshow(Image3)
amounteGreyLevels1 = numel(unique(Image3));
A = uint8(0:255);
B = (A/16)*16;

% 1.F) In document

% 1.G)
doubleImage = imread('book-cover.tif');
doubleImage = im2double(doubleImage);
max(doubleImage(:));
doubleImage2 = doubleImage/16;
max(doubleImage2(:));
doubleImage3 = doubleImage2*16;
figure(1)
imshow(doubleImage3);
imwrite(doubleImage3, "doubleTest.tif")

%% 2. Contrast stretching and image histogram

% 2.A)
Image = imread('einstein-low-contrast.tif');
doubleImage = im2double(Image);
%imshow(doubleImage)
max(doubleImage(:))
min(doubleImage(:))

% 2.B)

imhist(Image)

% 2.C)
g_min = min(doubleImage(:));
g_max = max(doubleImage(:));
T_doubleImage = doubleImage - g_min;
N_doubleImage = g_max - g_min;

kvot = T_doubleImage/N_doubleImage;
K = 1;
newImage = kvot .* K;

% 2.D)
%imwrite(newImage, 'NewImage.tif');
max(newImage(:));
min(newImage(:));

% 2.E) 
imhist(newImage)

%% 3. Image subtraction
% 3.A)
Mask = imread("angiography-mask-image.tif");
Mask = im2double(Mask);
Injection = imread("angiography-live-image.tif");
Injection = im2double(Injection);
figure(1)
imshow(Mask);
figure(2)
imshow(Injection);
result = Mask - Injection
figure(3)
imshow(result)
imwrite(result, 'result.tif')
imhist(result)

%% 4. Histogram equalization
Image = imread('pollen-lowcontrast.tif');
figure(1)
imshow(Image)

newImage = histeq(Image)
%imshow(newImage)
imwrite(newImage,'ResNewIamge.tif')
imhist(newImage)

%% 5. Image division and shading correction
ImageShade = imread('Shade_pattern.tif');
ImageShade = im2double(ImageShade);
%figure(1)
%imshow(ImageShade);
%figure(2)
%imhist(ImageShade);

ImageEstimate = imread('Shade_estimate.tif');
ImageEstimate = im2double(ImageEstimate);
%figure(3)
%imshow(ImageEstimate);
%figure(4)
%imhist(ImageEstimate);

PerfectImage = ImageShade./ImageEstimate;
%imshow(PerfectImage)
imwrite(PerfectImage,'PerfectImage.tif');

imhist(PerfectImage);
%BW = imbinarize(PerfectImage, 0.3);
T = 0.3;
BW = PerfectImage>T;
%imshow(BW);
imwrite(BW, 'BW.tif');

bytes = (1024*1024)/1048576

%% 6. RGB-images and indexing
I = zeros(400,600,3);

I(150:250,:,1) = 1;
I(150:250,:,2) = 1;
I(:,100:200,1) = 1;
I(:,100:200,2) = 1;
I(1:150,1:100,3) = 1;
I(1:150,200:600,3) = 1;
I(250:400,200:600,3) = 1;
I(250:400, 1:100,3) = 1;
imwrite(I,'flagga.tif')

%% Testing GammaCorrection

% OImage = imread('spillway-dark.tif');
% 
% GImage1 = GammaCorrection(OImage, 0.4, 0.1, 0.9);
% GImage2 = GammaCorrection(OImage, 0.7, 0.1, 0.9);
% GImage3 = GammaCorrection(OImage, 0.4, 0.1, 0.1);
% max(GImage1(:));
% figure(1);
% imshow(GImage1)
% figure(2);
% imshow(GImage2)
% figure(3);
% imshow(GImage3)
% 
OImage2 = imread('aerialview-washedout.tif');

G2Image1 = GammaCorrection(OImage2, 0.4, 0.1, 0.9);
G2Image2 = GammaCorrection(OImage2, 1.5, 0.1, 0.9);

figure(1)
imshow(G2Image1)
figure(2)
imshow(G2Image2)

% Image = imread('IntensityRampGamma25.tif');
% Image2 = imread("IntensityRamp.tif")
% 
% figure(1)
% imshow(Image2)
% GImage = GammaCorrection(Image, 0.3, 0, 1);
% figure(2)
% imshow(GImage)

%% Testing LevelSlicing

RGB_Image = imread("RGBflower.tif");
IR_Image = imread('IRflower.tif');

LevelSlicing(RGB_Image, IR_Image, 10);

















