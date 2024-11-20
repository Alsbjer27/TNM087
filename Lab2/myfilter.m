function [olp, ohp, obr, obp, oum, ohb]=myfilter(im, lp1, lp2)
% 
% function [olp, ohp, obr, obp, oum, ohb]=myfilter(im, lp1, lp2)
%
%% LAB2, TASK2
%
%% Performs filtering
%
% Filters the original grayscale image, im, given two different lowpass filters
% lp1 and lp2 with two different cutoff frequencies.
% The results are six images, that are the result of lowpass, highpass,
% bandreject, bandpass filtering as well as unsharp masking and highboost
% filtering of the original image
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
%      Input arguments:
%           im: the original input grayscale image of type double scaled
%               between 0 and 1
%           lp1: a lowpass filter kernel of odd size
%           lp2: another lowpass filter kernel of odd size, with lower cutoff
%                frequency than lp1
%
%      Output arguments:
%            olp: the result of lowpass filtering the input image by lp1
%            ohp: the result of highpass filtering the input image by
%                 the highpass filter constructed from lp1
%            obr: the result of bandreject filtering the input image by
%                 the bandreject filter constructed from lp1 and lp2
%            obp: the result of bandpass filtering the input image by
%                 the bandreject filter constructed from lp1 and lp2
%            oum: the result of unsharp masking the input image using lp2
%            ohb: the result of highboost filtering the input image using
%                 lp2 and k=2.5
%
% You MUST NEVER change the first line
%
%% Important rule
%
% Don't change the structure of the template by removing %% lines
%
%% Here starts your code. 
% Write the appropriate MATLAB commands right after each comment below.
%
%% Lowpass filtering
% Lowpass filter the input image by lp1. Use symmetric padding in order to
% avoid the dark borders around the filtered image.
% Perform the lowpass filtering here:
%

olp = imfilter(im,lp1,"symmetric"); % The lowpass filtered image

%% Highpass filtering
% Construct a highpass filter kernel from lp1, call it hp1, here:
[M,N] = size(lp1);
impulse = zeros(M,N);
impulse(floor(M/2)+1,floor(N/2)+1) = 1;

hp1 = impulse - lp1; % the highpass filter kernel

% Filter the input image by hp1, to find the result of highpass filtering
% the input image, here:

ohp = imfilter(im,hp1,'symmetric'); % the highpass filtered image

%% Bandreject filtering
% Construct a bandreject filter kernel from lp1 and lp2, call it br1, 
% IMPORTANT: lp2 has a lower cut-off frequency than lp1
% here:

[A,B] = size(lp2);

if(M > A)
    lp2 = padarray(lp2, [abs((M-A)/2), abs((N-B)/2)], 0, "both");
end
if (M < A)
    hp1 = padarray(hp1, [abs((M-A)/2), abs((N-B)/2)], 0, "both");
end

br1 = lp2 + hp1;

% Filter the input image by br1, to find the result of bandreject filtering
% the input image, here:

obr = imfilter(im, br1, "symmetric"); % the bandreject filtered image

%% Bandpass filtering
% Construct a bandpass filter kernel from br1, call it bp1, here:
[M,N] = size(br1);
impulse = zeros(M,N);
impulse(floor(M/2)+1,floor(N/2)+1) = 1;


bp1 = impulse - br1; % the bandpass filter kernel


% Filter the input image by bp1, to find the result of bandpass filtering
% the input image, here:
% Contrast stretching:

doubleImage = im2double(im);
g_min = min(doubleImage(:));
g_max = max(doubleImage(:));
T_doubleImage = doubleImage - g_min;
N_doubleImage = g_max - g_min;

kvot = T_doubleImage/N_doubleImage;
K = 1;
im = kvot .* K;

obp = imfilter(im, bp1,"symmetric"); % the bandpass filtered image


%% Unsharp masking
% Perform unsharp masking using lp2, here:
unsharpMask = im - imfilter(im,lp2,"symmetric");
oum =  im + unsharpMask;% the resulting image after unsharp masking


%% Highboost filtering
% Perform highboost filtering using lp2 (use k=2.5), here:
k = 2.5;
ohb =  k * im - imfilter(im,lp2,"symmetric");% the resulting image after highboost filtering


%% Test your code
% Test your code on various images using different low-pass filters as input arguments. 
% In particular, it is highly recommended to test your code on the image zoneplate.tif, 
% which contains a range of frequencies. This makes it interesting to observe how different 
% filters allow certain frequencies to pass while blocking others. For filter kernels,
% it is useful to experiment with different box filters and Gaussian
% filters. Also, make sure your code functions correctly with any image and any filter kernels. 
%
%% Questions
% Before answering the questions, you must test your code according to the 
% following instructions. First, read the image 'zoneplate.tif' in MATLAB and 
% ensure that it is normalized to the range [0, 1]. Assume the image is stored in 'im'.
% 
% Display this test image, and take special note that it contains information 
% at different frequencies, where low-frequency details are concentrated in the 
% center, increasing in frequency as you move outward from the center.
% 
% Next, create two Gaussian filters:
% - lp1: a Gaussian filter of size 35x35 with a standard deviation of 5.8
% - lp2: a Gaussian filter of size 43x43 with a standard deviation of 7.2
% 
% Run your code with the following command:
% [olp, ohp, obr, obp, oum, ohb] = myfilter(im, lp1, lp2)
%
% Display all six output images and answer the questions below.
%
% NOTICE: You need to apply contrast stretching to the image 'obp', as you learned 
% in Lab 1. Otherwise, it will appear very dark.
%
% Now for the questions:
%
% 1. Did you test your code following the instructions above and examine all six output images? (Answer 'yes' or 'no'. If 'no', test your code!)
% Your answer: Yes. Done in the Lab2.m file from preperations
% 
%  2. Did you tmake sure your code functions correctly with any image and any filter kernels? 
% (Answer 'yes' or 'no'. If 'no', make sure it does!)
% Your answer: Yes, we think so!
%
% 3. Do these six output images look as expected? Answer 'yes' or 'no'.
% Your answer: 
%    If 'no', either your code is not functioning correctly and needs to be fixed before submission, or you may be unsure of the expected results. 
%    In that case, ask the teachers for clarification before submitting the code.


