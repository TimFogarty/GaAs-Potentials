semilogy(ff,PPX);
hold all;

satisfied = false;
while (~satisfied)
    
        cutoff1 = input('where do you want cutoff1? (index, 200 is good): ');
        cutoff2 = input('where do you want cutoff2? (value): ');

        % THESE LINES FOR CUTTING OF ARTEFACTS
        for i = 1:length(ff)
            if(ff(i) > cutoff2)
                ff = ff(cutoff1:i); 
                PPX = PPX(cutoff1:i);
                PPX2 = log(PPX);
                break;
            end
        end
        
        semilogy(ff,PPX);
        hold all;

        
        xlabel('Frequency (Hz)','interpreter','Latex','FontSize',15); 
        ylabel('Power','interpreter','Latex','FontSize',15);
        legend('Fourier transform','Smoothed Fourier transform');
        % Limit the x axis (Is there a better way to scale it?)
        % xlim([0,0.3]);

        satisfied = input('Satisfied? (true, false): ');
end