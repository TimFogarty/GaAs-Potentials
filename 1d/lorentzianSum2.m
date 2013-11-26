function [y] = lorentzianSum2(x, s, l)
y = zeros(1, length(x));
g = ones(1,length(x))*s/2;
for i = 1:100
    % g = 10 + 20*rand(1)*ones(1,length(x))/2;
    x0 = -l/2 + l*rand(1);
    y = y - (0.6/pi)*g./((x-x0).^2 + g.^2);
end

correction = sum(y)/length(y);      
y = y - correction;
