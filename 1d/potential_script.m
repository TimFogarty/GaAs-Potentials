% POTENTIAL_SCRIPT models the electrostatic potential due to randomly
% distributed charges.
%
% SYNOPSIS: This aims to model interstitial Mn^{2+} donors which have
% diffused from p-GaAs to undoped GaAs. The ions are treated as being
% randomly distributed along a line. The potential is measured along a
% parallel line at distance d from the line of ions.
%
% Authored by: T. Fogarty & C. Haselden
% Supervisor: O. Makarovsky
% University of Nottingham
% https://github.com/TimFogarty/GaAs-Potentials

graph1 = false;
willhold = false;

if (~willhold)
    close all;
end

l = 625; % Length of GaAs Layer in nm 
nIons = 100; % Number of Mn^{2+} ions matlab
numberOfDataSets = 2;
nDataPoints = 100000; % Number of data points at which potential is calculated
chargePos = zeros(1,nIons); % Initialize a vector for holding the positions of the Mn^{2+} ions
d = 2; % Distance from the ions in nm
x = linspace(-l*0.8/2, l*0.8/2, nDataPoints); % The points at which potential will be calculated
xPotential = zeros(10,nDataPoints); % Initialize vector for
                                    % potentials at nDataPoints

xPotentialU = 2*uniformPotential(l,x,zeros(1,nDataPoints),d,nIons);

for j = 1:numberOfDataSets
    chargePos = -l/2 + l*rand(nIons);

    for i = 1:length(x)
        % Use POTENTIAL.m to calculate the potential at each data point.
        xPotential(j,i) = GaAsPotential(x(i), d, chargePos);
    end

    
    xPotentialFinal(j,:) = xPotential(j,:) - xPotentialU;
    correction = sum(xPotentialFinal(j,:))/length(xPotentialFinal(j,:));      
    xPotentialFinal(j,:) = xPotentialFinal(j,:) + correction;
    plot(x,xPotentialFinal)
    title(sprintf(['Potential landscape at a distance %gnm from %g ' ...
                   'randomly distributed charges'], d, nIons),'interpreter','Latex','FontSize',15);
    xlabel('$x$ (nm)','interpreter','latex','FontSize',15);
    ylabel('$V$ (V)','interpreter','latex','FontSize',15);
    axis([-250 250 -0.4 0.2]);
end

if (graph1)
    f1 = figure;
    plot(x,xPotentialFinal)
    title(sprintf(['Potential landscape at a distance %gnm from %g ' ...
                   'randomly distributed charges'], d, nIons),'interpreter','Latex','FontSize',15);
    xlabel('$x$ (nm)','interpreter','latex','FontSize',15);
    ylabel('$V$ (V)','interpreter','latex','FontSize',15);
    axis([-250 250 -0.4 0.2]);
end


SF = 50;
n = (2^5)*(2^nextpow2(length(x))); % Length of FFT
f = (0:(n/2-1))*SF/n;

for i = 1:NumberOfDataSets
    X1 = fft(xPotentialFinal(i,:),n); 
    X2 = X1(1:n/2);
    if (i == 1)
       Y1 = X2.*conj(X2)/n;
    else
        Y1 = Y1 + X2.*conj(X2)/n;
    end
end

semilogy(f,Y1);
if (willhold)
    hold all;
end
%Y2 = smooth(Y1,1000);
%semilogy(f,Y2);

title(sprintf(['Fourier Transform of Potential Landscape at a distance %g ' ...
       'from %g randomly distributed charges on a log scale'], d, nIons),'interpreter','Latex','FontSize',15); 
xlabel('Frequency (Hz)','interpreter','Latex','FontSize',15); 
ylabel('Power','interpreter','Latex','FontSize',15);
legend('Fourier transform','Smoothed Fourier transform');
% Limit the x axis (Is there a better way to scale it?)
xlim([0,0.3]);

satisfied = false;

while (~satisfied)

    cutoff1 = input('where do you want cutoff1? (index, 200 is good): ');
    cutoff2 = input('where do you want cutoff2? (value): ');

    % THESE LINES FOR CUTTING OF ARTEFACTS
    for i = 1:length(f)
        if(f(i) > cutoff2)
            f = f(cutoff1:i); 
            Y1 = Y1(cutoff1:i);
            Y2 = log(Y1);
            break;
        end
    end
    
    semilogy(f,Y1);
    hold all;

    title(sprintf(['Fourier Transform of Potential Landscape at a distance %g ' ...
                   'from %g randomly distributed charges on a log scale'], d, nIons),'interpreter','Latex','FontSize',15); 
    xlabel('Frequency (Hz)','interpreter','Latex','FontSize',15); 
    ylabel('Power','interpreter','Latex','FontSize',15);
    legend('Fourier transform','Smoothed Fourier transform');
    % Limit the x axis (Is there a better way to scale it?)
    xlim([0,0.3]);

    satisfied = input('Satisfied? (true, false): ');
end