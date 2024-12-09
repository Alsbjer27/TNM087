function out=RemoveSinusoidalNoise(in,D0)
%
% function out=RemoveSinusoidalNoise(in,D0)
%
%% Lab3, Task 3
%
%% Removes the most dominant sinusoidal noise
%
% Removes the most dominant sinusoidal noise by applying a Butterworth
% Notch Reject filter in the frequency domain
%
%% Who has done it
%
% Authors: Emil Alsbjer, emial133
%          Victor Ström, vicst918
% Same LiU-ID and name as in the Lisam submission
% Co-author: You can work in groups of max 2,
%
%% Syntax of the function
%      Input arguments:
%           in: the original input grayscale image (which is corrupted by
%           sinusoidal noises) of type double scaled between 0 and 1.
%           D0: The bandreject width of the Notch filter being constructed
%
%      Output argument:
%           out: the output image where the most dominant sinusoidal noise
%           is eliminated from the input image
%
% You MUST NEVER change the first line
%
%
%% General rules
%
% Don't change the structure of the template by removing %% lines
%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%
%% Localize the most dominant sinusoidal noise
% Sinusoidal noise peaks occur in pairs. Your task is to locate the most
% dominant pair, but it is sufficient to find just one of the two.
% However, when applying the Notch filter, you will create notches at both positions.
% Refer to the accompanying PDF document for further guidance on this task.

F = fftshift(fft2(in)); % the Fourier transform of the image followed by fftshift

F2 = abs(F); % The spectrum/magnitude of F
% Set the pixel values at the center and a small surrounding neighborhood in F2 to zero 
% (or another small number) to avoid selecting the DC component as the dominant peak.
% Then, find the position of one of the dominant frequency peaks.
P = height(F);
Q = width(F);
r_center = floor(P/2)+1;
c_center = floor(Q/2)+1;
F2(r_center-2:r_center+2, c_center-2:c_center+2)=0;
[r,c] = find(max(F2(:))==F2);
r = r(1); 
c = c(1); 

%% Construct Notch filter
%
%% Find uk and vk to construct the Butterworth bandreject filter
% Use the position of one of the peaks to determine uk and vk, which represent 
% the position of the found maximum relative to the center of the frequency spectrum.
%
% For further explanation on uk and vk, refer to the lecture notes for Chapter 5.

uk = r - r_center;% uk and vk are the positions of the peaks relative the center of the spectrum
vk = c - c_center; %

%% Construct the Butterworth Bandreject Notch filter
% If desired, you can write a separate function to construct the Notch filter.
% If you choose to do so, be sure to submit that MATLAB function as well.
%
% You’ve already constructed Gaussian filter transfer functions in Task 2 of this lab.
% The process for creating the Notch filter is similar.
% Refer to the lecture notes for Chapter 5 for examples on constructing such filter transfer functions.

 n= 2; % as specified in the task, the order should be 2
[X,Y] = meshgrid(0:P-1, 0:Q-1);
X = X';
Y = Y';
Dk = sqrt((X-floor(P / 2) - uk).^2 + (Y-floor(Q / 2) - vk).^2);
D_k = sqrt((X-floor(P / 2) + uk).^2 + (Y-floor(Q / 2) + vk).^2);

H = (1./(1+(D0./Dk).^n)).*(1./(1+(D0./D_k).^n)); % The filter transfer function of the Notch bandreject filter
    
%% Create the output image
% Apply the Notch filter to the Fourier transform of the input image in the frequency domain,
% and then transform back to the spatial domain to obtain the final output image.

out=real(ifft2(ifftshift(F.*H))); % the final output image, where the most dominant sinusoidal noise is eliminated
    
imshow(in)
figure
imshow(out)
%% Test your code
% Test your code on the four test images provided in the task instructions PDF.
% Ensure that the code performs as expected and correctly removes the sinusoidal noise.

%% Questions
% Before answering the questions, ensure you have thoroughly tested your code
% according to the instructions in the supplementary PDF file for this task.
%
% Now for the questions:
%
% 1. Did you test your code on astronaut-interference.tif and confirm that it successfully
% removes the sinusoidal noise using D0 = 1? (Answer 'yes' or 'no'. If 'no', test your code with this image and make sure it works!)
% Your answer: Yes
%
% 2. The image Einstein_odd_sinus.tif has an odd number of rows and columns. Did you test your code on this image and confirm that
% it successfully removes the sinusoidal noise using D0 = 1? (Answer 'yes' or 'no'. If 'no', test your code with this image
% and make sure it works!)
% Your answer: Yes
%
% 3. Did you test your code on Einstein_sinus_1.tif and confirm that it successfully
% removes almost completely the sinusoidal noise with a moderately large D0, and what D0 did you choose? 
% (Answer 'yes' or 'no'. If 'no', test your code with this image and make sure it works!)
% Your answer: Yes
% The D0 that you used is: D0 = 10-11 start giving good results
%
% 4. Did you test your code on Einstein_sinus_2.tif and confirm that it successfully
% removes the most dominant sinusoidal noise using D0 = 1?
% (Answer 'yes' or 'no'. If 'no', test your code with this image and make sure it works!)
% Your answer: Yes
%
% Did you try to increase D0 and make sure that larger D0 won't be able to
% remove the other sinusoidal noise? (Answer 'yes' or 'no'. If 'no', test your code with this image using some larger D0!)
% Your answer: Yes, with D0 = 6, 10, 15
%
%
