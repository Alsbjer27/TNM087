Image1a = imread("Image1a.tif");
[H, teta, ro] = hough(Image1a,"RhoResolution",5,"Theta",-90:0.5:89.5);
figure;
imshow(Image1a)


% Prep 1: 
H_min = min(H(:));
H_max = max(H(:));
T_H = H - H_min;
N_H = H_max - H_min;
kvot = T_H / N_H;
K = 1;

H1 = kvot .* K;
figure;
imshow(H1);
imwrite(H1, 'H1.tif')

% Prep 2: Written in document

% Prep 3: 
[r,t] = find(H==max(H(:)));
maxAngle = teta(t);
distH1 = ro(r);

% Prep 4: 
Image1a_rotated = imrotate(Image1a,-25,"bicubic");
figure;
imshow(Image1a_rotated);
imwrite(Image1a_rotated,'Image1a_rotated.tif');

% Prep 5:
Image1b = imread("Image1b.tif");




