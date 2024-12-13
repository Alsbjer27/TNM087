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

% figure;
% imshow(Image1c_2);
% imwrite(Image1c_2,'Image1c_2.tif');

% Prep 10:
SE2 = strel('line', 6, 0);
Image1c_clean = imopen(Image1c_2, SE2);
% figure;
% imshow(Image1c_clean)
% imwrite(Image1c_clean, 'Image1c_clean.tif');

% Prep 11:
% a)
SE3 = strel('disk',11);
Image1c_3 = imopen(Image1c_clean, SE3);
% figure;
% imshow(Image1c_3);

% b)
MN = [15 100];
SE4 = strel('rectangle', MN);
Image1c_4 = imopen(Image1c_clean, SE4);
% figure;
% imshow(Image1c_4);

% c)
SE5 = strel("disk", 18, 0);
Image1c_5 = imopen(Image1c_clean, SE5);
% figure;
% imshow(Image1c_5);

% d) 
[r,c] = size(Image1c);
ImageDiskSum = Image1c_3 - Image1c_5;
RGB = zeros(r,c,3);
RGB(:,:,1) = Image1c_4;
RGB(:,:,2) = Image1c_5;
RGB(:,:,3) = ImageDiskSum;
% figure;
% imshow(RGB);
% imwrite(RGB,'RGB.tif');

% Prep 12: Inte löst ännu
ErodeRGB = imerode(RGB,SE5);
% figure;
% imshow(ErodeRGB);

% Prep 13: 
RiceImage1 = imread("rice-shaded.tif");
RiceImage1 = im2double(RiceImage1);
SE6 = strel('disk', 40);
RiceImage2 = imopen(RiceImage1, SE6);

T_hat = RiceImage1 - RiceImage2;
figure;
imshow(T_hat)

level = graythresh(T_hat);
RiceImage3 = T_hat > level;
figure;
imshow(RiceImage3)
imwrite(RiceImage3, 'RiceImage3.tif');

%% Labelling and objct features

% Prep 14:
L = bwlabel(Image1c_clean);
% figure;
% imshow(L,[]);

% Prep 15: 
stats = regionprops(L,'Perimeter','Area','EulerNumber');

for n=1:length(stats)
 Perimeter(n) = stats(n).Perimeter; 
 Area(n) = stats(n).Area;
 Euler(n) = stats(n).EulerNumber;
end

Large0 = find(Area > 7500);
Large0_Im = zeros(r,c);

for n = 1:length(Large0)
    Large0_Im(L==Large0(n))=1;
end

% figure;
% imshow(Large0_Im);
% imwrite(Large0_Im, 'Large0_Im.tif');

% Prep 16: Not Done
hist(Perimeter);

thresh = 150;

% Prep 17: Separera objekt med största omkrets och utan hål
% Filtrera objekt med stor omkrets
SelectedObjects = find(Perimeter > thresh & Euler == 1);

% Skapa en ny bild för de utvalda objekten
SelectedObjects_Im = zeros(r, c);
for n = 1:length(SelectedObjects)
    SelectedObjects_Im(L == SelectedObjects(n)) = 1;
end

% Visa och spara resultatet
figure;
imshow(SelectedObjects_Im);
imwrite(SelectedObjects_Im, 'SelectedObjects_Im.tif');

% Hämta etiketterna för de valda objekten
Labels_Selected = SelectedObjects;
disp('Etiketter för de valda objekten:');
disp(Labels_Selected);


%% CountBrickRows Testing
% brick1 = imread("brick1.jpg");
% [IMG1, nofr1] = CountBrickRows(brick1);

% brick2 = imread("brick2.jpg");
% [IMG2, nofr2] = CountBrickRows(brick2);

brick3 = imread("brick3.jpg");
[IMG3, nofr3] = CountBrickRows(brick3);

%% CountObjects
MacnRice1 = imread("MacnRice1.tif");
MacnRice1 = im2double(MacnRice1);
[IMG1, noRice1, noSmallMacs1, noLargeMacs1]=CountObjects(MacnRice1);
figure;
imshow(IMG1);

MacnRice2 = imread("MacnRice2.tif");
MacnRice2 = im2double(MacnRice2);
[IMG2, noRice2, noSmallMacs2, noLargeMacs2]=CountObjects(MacnRice2);
figure;
imshow(IMG2);

MacnRice3 = imread("MacnRice3.tif");
MacnRice3 = im2double(MacnRice3);
[IMG3, noRice3, noSmallMacs3, noLargeMacs3]=CountObjects(MacnRice3);
figure;
imshow(IMG3);



