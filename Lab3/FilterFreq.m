function [olp, ohp1, ohp2]=FilterFreq(f, D0)
%
% function [olp, ohp1, ohp2]=FilterFreq(f, D0)
%
%% Lab3, Task 2
%
%% Performs filtering in the frequency domain
%
% Lowpass and highpass filters the image in the frequency domain by
% a Gaussian filter constructed in the frequency domain
%
%% Who has done it
%
% Authors: Emil Alsbjer, emial133
%          Victor Ström, vicst918
% Same LiU-IDs/names, as in the Lisam submission
% You can work in groups of max 2 students
%
%% Syntax of the function
%      Input arguments:
%           f: the original input grayscale image of type double scaled
%               between 0 and 1
%           D0: The cutoff frequency of the Gaussian lowpass filter
%
%      Output arguments:
%           olp: Result after lowpass filtering the input image using
%                the Gaussian lowpass filter.
%           ohp1: Result after highpass filtering the input image using
%                 the Gaussian highpass filter (Approach 1).
%           ohp2: Result of highpass filtering the input image using 
%                 the lowpass version of the input image (Approach 2).
%
%%
% You MUST NEVER change the first line
%
%% General rule
%
% Don't change the structure of the template by removing %% lines
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%
%% Zero Pad the Input Image
% The input image is zero-padded to a size of P x Q, where P = 2M and Q = 2N 
% (with M x N being the size of the input image). Note that the original 
% image should be positioned in the top-left corner of the zero-padded image.
f = im2double(f);
[M,N] = size(f);
P = 2 * M;
Q = 2 * N;
fp = zeros(P, Q); % the zero padded image
fp(1:M, 1:N) = f;
    
%% construct the Gaussian lowpass and highpass filter transfer functions
% If you want, you can write a separate function to construct the Gaussian filter.
% If you do so, don't forget to submit that MATLAB function as well.
%
% The transfer function is supposed to be the same size as the padded image
% that is P x Q
% The cutoff frequency of this filter, D0, is the second input argument of
% this MATLAB function

[X, Y] = meshgrid(0:P-1, 0:Q-1);
X = X';
Y = Y';
D = sqrt((X - P/2).^2 + (Y-Q/2).^2);

GLPF= exp(-(D.^2)/(2*D0.^2)); % the Gaussian lowpass filter transfer function
GHPF= 1 - GLPF; % the Gaussian highpass filter transfer function
    
%% Perform filtering in the frequency domain
% Find the product between the filter transfer function and the Fourier
% transform of the padded image (Notice that the zero frequency is supposed
% to be shifted to the center of the Fourier transform)

fFourierT = fftshift(fp);

OLP= GLPF.*fFourierT; % The Fourier transform of the lowpass filtered image
OHP= GHPF.*fFourierT; % The Fourier transform of the highpass filtered image
    
%% Find the padded lowpass and highpass filtered images
% The zero frequency of OLP and OHP should be shifted back to the top left corner of the
% image followed by the inverse Fourier transform. Take the real part of
% the result.
OLP_S = ifftshift(OLP);

olpf= real(ifft2()) % The padded lowpass filtered image of size P x Q
ohpf= ... % The padded highpass filtered image of size P x Q    

%% Find the lowpass and highpass filtered image
% Extract the final lowpass and highpass filtered images from their padded
% versions

olp= ... % The final lowpass filtered image
ohp1= ... % The final highpass filtered image (approach 1)

%% Find the highpass filtered image (approach 2)
% Read the document for this task

ohp2= ... % The final highpass filtered image
    
%% Test your code
% Test your code on various images (e.g., Einstein1.jpg, Einstein2.jpg, or characterTestPattern.tif)
% using different cutoff frequencies. Examine the results of both lowpass and highpass filtering 
% on the input image. 
% Ensure that your code operates correctly with any image.
%% Questions
%
% Before answering the questions, ensure you have tested your code according to the 
% following instructions. 
% 
% First, read the image 'Einstein1.jpg' in MATLAB and 
% normalize it to the range [0, 1]. Assume the image is stored in 'im'.
% 
% Run your code with the following command:
%
% [olp, ohp1, ohp2] = FilterFreq(im, D0)
% using three different cutoff frequencies: 40, 80, and 120.
% 
% Display the output images and answer the questions below.
% 
% Now for the questions:
%
% 1. Did you test your code following the instructions above and examine all three output 
% images for the three cutoff frequencies? (Answer 'yes' or 'no'. If 'no', test your code!)
% Your answer: 
%
% 2. Did you ensure your code functions correctly with any input image? 
% (Answer 'yes' or 'no'. If 'no', make sure it does!)
% Your answer: 
%
% 3. What happens to the lowpass filtered image when you increase the cutoff frequency? 
% Will the result be blurrier or less blurry? Explain why this happens.
% Your answer: (don't forget to provide an explanation)
%
%
%
% 4. What happens to the highpass filtered image when you increase the cutoff frequency? 
% Do you observe more or fewer details? Explain why this happens.
% Your answer: (don't forget to provide an explanation)
%
%
%
%
% 5. Did you confirm that ohp1 and ohp2 are identical for all three cutoff frequencies?
% (Answer 'yes' or 'no'. If 'no', make sure you do!)
% Your answer:
%
% 6. What is the maximum number of decimal places (n, as referred to in the instructions) to which 
% you rounded ohp1 and ohp2 to ensure they were identical for the following cutoff frequencies, 
% using the original image Einstein1.jpg.
% 
% Your answer:
% What is n for a cutoff frequency of 40? 
% What is n for a cutoff frequency of 80? 
% What is n for a cutoff frequency of 120?
%
%
%
