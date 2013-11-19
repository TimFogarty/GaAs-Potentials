% TESTFOURIERSTRETCH is for testing how FFT changes depending on the length
% of the input and the sampling frequency
%
% Authored by: T. Fogarty & C. Haselden
% Supervisor: O. Makarovsky
% University of Nottingham
% https://github.com/TimFogarty/GaAs-Potentials

done = false;

r
x0 = -250 + 500*rand(1,50);

while(~done)
    tbound = input('width? ')/2;
    SF = input('sampling frequency?' );
    t = -tbound:1/SF:tbound;
    % Input given function
    x = lorentzianSum(t, 10, 500, x0);
    n = (2^5)*(2^nextpow2(length(t))); % Length of FFT
    % Apply Fast Fourier Transform
    X = fft(x,n); 
    % FFT is symmetric, throw away second half
    X = X(1:n/2); 
    % Ignore imaginary values of X
    Y = abs(X);
    % Normalise the frequency scale
    f = (0:n/2-1)*SF/n;

    semilogy(f,Y); 
    title('Fourier Transform of f(x)'); 
    xlabel('Frequency (Hz)'); 
    ylabel('Power');
    
    hold all;
    done = input('done? ');
end
