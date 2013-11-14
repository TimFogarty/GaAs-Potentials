% Script to plot the Fourier Transform of a given function

% Define the sampling frequency
SF = 5;
% Create a vector of 10^5 points between -10 and 10
t = -250:1/SF:250;
% Input given function
x = input('input function: ');
% Minimum length of FFT multiplied by 20
n = (2^5)*(2^nextpow2(length(t))); % Length of FFT
% Apply Fast Fourier Transform
X = fft(x,n); 
% FFT is symmetric, throw away second half
X = X(1:n/2); 
% Ignore imaginary values of X
Y = abs(X);
% Normalise the frequency scale
f = (0:n/2-1)*SF/n;

satisfied = false;

while (~satisfied)

    cutoff1 = input('where do you want cutoff1? (index, 200 is good): ');
    cutoff2 = input('where do you want cutoff2? (value): ');

    % THESE LINES FOR CUTTING OF ARTEFACTS
    for i = 1:length(f)
        if(f(i) > cutoff2)
            f = f(cutoff1:i); 
            Y = Y(cutoff1:i);
            Y2 = log(Y);
            break;
        end
    end
    
    semilogy(f,Y);
    hold all;

    satisfied = input('Satisfied? (true, false): ');
end