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

graph1 = true; % Graph potential landscape
graph2 = true; % Graph FFT
willhold = false; % Will hold graphs

if (~willhold)
    close all;
end



% =============================================================== %
%                                                                 %
%                 Calculate Potential Landscape                   %
%                                                                 %
% =============================================================== %

l = 10000; % Length of GaAs Layer in nm 
nIons = 1E6; % Number of Mn^{2+} ions matlab
numberOfDataSets = 1;
nDataPoints = 2^14; % Number of data points at which potential is calculated
chargePos = zeros(1,nIons); % Initialize a vector for holding the positions of the Mn^{2+} ions
d = 6; % Distance from the ions in nm
x = linspace(-9000/2, 9000/2, nDataPoints); % The points at which potential will be calculated
xPotential = zeros(1,nDataPoints); % Initialize vector for
                                    % potentials at nDataPoints
tic;
xPotentialU = 2*uniformPotential(l,x,zeros(1,nDataPoints),d,nIons);
toc;

chargePos = -l/2 + l*rand(1,nIons);

e=1.60*(10^-19); % Elementary charge
epsilon0=8.85*(10^-12); % Permittivity of free space
epsilon = 12.5; % Relative permittivity of GaAs
k = (1/(4*pi*epsilon0*epsilon));
const = -k*(2*e)*10^9;

tic;
for i = 1:nDataPoints
    xPotential(i) = sum(const./( sqrt( d^2 + (x(i)-chargePos).^2 ) ));
end
toc;

% xPotentialFinal = xPotential - xPotentialU;
% correction = sum(xPotentialFinal)/length(xPotentialFinal);      
% xPotentialFinal = xPotentialFinal + correction;


xPotential = min(xPotential) - xPotential;
p = polyfit(x, xPotential, 2);
yy = polyval(p,x);
y = xPotential - yy;
xPotentialFinal = y - max(y);
xPotentialFinal = xPotentialFinal - mean(xPotentialFinal);





% =============================================================== %
%                                                                 %
%                   Graph Potential Landscape                     %
%                                                                 %
% =============================================================== %

if (graph1)
    f1 = figure;
    plot(x,xPotentialFinal)
    title(sprintf(['Potential landscape at a distance %gnm from %g ' ...
                   'randomly distributed charges'], d, nIons),'interpreter','Latex','FontSize',15);
    xlabel('$x$ (nm)','interpreter','latex','FontSize',15);
    ylabel('$V$ (V)','interpreter','latex','FontSize',15);
    %axis([-250 250 -0.4 0.2]);
end



% =============================================================== %
%                                                                 %
%                   FFT of Potential Landscape                    %
%                                                                 %
% =============================================================== %

if (graph2)
    
    tic;
    
    SF = 50;
    n = (2^5)*(2^nextpow2(length(x))); % Length of FFT
    f = (0:(n/2-1))*SF/n;

    for i = 1:numberOfDataSets
        X1 = fft(xPotentialFinal)/size(xPotentialFinal,2); 
        PX = sqrt(X1.*conj(X1))*2;
        NumFFT = size(X1,2)/2;
        dx = x(2) - x(1);
        PPX = PX(1:NumFFT);
        ff = ((1:NumFFT)-1)./(max(x)-min(x));
    end
    
    toc;
    
    f2 = figure;
    semilogy(ff,PPX);
    if (willhold)
        hold all;
    end

    title(sprintf(['Fourier Transform of Potential Landscape at a distance %g ' ...
                   'from %g randomly distributed charges on a log scale'], d, nIons),'interpreter','Latex','FontSize',15); 
    xlabel('Frequency (Hz)','interpreter','Latex','FontSize',15); 
    ylabel('Power','interpreter','Latex','FontSize',15);
    legend('Fourier transform','Smoothed Fourier transform');
    % Limit the x axis (Is there a better way to scale it?)
    %xlim([0,0.3]);

    
    
    % =============================================================== %
    %                                                                 %
    %                        Cut off artefacts                        %
    %                                                                 %
    % =============================================================== %
    
    satisfied = false;
    
    while (~satisfied)

        cutoff1 = input('where do you want cutoff1? (index, 200 is good): ');
        cutoff2 = input('where do you want cutoff2? (value): ');

        % THESE LINES FOR CUTTING OF ARTEFACTS
        for i = 1:length(f)
            if(ff(i) > cutoff2)
                ff = ff(cutoff1:i); 
                PPX = PPX(cutoff1:i);
                PPX2 = log(PPX);
                break;
            end
        end
        
        semilogy(ff,PPX);
        hold all;

        title(sprintf(['Fourier Transform of Potential Landscape at a distance %g ' ...
                       'from %g randomly distributed charges on a log scale'], d, nIons),'interpreter','Latex','FontSize',15); 
        xlabel('Frequency (Hz)','interpreter','Latex','FontSize',15); 
        ylabel('Power','interpreter','Latex','FontSize',15);
        legend('Fourier transform','Smoothed Fourier transform');
        % Limit the x axis (Is there a better way to scale it?)
        % xlim([0,0.3]);

        satisfied = input('Satisfied? (true, false): ');
    end
end