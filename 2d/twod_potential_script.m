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


clear; clc; close all;
l = 500; % Length of GaAs Layer in nm
nIons = 500; % Number of Mn^{2+} ions
nDataPoints = 50^2; % Number of data points at which potential is calculated
chargePos = zeros(2,nIons); % Initialize a vector for holding the
                            % positions of the Mn^{2+} ions
minDist = 0.127; % The minimum distance (in nm) possible between two
                 % ions. Currently just the atomic radius of Mn
                 % but a better model could be implemented.
d = 1; % Distance from the ions
x = linspace(0, 250, sqrt(nDataPoints)); % The points at which
                                      % potential will be calculated
xPotential = zeros(sqrt(nDataPoints)); % Initialize vector for
                                   % potentials at nDataPoints

chargePos(1,:) = -l/2 + l*rand(1,nIons);
chargePos(2,:) = -pi + 2*pi*rand(1,nIons);
theta = linspace(0, 2*pi, sqrt(nDataPoints));
[theta, x] = meshgrid(theta,x);

%for i = 1:length(x)
    % Use POTENTIAL.m to calculate the potential at each data point.
    xPotential = GaAsPotential2(x, d, chargePos,theta);
    %end

CartCoords = pol2cart(theta,x);
[x1,y1,z1] = pol2cart(theta,x,xPotential);
surf(x1,y1,z1)
