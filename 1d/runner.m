ds = [1,2,4,6,8,10];

for i=1:length(ds)
    i
    d = ds(i);
    potential_script
    save(sprintf('finalws%g',d));
end