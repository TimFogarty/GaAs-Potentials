test = 0;
lower = 0;
higher = 0;
f = 0.5;
target_diff = max(max(xPotential))-min(min(xPotential));

while(test < target_diff - 0.0001 || test > target_diff + 0.0001)
    if(test < target_diff)
        ff = 1+f;
        if (lower == 0)
            f = f/2;
        end
        lower = lower+1;
        higher = 0;
    elseif (test > target_diff)
        ff = 1-f;
        if (higher == 0)
            f = f/2;
        end
        higher = higher+1;
        lower = 0;
    end
    xpp = xpp*ff;
    test = max(max(xpp))-min(min(xpp));
    disp(test)
end
shift = max(max(xPotential)) - max(max(xpp));
if (shift < 0)
    xpp = xpp - shift;
elseif (shift > 0)
    xpp = xpp + shift;
end
disp(done)
