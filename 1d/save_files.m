d = [0.5, 1, 2, 4, 10, 15, 20, 30, 40, 60];

for i = 1:10
    potential_script(625, 100, d(i));
    save(sprintf('data/workspaces/ws%g.mat', d(i)));
end


