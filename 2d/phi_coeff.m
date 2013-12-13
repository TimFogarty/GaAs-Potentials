function [ p ] = phi_coeff( n )
%PHICOEFF.M computes the coefficients of all phi_k(x) k = 0,1,...,n
%   phi_0(x) = T_0(x)/sqrt(pi)
%   phi_j(x) = sqrt(2/pi)T_j(x) j = 1,2,...,n
%   where T_k(x) are the Chebyshev polynomials.
%   The function phicoeff(n) takes the highest order of phi_k, n, and
%   returns an (n+1)*(n+1) matrix, p, with the coefficients of the
%   polynomials phi_0 through to phi_n as rows. The coefficients are
%   ordered in decending powers of x to be compatible with polyval.

%   Initialize the output matrix and initialize the first two Chebyshev
%   polynomials.
p = zeros(n+1);
p(1,n+1) = 1;
p(2,n) = 1;

%   Implement the three term recurrance relation. circshift simulates
%   multiplication by x as it shifts coefficients left into columns
%   that represent x's of order one higher.
for i = 3:n+1
    p(i,:) = ((2*(i-2)+1)/(i-1))*circshift(p(i-1,:), [0,-1]) - ((i-2)/(i-1))*p(i-2,:);
end

%   Multiply phi_0 by factor 1/sqrt(pi) and other phi_k by sqrt(2/pi)
%p(1,:) = p(1,:) * 1/sqrt(pi);
%p(2:end,:) = p(2:end,:) * sqrt(2/pi);

%   return p
end

