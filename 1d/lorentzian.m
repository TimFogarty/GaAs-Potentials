function [y] = lorentzian(x, s, l, x0)
g = ones(1,length(x))*s/2;
y = zeros(1, length(x));
for i = 1:50
    % x0 = -l/2 + l*rand(1);
    y = y - (1/pi)*g./((x-x0(i)).^2 + g.^2);
end
