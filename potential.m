function V = potential(x,chargePos,d)
e=1.60*(10^-19);
e0=8.85*(10^-12);
V = 0;
for i = 1:length(chargePos)
    V = V + (1/(4*pi*e0))*((2*e)/(d^2+(x-chargePos(i))^2)^0.5);
end
