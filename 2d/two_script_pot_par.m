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

graph1 = true; % Graph potential landscape
graph2 = true; % Graph FFT
willhold = false; % Will hold graphs

if (~willhold)
    close all;
end



% =============================================================== %
%                                                                 %
%                 Calculate Potential Landscape                   %
%                                                                 %
% =============================================================== %

l = 1000; % Length of GaAs Layer in nm 
nIons = 100; % Number of Mn^{2+} ions matlab
nDataPoints = 1000; 
d = 1; % Distance from the ions in nm
chargePos = -l/2 + l*rand(2,nIons);
x = linspace(-250, 250, 1000);
y = linspace(-250, 250, 1000);
xPotential1 = zeros(nDataPoints/2,nDataPoints); 
xPotential1 = zeros(nDataPoints/2,nDataPoints); 

e=1.60*(10^-19); % Elementary charge
epsilon0=8.85*(10^-12); % Permittivity of free space
epsilon = 12.5; % Relative permittivity of GaAs
k = (1/(4*pi*epsilon0*epsilon));
const = -k*(2*e)*10^9;

tic;
parfor i = 1:nDataPoints/2
    for j = 1:nDataPoints
        xPotential1(i,j) = sum(const./(sqrt(d^2 + (x(i)-chargePos(1,:)).^2 ...
                                           + (y(j) - chargePos(2,:)).^2 ...
                                           )));
    end
    
end

parfor k = 1:nDataPoints/2
    for l = 1:nDataPoints
        xPotential2(k,l) = sum(const./(sqrt(d^2 + (x(k)-chargePos(1,:)).^2 ...
                                           + (y(l) - chargePos(2,:)).^2 ...
                                           )));
    end
    
end
toc;
