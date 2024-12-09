%% Hough Transform

Image1a = imread("Image1a.tif");
[H1, teta1, ro1] = hough(Image1a,"RhoResolution",5,"Theta",-90:0.5:89.5);
figure;
imshow(Image1a)


% Prep 1: 
H1_min = min(H1(:));
H1_max = max(H1(:));
T_H1 = H1 - H1_min;
N_H1 = H1_max - H1_min;
kvot1 = T_H1 / N_H1;
K = 1;

H1_Image = kvot1 .* K;
figure;
imshow(H1_Image);
imwrite(H1_Image, 'H1.tif')

% Prep 2: Written in document

% Prep 3: 
[r1,t1] = find(H1==max(H1(:)));
maxAngle = teta1(t1);
distH1 = ro1(r1);

% Prep 4: Written in document

% Prep 5: 
Image1a_rotated = imrotate(Image1a,-25,"bicubic");
figure;
imshow(Image1a_rotated);
imwrite(Image1a_rotated,'Image1a_rotated.tif');

% Prep 6:
Image1b = imread("Image1b.tif");

[H2, teta2, ro2] = hough(Image1b,"RhoResolution",5,"Theta",-90:0.5:89.5);
figure;
imshow(Image1b)

H2_min = min(H2(:));
H2_max = max(H2(:));
T_H2 = H2 - H2_min;
N_H2 = H2_max - H2_min;
kvot2 = T_H2 / N_H2;

H2_Image = kvot2 .* K;
figure;
imshow(H2_Image);
imwrite(H2_Image,'H2Image.tif');

[r2,t2] = find(H2==max(H2(:)));
maxAngle2 = teta2(t2);

% Prep 7: 
Image1b_rotated = imrotate(Image1b,15,"bicubic");
figure;
imshow(Image1b_rotated);
imwrite(Image1b_rotated,'Image1b_rotated.tif');

%% Morphology
% Prep 9: 
Image1c = imread('Image1c.tif');
SE1 = strel('disk', 3);

Image1c_1 = imopen(Image1c, SE1);
Image1c_2 = imclose(Image1c_1, SE1);

figure;
imshow(Image1c_2);
imwrite(Image1c_2,'Image1c_2.tif');

% Prep 10:
SE2 = strel('line', 6, 0);
Image1c_clean = imopen(Image1c_2, SE2);
figure;
imshow(Image1c_clean)
imwrite(Image1c_clean, 'Image1c_clean.tif');

% Prep 11:
% a)
SE3 = strel('disk',11);
Image1c_3 = imopen(Image1c_clean, SE3);
figure;
imshow(Image1c_3);

% b)
MN = [15 100];
SE4 = strel('rectangle', MN);
Image1c_4 = imopen(Image1c_clean, SE4);
figure;
imshow(Image1c_4);

% c)
SE5 = strel("disk", 15, 0);
Image1c_5 = imopen(Image1c_clean, SE5);
figure;
imshow(Image1c_5);

% d) 
[r,c] = size(Image1c);
ImageDiskSum = Image1c_3 - Image1c_5;
RGB = zeros(r,c,3);
RGB(:,:,1) = Image1c_4;
RGB(:,:,2) = Image1c_5;
RGB(:,:,3) = ImageDiskSum;
figure;
imshow(RGB);
imwrite(RGB,'RGB.tif');

% Prep 12: 











