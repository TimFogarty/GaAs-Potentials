clear; clc; close all;
l = 500;
chargePos = zeros(1,100);
min_dist = 0.127;
d = 5;
x = linspace(-250, 250, 100);
xPotential = zeros(1,100);

for i = 1:length(chargePos)
    chargePos(i) = -l/2 + l*rand(1);
    for j = 1:(i-1)
        if (abs(chargePos(i) - chargePos(j)) > min_dist)
            i = i - 1;
        end
    end
end

for i = 1:length(x)
    xPotential(i) = potential(x(i), chargePos, d);
end

figure
plot(x,xPotential)



title('Potential landscape of randomly distributed charges','interpreter','Latex','FontSize',15);
xlabel('Positionx (nm)','interpreter','latex','FontSize',15);
ylabel('Potential','interpreter','latex','FontSize',15);