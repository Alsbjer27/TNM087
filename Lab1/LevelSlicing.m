function [RGB_Range, IR_Select] = LevelSlicing( RGB_Image, IR_Image, LevelRange)
%function GImage = LevelSlicing( RGB_Image, IR_Image, LevelRange )

%% LAB2, TASK3
%   Implement intensity level slicing on an RGB-image, with the range defined from an IR-image:
%   Slect a reference intensity value from the IR image
%   Compute the range of intensity levels of interest 
%   Use the defined intensity range from the IR-image to mask out the corresponding areas in the RGB-image
%   the result is the double image GImage with maximum gray value one
%
%% Who has done it
%
% Authors: Emil Alsbjer, emial133
%          Victor Ström, vicst918
% Same LiU-IDs/names, as in the Lisam submission
% You can work in groups of max 2 students
%
%% Syntax of the function
%
%   Input arguments:
%       RGB_Image: RGB color image of type uint8 or double
%       IR_Image: Infrared intensity image of type uint8, uint16 or double
%       LevelRange: The range of intensity levels to select (defined in % of total intensity range)
%   Output argument: 
%       RGB_Range: RGB image of type double, displaying the selected intensity range
%       IR_Select: RGB image of type double, displaying the position of the
%       selected pixel in the IR-image

% You MUST NEVER change the first line
%
%% Important rule
% Don't change the structure of the template by removing %% lines
%
%% Image size and image class handling
%
[nr,nc,nch] = size(RGB_Image); % Number of rows, columns and channels in the image


%% Show the IR image to select a pixel with reference intensity value

fh1=figure; imshow(IR_Image);
set(fh1,'NumberTitle','off','Name','Select a pixel for reference intensity level')
[x,y] = ginput(1); % x and y are the coordinates of the reference pixel 

% Note that x and y are not the same as row and column! 
% Refer to the help-section for the function ginput for reference

%% Find the selected intensity range from the IR image
% Based on the coordinates of the selected pixel (expressed in x,y )
% find the selected intensity level. Then compute the selected intensity range,
% based on the vaiable LevelRange
intensity = 
Lower = ... % The lowest intensity value in the selected range
Higher = ... % The highest intensity value in the selected range
    
%% Mask out the areas ine th RGB image, based on the selected intensity range in the IR image
% Compute a mask (binary image) from the IR image, which is ONE only where IR<Higher & IR>Lower

Mask = ... %
    
% Use the Mask to mask out the areas within ths selected IR-range in the RGB-images
% (for all 3 color channels)

RGB_Range = ... %
    
%% Show the selected pixel in the IR-image
% Crete an image that shows the position of the selected pixel in the IR-image, using a red mark.
% Marking just a sngle pixel is difficult to see in the image. Use at least a 5x5 pixel area 
% if you use a square. You can also consider marking the pixel with a cross, or some other shape

IR_Select=cat(3,IR_Image,IR_Image,IR_Image);

% This create an RGB image. Since the color channels are identical, it will
% be displayed in grayscale (exept for the red mark). 
% Now modify IR_select to mark the selected pixel in red!

IR_Select(...) = ...
    

%% Display the result
% The result is displayed. Use the following names and formats:
% RGB_Image - Input RGB image (3 channels)
% RGB_range - Output RGB image, displying the selected range (3 channels)
% IR_select - Output image showing the selected pixel position (3 channels)
% Mask - Binary image marking the selected intensity range in IR_Image (1 channel)

fh2=figure;
montageimage = zeros(nr,nc,nch,4);
montageimage(:,:,:,1) = RGB_Image;
montageimage(:,:,:,2) = RGB_Range;
montageimage(:,:,:,3) = IR_Select;
montageimage(:,:,:,4) = cat(3,Mask,Mask,Mask);
montage(montageimage)
set(fh2,'NumberTitle','off','Name','RGB / RGB: selected range/ IR: selected pixel / IR: mask')


%% Test your code:
% Read the image 'RGBflower.tif' (using imread) and call it RGB_Image
% Read the image 'IRflower.tif'  and call it IR_Image
%
% Call your function, using: LevelSlicing(RGB_Image,IR_Image,10);
%
% Select pixels in different positions in the image and make sure to include pixels far to the RIGHT  
% Make sure that your resulting images 'RGB_Image', 'RGB_Range', 'IR_Select' and
% 'Mask' are displayed correct, independenly of the position of the selected pixel (compare Fig.1
% in the instruction). Make sure that the red mark in IR_select is
% clearly visible and that the position corrsponds to the selected pixel!

%% Control question
% Before you hand in your code:
% 
% Have you tested your code accordiing to the instructions above that and made sure that it works correctly 
% also when selecting a pixel to the far RIGHT side, that the red mark is clearly 
% visible and located at the correct position? 
% Your answer: 
%
% If 'no': your code is not functioning correctly and needs to be fixed before submission. 
% In that case, ask the teachers for clarification before submitting the code.
%
% If 'yes': Well done! Submit your code, togehter with the
% files 'Lab 1.1 Preparation Answers' and 'GammaCorrection.m'.

