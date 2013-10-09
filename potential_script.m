l = 500;
charges = zeros(1,5);
min_dist = 0.127;
for i = 1:length(charges)
    charges(i) = -l/2 + l*rand(1);
    for j = 1:(i-1)
        if (abs(charges(i) - charges(j)) > min_dist)
            i = i - 1;
        end
    end
end

            
