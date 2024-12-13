function [IMG, nofr]=CountBrickRows(in)
%
% function [IMG, nofr]=CountBrickRows(in)
%
%% Lab4, Task 2
%% Finds the number of rows of bricks
%
% Finds the number of rows of bricks in a brick wall image, that might be
% rotated. Therefore, in the first step, this function rotates the input
% image to the horizontal level. In he second step, the function finds the
% number of rows of bricks.
%
%% Who has done it
%
% Author: Emil Alsbjer, emial133
% Co-author: Victor Ström, vicst918
%
%% Syntax of the function
%      Input arguments:
%           in: the original input color image of type double scaled between 0 and 1
%          
%      Output arguments:
%           IMG: the output color image, which is the input image rotated
%           to the horizontal level.
%           nofr: the number of rows of bricks in the input image
%
%%
% You MUST NEVER change the first line
%
%% General rules
% Don't change the structure of the template by removing %% lines
%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%
%% First step of the task. Rotate the input image to the horizontal level
%
%% Make the input color image grayscale, 
% by choosing its most appropriate channel (according to the instructions)


bgray= in(:,:,3); % The grayscale version of the input color image

%% Lowpass filter your image
lowPassFilter = ones(5)/25;
bfilt=imfilter(bgray,lowPassFilter,"symmetric"); ; % The filtered version of the grayscale image
    
%% Threshold your image
% to separate the mortar joints from the bricks
otsu = graythresh(bfilt);

b_thresh = imbinarize(bfilt, otsu); % The thresholded image

%% Use Hough transform to find the angle corresponding to the principal lines

[H, teta1, ~] = hough(b_thresh,"RhoResolution",5,"Theta",-90:0.5:89.5);
[~,t] = find(H==max(H(:)));
teta = teta1(t); % The angle corresponding to the principal lines (rows of mortar joints)
    
%% Find the angle of rotation, to rotate the image to the horizontal level
% Make sure that you use right sign in front of the angle (positive for
% counterclockwise and negative for clockwise rotation)

trot = teta - 90*sign(teta); % Angle of rotation.
% disp(trot)
% disp(teta)
    % If the rotation is counreclockwise, trot should be positive, otherwise negative. 

%% Rotate the input image to the horizontal level
% This gives you the first output argument of the function

IMG= imrotate(bgray, trot, "bicubic",'crop'); % The rotated image to the horizontal level (the first output argument of this funciton)
% Before continuing to the next step, make sure that your code works
% properly so far. See the instructions.
% figure;
% imshow(IMG);
%% Second step of the task. Find the number of rows of bricks
%
%% Rotate the thresholded image to the horizontal level.
% Use nearest interpolation to make sure that the rotated image will be
% binary

b_rot= imrotate(b_thresh, trot, "nearest"); % The rotated thresholded image
% View this image, but remove or comment before submitting the
% file

%% Find the number of 1:s in each row (and normalize according to the instructions)

sum_row= sum((b_rot')/size(bgray,2)); % The number of ones in each row
% Display this graph by plot, but remove or comment before submitting the
% file

%% Threshold your result according to the instructions
% This is to define a row of mortar joint

sum_thresh= imbinarize(sum_row,0.6); % The thresholded version of sum_row
% Display this graph by plot, but remove or comment before submitting the
% file
% figure;
% plot(sum_thresh);
%% Find the number of rows of bricks
% Calculate how many times the above graph (sum_thresh) goes from 0 to 1 by using the
% first derivative according to the instructions

krn = [-1, 1];
numBr = filter2(krn, sum_thresh,"same");
% figure;
% plot(numBr);

nofr= sum(numBr == 1)-1; % The number of rows of the bricks (the seond output argument of this function)

%% Test your code on three test images
% Use the three given test images, brick1.jpg, brick2.jpg and brick3.jpg
% according to the instructions in the document describing this task.
% Your code is supposed to work properly on all three images.
%
%% Questions
%
% Before answering the questions, ensure you have tested your code according to the 
% instructions. 
% 
% First, read the test images 'brick1.jpg', 'brick2.jpg' and 'brick3.jpg' in MATLAB and 
% normalize them to the range [0, 1].
% 
% Now for the questions:
%
% 1. The image "brick1" is already oriented correctly and should not be rotated.
% However, there is a possibility that you may have rotated it by 180 degrees.
% To ensure this hasn’t occurred, check that the rotation angle (trot) is zero.
% Have you checked the resulting image for "brick1" and verified that it is not rotated, 
% with the rotation angle confirmed as zero?
% (Answer 'yes' or 'no'. If 'no', please correct it!)
% Your answer: Yes, disp(trot) for brick1 gave 0
%
%
% 2. Have you verified that your code results in exactly 12 rows of bricks in "brick1"?
% (Answer 'yes' or 'no'. If 'no', review the instructions carefully, and consult your 
% teacher if you're unable to identify the issue in your code.)
% Your answer: Yes, nofr for brick1 is 12
%
%
% 3. Have you checked that your code correctly rotates the image "brick2" to a horizontal position?
% (Answer 'yes' or 'no'. If 'no', review the instructions carefully and consult your 
% teacher if you're unable to identify the issue in your code.)
% Your answer: Yes, disp() after trot
%
%
% 4. Have you verified that your code produces exactly 10 rows of bricks in "brick2"?
% (Answer 'yes' or 'no'. If 'no', review the instructions carefully and consult your 
% teacher if you're unable to identify the issue in your code.)
% Your answer: Yes, nofr for brick2 = 10
%
%
%
% 5. Have you checked that your code correctly rotates the image "brick3" to a horizontal position?
% (Answer 'yes' or 'no'. If 'no', review the instructions carefully and consult your 
% teacher if you're unable to identify the issue in your code.)
% Your answer: Yes, disp() after trot
%
%
% 6. Have you verified that your code produces exactly 10 rows of bricks in "brick3"?
% (Answer 'yes' or 'no'. If 'no', review the instructions carefully and consult your 
% teacher if you're unable to identify the issue in your code.)
% Your answer: Yes, nofr for brick3 = 10
%
%