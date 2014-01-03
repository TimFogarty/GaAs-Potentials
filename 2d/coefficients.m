function [B] = coefficients(n)
if (n==0)
    B=1;
elseif (n==1)
    B=-1;
elseif (mod(n,2)~=0)
    B=0;
else
    B=((gamma(0.5)/gamma(n/2))/(factorial(n/2)));
end
end