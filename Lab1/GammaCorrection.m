function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )
%function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )

%%  Lab 1 Task 2
%   Implement gamma correction:
%   Truncate the original gray values using lower and upper quantiles
%   (Lower, Upper) and then apply gamma correction with exponent Gamma 
%   to the input image OImage,
%   The result is the double image GImage with maximum gray value one
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
%       OImage: Grayscale image of type uint8 or double
%       Gamma: exponent used in the gamma correction, 
%       Lower: value in the range 0, 1
%       Upper: value in the range 0, 1 and lower < upper
%       Lower and Upper are quantile values. 
%   Output argument: GImage: gamma corrected gray value image of type double
%
% You MUST NEVER change the first line
%

%% Important rule
% Don't change the structure of the template by removing %% lines
%
%% Image class handling
% Make sure that you can handle input images of class uint8, uint16 and double 
ReadImage = im2double(OImage);

%% Compute lower and upper gray value boundaries. 
% Use the parameteers Lower and Upper to find the corresponding gray values for the boundaries
% (look at the help function for the command 'quantile')
% The quantile values should be computed for the full mage, not for rows or columns. 
% This is similar to how you computes max- and minvalues in preparation 1A 

lowgv = quantile(ReadImage(:),Lower); % Lower-bound gray value
uppgv = quantile(ReadImage(:),Upper); % Upper-bound gray value

%% Compute a scaled version of the image, where: 
% the lower-bound gray value is zero 
% the upper-bound gray value is one 
% Then make sure that the range of ScaledImage is [0,1] by setting all 
% pixels<0 to 0 and all pixels >1 to 1

ScaledImage = (ReadImage-lowgv)/(uppgv-lowgv);
ScaledImage = min(ScaledImage, 1);
ScaledImage = max(ScaledImage, 0);

%% Gamma mapping of the previous result 
% Make sure that ScaledImage is in the range [0,1] before applying gamma
% correction! You can e.g. use min(ScaledImage(:)) and max(ScaledImage(:))
% No for-loops should be used!

GImage = ScaledImage.^Gamma; % apply gamma correction (which is an elementwise operation)


%% Test your code

% Read the image 'spillway-dark.tif' (using imread) and call it OImage
% Call your function, using:
% GImage = GammaCorrection(Oimage, 0.4, 0.1, 0.9);
% Display GImage (using imshow) to make sure that it looks ok.

% If you get the warning: "Displaying real part of complex input" 
% it means that the image "ScaledImage" has negative values which causes
% complex numbers after gamma-correction. This must be fixed by making sure
% that "ScaledImage" is truncated to the range [0,1]

% Confrim that the min-value of GImage is >=0: min(GImage(:))
% Confrim that the max-value of GImage is <=1: max(GImage(:))


%% Experiments with your code
%
% Use your code to modify the images 'aerialview-washedout.tif' and
% 'spillway-dark.tif' for different values for Gamma, Lower and Upper
% Write some comments on your experiments and propose some good parameters
% to use (don't forget to comment your text)
% 
% 'spillway-dark.tif':
% With Gamma=0.4, Lower=0.1, Upper=0.9 as reference image we can see that
% with Gamma=0.4, Lower=0.5, upper=0.9 that we lose the bright pixels
% If we instead increase the gamma value so we have 
% Gamma=0.9, Lower=0.1, Upper=0.9 the image gets higher contrast.
% With a lower value at Upper such as 0.3 we lose majorty of dark pixels
% 
%
% 'aerialview-washedout.tif'
% This was more difficult to determine good parameters. However we feel
% that with the values Gamma=0.7, Lower=0.1, Upper=0.9 we get sufficient
% contrast between the buildings and streets in order to be able to
% seperate them. However we can still make the Gamma values much higher and
% still achieve the same amount of detail, for example with a Gamma=1.5
%
%
%
% The image 'IntensityRampGamma25.tif' illustrates the effect of an intensity
% ramp displayed on a monitor with gamma =2.5. 
% Which value for gamma should you use in your code to correct the image to appear as a linear intensity ramp?
% (Set Lower=0 and Upper=1)
% Gamma = Approximately 0.35 - 0.45

%% Control question
% Before you hand in your code:
% 
% Have you tested your code accordiing to the instructions above and confirmed
% that GImage is in the range [0,1] and can be displayed (using imshow) without warnings?
% Answer 'yes' or 'no'.
% Your answer: yes
% max(GImage(:)) = 1;
% min(GImage(:)) = 0;
%
% If 'no': your code is not functioning correctly and needs to be fixed before submission. 
% In that case, ask the teachers for clarification before submitting the code.
% If 'yes': feel free to submit your code (after finishing also part 1 and
% part 3 of the lab).




