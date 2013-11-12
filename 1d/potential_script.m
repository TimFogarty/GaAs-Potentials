% POTENTIAL_SCRIPT models the electrostatic potential due to randomly
% distributed charges.
%
% SYNOPSIS: This aims to model interstitial Mn^{2+} donors which have
% diffused from p-GaAs to undoped GaAs. The ions are treated as being
% randomly distributed along a line. The potential is measured along a
% parallel line at distance d from the line of ions.
%
% Authored by: T. Fogarty & C. Haselden
% Supervisor: O. Makarovsky
% University of Nottingham
% https://github.com/TimFogarty/GaAs-Potentials

%close all;

l = 625; % Length of GaAs Layer in nm 
nIons = 100; % Number of Mn^{2+} ions 
nDataPoints = 100000; % Number of data points at which potential is calculated
chargePos = zeros(1,nIons); % Initialize a vector for holding the
                            % positions of the Mn^{2+} ions
d = 1; % Distance from the ions in nm
x = linspace(-l*0.8/2, l*0.8/2, nDataPoints); % The points at which
                                      % potential will be calculated
xPotential = zeros(1,nDataPoints); % Initialize vector for
                                   % potentials at nDataPoints

chargePos = -l/2 + l*rand(nIons);

for i = 1:length(x)
    % Use POTENTIAL.m to calculate the potential at each data point.
    xPotential(i) = GaAsPotential(x(i), d, chargePos);
end

xPotentialU = uniformPotential(l,x,zeros(1,nDataPoints),d,nIons);
xPotentialFinal = xPotential - 2.*xPotentialU;
correction = sum(xPotentialFinal)/length(xPotentialFinal);      
xPotentialFinal = xPotentialFinal + correction;

%f1 = figure;
%plot(x,xPotentialFinal)
%title(sprintf(['Potential landscape at a distance %gnm from %g ' ...
%               'randomly distributed charges'], d, nIons),'interpreter','Latex','FontSize',15);
               %xlabel('$x$ (nm)','interpreter','latex','FontSize',15);
               %ylabel('$V$ (V)','interpreter','latex','FontSize',15);
               %axis([-250 250 -0.4 0.2]);


% Define the sampling frequency
SF = 50;
%xPotentialFinal = padarray(xPotentialFinal,[0 2000],0,'both'); %
%Doesn't work!
n = (2^5)*(2^nextpow2(length(x))); % Length of FFT
% Apply Fast Fourier Transform
X1 = fft(xPotentialFinal,n); 
% FFT is symmetric, throw away second half
X2 = X1(1:n/2); 
% Ignore imaginary values of X
Y1 = X2.*conj(X2)/n; % or abs(X2) ??
% Normalise the frequency scale
f = (0:(n/2-1))*SF/n;
% Generate the plot, title and labels.  
%f2 = figure;

% THESE LINES FOR CUTTING OF ARTEFACTS
%f = f(1:1050); 
%Y1 = Y1(1:1050);

semilogy(f,Y1);
hold all;
Y2 = smooth(Y1,1000);
semilogy(f,Y2);

title(sprintf(['Fourier Transform of Potential Landscape at a distance %g ' ...
       'from %g randomly distributed charges on a log scale'], d, nIons),'interpreter','Latex','FontSize',15); 
xlabel('Frequency (Hz)','interpreter','Latex','FontSize',15); 
ylabel('Power','interpreter','Latex','FontSize',15);
legend('Fourier transform','Smoothed Fourier transform');
% Limit the x axis (Is there a better way to scale it?)
xlim([0,0.3]);