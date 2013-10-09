function V = potential(x,xi,d)
e=1.60*(10^-19);
e0=8.85*(10^-12);
V = (1/(4*pi*e0))*((2*e)/(d^2+(x-xi)^2)^0.5);