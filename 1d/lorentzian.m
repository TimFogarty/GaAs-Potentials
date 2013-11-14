function [y] = lorentzian(x, s, l)
g = ones(1,length(x))*s/2;
y = (1/pi)*g./(x.^2 + g.^2);