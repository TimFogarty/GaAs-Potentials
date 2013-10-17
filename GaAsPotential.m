function V = GaAsPotential(x,d,chargePos)
% GAASPOTENTIAL calculates the electrostatic potential due to a line
% of several point chages.
% 
% INPUT x: x-coordinate of point for which potential should be
%          calculated.
%       d: distance from line of charges 
%       chargePos: vector of x-coordinates for ions on line of
%                  charges
% 
% OUTPUT V: The potential due to the chages at positions defined by
%           chargePos at the point defined by x and d.
%
% Authored by: T. Fogarty & C. Haselden
% Supervisor: O. Makarovsky
% University of Nottingham
% https://github.com/TimFogarty/GaAs-Potentials


e=1.60*(10^-19); % Elementary charge
epsilon0=8.85*(10^-12); % Permittivity of free space
epsilon = 12.5; % Relative permittivity of GaAs
V = 0;
for i = 1:length(chargePos)
    V = V - (1/(4*pi*epsilon0*epsilon))*((2*e)/(((d^2+(x-chargePos(i))^2)^0.5)*10^-9));
end
