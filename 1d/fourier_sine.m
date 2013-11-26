close all;

x = 10;
SF = 30;
t = -10:1/SF:10;

freq1 = 5;          % frequency Hz
theta1 = t* freq1 * 2. *pi ;
s1 = sin(theta1) ; % first sine wave

plot(t,s1);

n = (2^5)*(2^nextpow2(length(t))); % Length of FFT
f = (0:(n/2-1))*SF/n;

X1 = fft(s1,n); 
X2 = X1(1:n/2);

Y1 = X2.*conj(X2)/n;

f2 = figure;
plot(f,Y1);