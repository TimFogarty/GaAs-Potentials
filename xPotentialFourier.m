% Script to plot the Fourier Transform of a given function

% Define the sampling frequency
SF = 200;
% Create a vector of 10^5 points between -250 and 250
t = -250:1/SF:250;
% Input given function
x = input('input function: ');
% Minimum length of FFT multiplied by 20
n = 20*(2^nextpow2(length(t))); % Length of FFT
% Apply Fast Fourier Transform
X = fft(x,n); 
% FFT is symmetric, throw away second half
X = X(1:n/2); 
% Ignore imaginary values of X
Y = abs(X);
% Normalise the frequency scale
f = (0:n/2-1)*SF/n;
% Generate the plot, title and labels. 
figure(1);
plot(t,x);
title('f(x)'); 
xlabel('x'); 
ylabel('f(x)'); 
figure(2);
plot(f,Y); 
title('Fourier Transform of f(x)'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
% Limit the x axis (Is there a better way to scale it?)
xlim([0,2]);