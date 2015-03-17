%%%plot della conta dei neuroni nelle immagini di una stessa slices (in
%%%ordine temporale

prompt1 = {'Enter no. colture'};
dlg_title = 'No. colture';           %see help for informations
num_lines = 1;
answer = inputdlg(prompt1, dlg_title, num_lines);   %coltura di cui si vuol avere il plot

answer1 = num2str(cell2mat(answer));   

a = sprintf('vettore_numero_neuroni%s.mat', answer1);

load (a)   %carica il vettore numberOfNeurons

dim = size(numberOfNeurons, 2);

plot ([1:dim], numberOfNeurons, '*')    %plot
title(['Number of neurons in a slices ', answer1, 'in time'])
xlabel('Days')
ylabel('Number of neurons')
saveas(gcf, sprintf('Grafico del numero di neuroni nel tempo per la coltura numero%s', answer1), 'jpg');


bar([1:dim], numberOfNeurons)      %bar
title(['Number of neurons in a slices ', answer1, 'in time'])
xlabel('Days')
ylabel('Number of neurons')
saveas(gcf, sprintf('Grafico del numero di neuroni nel tempo per la coltura numero%s', answer1), 'bmp');

