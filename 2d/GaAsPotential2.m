function V = GaAsPotential2(x,d,chargePos,theta)
% GAASPOTENTIAL calculates the electrostatic potential due to a surface
% of several point chages.
% 
% INPUT x: x-coordinates of points for which potential should be
%          calculated.
%       d: distance from surface of charges 
%       chargePos: Polar coordinates for ions on surface of
%                  charges
% 
% OUTPUT V: The potential due to the chages at positions defined by
%           chargePos at the points defined by x and d.
%
% Authored by: T. Fogarty & C. Haselden
% Supervisor: O. Makarovsky
% University of Nottingham
% https://github.com/TimFogarty/GaAs-Potentials


e=1.60*(10^-19); % Elementary charge
epsilon0=8.85*(10^-12); % Permittivity of free space
epsilon = 12.5; % Relative permittivity of GaAs
V = 0;
k = (1/(4*pi*epsilon0*epsilon));
for i = 1:length(chargePos(1,:))
    r = chargePos;
    V = V - k*((2*e)./(((r(1,i)^2 + x.^2 - 2*r(1,i)*x.*cos(r(2,i)*theta) + d^2).^0.5)*10^-9));
end
