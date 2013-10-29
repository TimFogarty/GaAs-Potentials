function V = uniformPotential(l,x,xPotentialU,d,nIons)

hl = l/2;
e=1.60*(10^-19); % Elementary charge
epsilon0=8.85*(10^-12); % Permittivity of free space
epsilon = 12.5; % Relative permittivity of GaAs
d = d*10^-9;

for i = 1:length(xPotentialU)
    a = (hl + x(i))*10^-9;
    b = (hl - x(i))*10^-9;
    xPotentialU(i) = -((nIons*e)/(4*pi*epsilon0*epsilon*l*10^-9))*log((b + sqrt(b^2 + d^2))/(-a + sqrt(a^2 + d^2)));
end

V = xPotentialU;