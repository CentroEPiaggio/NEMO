%%%%%ANALISI DELLE COMPONENTI PRINCIPALI%%%%%

load datamatrixPCA.mat

str={'objects PCA', 'variables PCA'};

[var,v] = listdlg('PromptString','Select PCA:',...
                'SelectionMode','single',...
                'ListString',str);
if var == 1              %PCA sugli oggetti
    
   DMp1 = [DMp, ones(7,1)];

   pca(DMp1, 0.9);

%cd('./risultatiPCA');
%saveas(gcf,'cerchio_oggetti.bmp','bmp')
%close(gfc)
%saveas(gcf,'PCA_oggetti.bmp','bmp')
%cd('..');

elseif var==2
    
    DMp2 = [DMp', ones(8,1)];

    pca(DMp2, 0.9);

%cd('./risultatiPCA')
%saveas(gcf,'cerchio_variabili.bmp','bmp')
%close(gfc)
%saveas(gcf,'PCA_variabili.bmp','bmp')
%cd('..');

end;


