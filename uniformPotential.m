% function V = uniformPotential(l,x2,xPotential2,d)

l = 500;
x2 = linspace(-250,250,100);
xPotential2 = zeros(1,100);
d = 10;

for i = 1:length(xPotential2)
    a = l/2 + x2(i);
    b = l/2 - x2(i);
    xPotential2(i) = -log((b + sqrt(b^2 + d^2))/(-a + sqrt(a^2 + d^2)));
end

plot(x2, xPotential2)

V = xPotential2;