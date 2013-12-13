z=zeros(length(x));
for i=1:length(x)
    for j=1:length(y)
        z(i,j) = 10-x+(1/40)*(2*x(i)^2 - y(j)^2);
    end
end