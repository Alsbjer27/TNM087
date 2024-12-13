function [IMG, noRice, noSmallMacs, noLargeMacs]=CountObjects(in)
%% Lab4, Task 3
%% Finds the number objects belonging to different classes
%
% Counts objects of different class and displays boundaries in different colors. 
% Input images containing three classes of ojects: grains of rice, snall
% macaronis and large macaronis
%
%% Who has done it
%
% Author: Emil Alsbjer, emial133
% Co-author: Victor Ström, vicst918
%
%
%% Syntax of the function
%      Input arguments:
%           in: the original input RGB color image of type double scaled between 0 and 1
%          
%      Output arguments:
%           IMG: the output RGB color image, displaying the boundaries of 
%              three diffferent classes of objects in different colors.
%           noRice: Number of grains of rice in the input image
%           noSmallMacs: Number of small macaromis in the input image
%           noLargeMacs: Number of large macaromis in the input image
%
% You MUST NEVER change the first line
%
%% General rule
% Don't change the structure of the template by removing %% lines
%

%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%

%% Make the input color image grayscale, 
% by choosing its most appropriate channel 

bgray = in(:,:,3); % The grayscale version of the input color image
    
%% Threshold your image
% to separate the objects from the backgroound
% Make sure that the objects are white (value 1) and backround blaxk (0)
otsu = graythresh(bgray);
b_thresh = bgray < otsu; % The thresholded image
    
%% Clean up the binary image 
% Use morphological operations to clean up the binary image from noise. 
% Especially make syre that your cleaned image don't contain any false object
% (i.e. single foreground pixels, or groups of connected foreground pixels, 
% that do not belong to the object classes  
SE = strel('disk',4);

im_open = imopen(b_thresh, SE);
im_close = imclose(im_open, SE);
b_clean = im_close; % Cleaned up binary image

%% Labelling
%  Use labelling to assign every object a unique number

L = bwlabel(b_clean); % Labelled image
%% Object features
% Compute relevant object features that you can use to classify 
% the three classes of objects

Stats = regionprops(L, "Area"); % Create struct with relevant object properties
Area = [Stats.Area];
figure;
histogram(Area, 20); % Adjust bins as needed
title('Area Distribution');
xlabel('Area');
ylabel('Frequency');
%% Object classification
% Based on your object features, classify the objects, i.e. for each
% labelled object: decide if it belongs to the three classes: Rice, SmallMacs, or LargeMacs 
% In case you didn't suceed in cleaining up all false objects, you should
% discard them here, so they don't count as the classes of objects

Rice = find(Area < 1000); % Vector containing the labels of all objects classifies as rice
SmallMacs = find(Area > 2000 & Area < 5000); % Vector containing the labels of all objects classifies as SmallMacs
LargeMacs = find(Area > 6000); % Vector containing the labels of all objects classifies as LargeMacs
disp(SmallMacs)
%% Count the objects for each class.

noRice = length(Rice); % Number of rices
noSmallMacs = length(SmallMacs); % Number of small macoronis
noLargeMacs = length(LargeMacs); % Number of large macoronis

%% Create an RGB-image, IMG, displaying the bouandaries of different classes in different colors
% Use boundary extraction to determine object boundaries. Display object
% boundaries  using different colors for each class. Boundaries can be
% displayed either on a black background, or highlighed in the original image

%% Create an RGB-image, IMG, displaying the boundaries of different classes in different colors
% Extract boundaries for each class
[r, c] = size(L);

% Initialize RGB image with black background
IMG = zeros(r, c, 3);

% Red for Rice
RiceBoundaries = bwperim(ismember(L, Rice));
IMG(:, :, 1) = RiceBoundaries; % Red channel

% Green for Small Macaroni
SmallMacsBoundaries = bwperim(ismember(L, SmallMacs));
IMG(:, :, 2) = SmallMacsBoundaries; % Green channel

% Blue for Large Macaroni
LargeMacsBoundaries = bwperim(ismember(L, LargeMacs));
IMG(:, :, 3) = LargeMacsBoundaries; % Blue channel 
% Output RGB-image displaying the three classes of objects in different colors


%% Questions
%
% Before answering the questions, ensure you have tested your code according to the 
% instructions. 
% 
% Read the test images 'MacnRice1.tif', 'MacnRice2.tif' and 'MacnRice3.tif' in MATLAB and 
% normalize them to the range [0, 1]. Use them to test your code. 
% 
% Now for the questions:
%
% 1. For all the images "MacnRice1", MacnRice2, MacnRice3: 
% Have you checked the resulting images displays the
% BOUNDARIES of all objects in different colors, depeding on class?
% % (Answer 'yes' or 'no'. If 'no', please correct it!)
% Your answer: Yes
%
% 2. For all three images MacnRice1, MacnRice2, MacnRice3:
% Have you confirmed that your code returns the correct number for each
% class:

% Image          noRice   noSmallMacs   noLargeMacs
% MacnRice1.tif  48       12            6
% MacnRice2.tif  60       14            6
% MacnRice3.tif  42       11            5

% Your answer: Yes
% If 'no': your code is not functioning correctly and needs to be fixed before submission. 
% In that case, ask the teachers for clarification before submitting the code.

% If 'yes': Well done! Submit your code, togehter with the
% files 'Lab 4.1 Preparation Answers' and 'CountBrickRows.m'.


