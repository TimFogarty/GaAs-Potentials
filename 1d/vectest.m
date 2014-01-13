A = rand(20000);
tic
B = sum(A);
toc

C = 0;
A = rand(20000);
tic
for i=1:length(A)
    C = C + A(i);
end
toc