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
nIons = 100; % Number of Mn^{2+} ions
nDataPoints = 100000; % Number of data points at which potential is calculated
chargePos = zeros(1,nIons); % Initialize a vector for holding the
                            % positions of the Mn^{2+} ions
minDist = 0.127; % The minimum distance (in nm) possible between two
                 % ions. Currently just the atomic radius of Mn
                 % but a better model could be implemented.
d = 3; % Distance from the ions
x = linspace(-250, 250, nDataPoints); % The points at which
                                      % potential will be calculated
xPotential = zeros(1,nDataPoints); % Initialize vector for
                                   % potentials at nDataPoints

for i = 1:length(chargePos)
    chargePos(i) = -l/2 + l*rand(1);
    for j = 1:(i-1)
        if (abs(chargePos(i) - chargePos(j)) < minDist)
            % Check to see if random position is too close to an
            % ion already assigned a position. If it is,
            % reiterate.  The chance of random numbers being so
            % close is small, so the check could be abandoned for 
            % the sake of speed.
            i = i - 1;
        end
    end
end

for i = 1:length(x)
    % Use POTENTIAL.m to calculate the potential at each data point.
    xPotential(i) = GaAsPotential(x(i), d, chargePos);
end

xPotentialU = uniformPotential(l,x,zeros(1,nDataPoints),d,nIons);
xPotentialFinal = xPotential - 2.*xPotentialU

figure
plot(x,xPotentialFinal)
title('Potential landscape of randomly distributed charges','interpreter','Latex','FontSize',15);
xlabel('$x$ (nm)','interpreter','latex','FontSize',15);
ylabel('$V$ (V)','interpreter','latex','FontSize',15);
axis([-250 250 -0.4 0.2]);