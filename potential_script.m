function potential_script(l, nIons, d)
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

% l = 625; % Length of GaAs Layer in nm 
% nIons = 100; % Number of Mn^{2+} ions 
nDataPoints = 100000; % Number of data points at which potential is calculated
chargePos = zeros(1,nIons); % Initialize a vector for holding the
                            % positions of the Mn^{2+} ions
% d = 1; % Distance from the ions in nm
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

f1 = figure;
plot(x,xPotentialFinal)
title('Potential landscape of randomly distributed charges','interpreter','Latex','FontSize',15);
xlabel('$x$ (nm)','interpreter','latex','FontSize',15);
ylabel('$V$ (V)','interpreter','latex','FontSize',15);
axis([-250 250 -0.4 0.2]);
saveas(f1, sprintf('data/plots/fig1_%g.fig', d), 'fig');
% Define the sampling frequency
SF = 200;
% Minimum length of FFT multiplied by 20
n = 20*(2^nextpow2(length(x))); % Length of FFT
% Apply Fast Fourier Transform
X = fft(xPotentialFinal,n); 
% FFT is symmetric, throw away second half
X = X(1:n/2); 
% Ignore imaginary values of X
Y = abs(X);
% Normalise the frequency scale
f = (0:n/2-1)*SF/n;
% Generate the plot, title and labels.  
f2 = figure;
semilogy(f,Y);
hold all;
Y = smooth(Y,2000);
semilogy(f,Y);

title('Fourier Transform of Potential Landscape'); 
xlabel('Frequency (Hz)'); 
ylabel('Power');
% Limit the x axis (Is there a better way to scale it?)
xlim([0,0.3]);
saveas(f1, sprintf('data/plots/fig2_%g.fig', d), 'fig');