% Estrazione di variabili e funzioni dal DataMatrix globale

clear all
clc

load tipo.mat

% dc = questdlg ('Do you create the datamatrix?');
% 
% if dc == 'No'
%     
%     %helpdlg ('Create the datamatrix going on Plot Variables --> Datamatrix Creation')
%     creation;
%     
% else

% datace;

olddir = pwd;  %così sto in NE.MO.
mkdir(sprintf('%s\\PLOT', olddir'));
pathname1 = sprintf('%s\\PLOT', olddir');
mkdir(sprintf('%s\\P_Morph', pathname1));
pathname2 = sprintf('%s\\P_Morph', pathname1);

if strcmp('g', tipo) == 1 
    
    mkdir(sprintf('%s\\day-by-day', pathname2));
    pathname2 = sprintf('%s\\day-by-day', pathname2);
    
elseif strcmp('g', tipo) == 0
    
    mkdir(sprintf('%s\\dynamic', pathname2));
    pathname2 = sprintf('%s\\dynamic', pathname2);
    
end;
    


load datamatrix.mat
% load numberofcells.mat
% numberofcells = cat(1, 1, numberofcells);
% numberofcells = cat(1, numberofcells, 1);
% 
% % for i = 1: size(numberofcells, 1)
% %     
% %     a = num2str(numberofcells (i));
% %     f = num2str(numberofcells(i+1));
% %     b = num2str(i);
% %     c = 'Colture number ';
% %     d = ' contains untill the ';
% %     e = ' cell';
% %     h = msgbox([c b d a e], 'information');
% %     
% % end; 
% 
% z = 1;
% 
% for i = 1:(size(numberofcells, 1)-2)
%     
%     a = num2str(numberofcells(i));
%     g = num2str(numberofcells(i+1));
%     b = num2str(i);
%     c = 'Cell from ';
%     d = ' are of the colture number ';
%     e = ' cell';
%     f = ' to ';
%     z = z + str2num(g);
%     h = msgbox([c a f num2str(z) d b], 'information');
%     uiwait(h)
%     
% end;   


%var=input('Variabile o funzione: ','s');

%tipo=input('Digita g per giorno e t per tempo: ','s');

% str = {'Intersections1'; 'Intersections1Linear'; 'Intersections1Semi-Log';...
%     'Intersections1Log-Log'; 'Nm1'; 'rc1'; 'Schoenen1'; 'ksl1'; 'Rsl1'; 'kll1'; 'Rll1'; ...
%     'Delta'; 'Pextr1'; 'Lminextr1'; 'Aextr1'; 'Paxis1'; 'Luminaxis1'; 'Aaxis1'; ...
%     'Intersections2'; 'Intersections2linear'; 'Intersecions2Semi-Log'; 'Intersections2Log-Log'; ...
%     'Nm2'; 'rc2'; 'Schoenen2'; 'ksl2'; 'Rsl2'; 'kll2'; 'Rll2'; 'Delta2'; 'Pextr2'; 'Lminextr2'; ...
%     'Aextr2'; 'Paxis2'; 'Lminaxis2'; 'Aaxis2'; 'Extensions'; 'Soma Area'; 'Cone angle'; 'Box-counting'; ...
%     'Fractal dimension'}; 


str = {'Intersections1'; 'Intersections1Linear'; 'Intersections1Semi-Log';...
    'Intersections1Log-Log'; 'Nm1'; 'rc1'; ...
    'Delta';'Pextr1'; 'Lminextr1'; 'Aextr1'; 'Paxis1'; 'Luminaxis1'; 'Aaxis1'; ...
    'Intersections2'; 'Intersections2linear'; 'Intersecions2Semi-Log'; 'Intersections2Log-Log'; ...
     'rc2'; 'ksl2'; 'Delta2'; 'Pextr2'; 'Lminextr2'; ...
    'Aextr2'; 'Paxis2'; 'Lminaxis2'; 'Aaxis2'; 'Extensions'; 'Soma Area'; 'Cone angle'; 'Box-counting'; ...
    'Fractal dimension'}; 

[var,v] = listdlg('PromptString','Select a file:',...
                'SelectionMode','single',...
                'ListString',str);
            
% prompt = {' Insert g for day or t for time: '};
% dlg_title = 'Time';
% num_lines = 1;
% tipo = inputdlg(prompt, dlg_title);


if strcmp('g', tipo) == 1   
    
%     if strcmp('Intersezioni1',var)==1

      if var == 1
          
        reply = 'Yes';

        while strcmp('Yes',reply) == 1

%             cellula = inputdlg(' Select cells from 1 to 25: ', 's');
%             cell=str2num(cellula);
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);
            
            g = 1;
            
              while g < (size(DMg, 3) +1)
                  
                rmax = DMg(cell, 175, g);
                rmin = DMg(cell, 174, g);
                s = (rmax-rmin)/9;
                r = rmin:s:rmax;
                
                if DMg(cell, 1:10, g) ~= zeros(1, 10, 1)
                    
                    figure,
                    Intesezioni = DMg(cell, 1:10, g);
                    plot(r, DMg(cell, 1:10, g), '-o')
                    title(['Reference System constant circle: Cell Intersections',num2str(cell),' Day',num2str(g)])
%                     cftool
                    xlabel('r');
                    ylabel('Intersections');
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Intersections1%s_%s.bmp', num2str(cell), num2str(g)), 'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;

              end;
         
            reply = questdlg('Do you want to see the variable for an other cell?');
            
       end;
    
     elseif var == 2;
         
        reply = 'Yes';

        while strcmp('Yes', reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);
            
%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g = 1;
            
             while g < (size(DMg, 3) +1)
                
                rmax = DMg(cell, 175, g);
                rmin = DMg(cell, 174, g);
                s = (rmax-rmin)/9;
                r = rmin:s:rmax;
                
                if DMg(cell, 1:10, g) ~= zeros(1, 10, 1)
                    
                    y = (DMg(cell,1:10,g))./(pi*(r.^2));
                    [xFit yFit yError y0 A lambda x0 sFormula] = myFitLogRS(r, y, 1000, 'none');
                    F{g} = sFormula;
                    figure
                    plot(r,y,'o')
                    hold on
                    plot(xFit,yFit)
                    title(['Reference System constant circle: Method Linear Cell', num2str(cell), ' Day',num2str(g)])
                    xlabel('r');
                    ylabel('Intersections/Area');
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Intersections1Linear%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;
                
             end;

            save(sprintf('Formule%s.mat', num2str(cell), 'F'))
            reply = questdlg('Do you want to see the variable for an other cell:');
           
        end;

    elseif var == 3

        reply = 'Yes';

        while strcmp('Yes',reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);
            
%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);

            g = 1;
            
            while g < (size(DMg, 3) +1)
                
                rmax = DMg(cell, 175, g);
                rmin = DMg(cell, 174, g);
                s = (rmax-rmin)/9;
                r = rmin:s:rmax;
                
                if DMg(cell, 1:10, g) ~= zeros(1, 10, 1)
                    
                    y = (DMg(cell,1:10,g))./(pi*(r.^2));
                    [p,ErrorEst] = polyfit(r, log10(y), 1);
                    pop_fit = polyval(p, r, ErrorEst);
                    [pop_fit,delta] = polyval(p, r, ErrorEst);
                    % Plot dei dati, del fit e degli intervalli di confidenza
                    figure
                    plot(r, log10(y), '+', r,pop_fit, 'g-', r, pop_fit+2*delta,'r:', r,pop_fit-2*delta, 'r:');
                    title(['Reference System constant circle: Method Semi-Log Cell', num2str(cell), ' Day', num2str(g)])                  
                    xlabel('r');
                    ylabel('log(Intersections/Area)');
                    
                    cd(pathname2)
                    saveas(gcf, sprintf('Intersections1Semi-Log%s_%s.bmp', num2str(cell), num2str(g)), 'bmp');
                    cd(olddir)
                    
                end;
                
                g = g+1;
                
             end;
            
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;

    elseif var == 4

        reply='Yes';

        while strcmp('Yes', reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g = 1;
            
            while g < (size(DMg, 3) +1)
                
                rmax = DMg(cell, 175, g);
                rmin = DMg(cell, 174, g);
                s = (rmax-rmin)/9;
                r = rmin:s:rmax;
                
                if DMg(cell, 1:10, g) ~= zeros(1, 10, 1)
                    
                    y = (DMg(cell, 1:10, g))./(pi*(r.^2));
                    [p,ErrorEst] = polyfit(log10(r), log10(y), 1);
                    pop_fit = polyval(p, log10(r), ErrorEst);
                    [pop_fit, delta] = polyval(p, log10(r), ErrorEst);
                    % Plot dei dati, del fit e degli intervalli di confidenza
                    figure
                    plot(log10(r),log10(y),'+',log10(r),pop_fit,'g-',log10(r),pop_fit+2*delta,'r:',log10(r),pop_fit-2*delta,'r:')
                    title(['Reference System constant circle: Method Log-Log Cell',num2str(cell),' Day',num2str(g)])
                    xlabel('log(r)');
                    ylabel('log(Intersections/Area)');
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Intersections1Log-Log%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                g = g+1;
                
            end;
            
            reply = questdlg('Do you want to see the variable for an other cell?');
            
        end;

    elseif var == 5

        for j=1:size(DMg, 3)
            
        for i = 1 : size(DMg, 1)
            
            v(i) = DMg(i, 12, j);
            
        end;
        
        for j = 1:length(v)
            
            if v(j) == 0
                
                v(j) = NaN;
                
            end;
            
        end;
        
        figure
        plot(v)
        
        end;

    elseif var == 6

%         for g=7:23

       for i = 1: size(DMg, 1)   %scorro le cellule
    
            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 175, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;
    
        for g = giniziale:size(DMg, 3)  
            
        for i = 1: size(DMg, 1)
            
            rmax = DMg(i,175,g);
            v(i) = DMg(i, 11, g)/rmax;
            
        end;
        
        for j=1:length(v)
            
            if v(j)==0
                
                v(j)=NaN;
                
            end;
            
        end;
        
        figure, plot(v,'*'),title(['Reference System constant circle: All cells Critical radius  Day',num2str(g)])
        xlabel('Cell')
        ylabel('rc')
        
        cd(pathname2)
        saveas(gcf,sprintf('rc1cells_%s.bmp',num2str(g)),'bmp')
        cd(olddir)
        
        end;

%     elseif var == 7
% 
%         Schoenen1 = DMg(cell,13,g);
% 
%     elseif var == 8
% 
%         ksl1 = DMg(cell,14,g);
% 
%     elseif var == 9
% 
%         Rsl1 = DMg(cell,15,g);
% 
%     elseif var == 10
% 
%         kll1 = DMg(cell,16,g);
% 
%     elseif var == 11
% 
%         Rll1 = DMg(cell,17,g);

%     elseif var == 12
      elseif var == 7
        
        for i = 1: size(DMg, 1)   %scorro le cellule
    
            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 18, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;  

        for g = giniziale: size(DMg, 3)
            
            for i = 1: size(DMg, 1)
                
                v(i)= DMg(i, 18, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            %v
            figure, plot(v,'*'),title(['Reference System constant circle: All cells Delta Day',num2str(g)])
            xlabel('Cell')
            Ylabel('\Delta')
            
            cd(pathname2)
            saveas(gcf,sprintf('Deltacells_%s.bmp',num2str(g)),'bmp')
            cd(olddir)
            
        end;

%     elseif var == 13
      elseif var == 8
        
        for i = 1: size(DMg, 1)   %scorro le cellule

            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 19, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;   

        for g = giniziale:size(DMg, 3)
            
            for i = 1:size(DMg, 1)
                
                v(i)= DMg(i, 19, g);
                
            end;
            
            for j=1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure, plot(v,'*'),title(['Reference System constant inter-circle distance: All cells min distance from extremity to centre  Day',num2str(g)])
            
            cd(pathname2)
            saveas(gcf, sprintf('Pestrcells_%s.bmp',num2str(g)), 'bmp')
            cd(olddir)
            
        end;

%     elseif  var == 14
      elseif var == 9

        reply='Y';

        while strcmp('Y',reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell to 1 from 25: ', 's');
%             cell=str2num(cellula);
            g=1;
            
            while g < (size(DMg, 3) +1)
                
                if DMg(cell,20:29,g) ~= zeros(1,10,1)
                    
                    figure
                    plot(1:1:10,DMg(cell,20:29,g));
                    title(['Sistema di rif. cerchi cost.: min lenght from extremity to centre Cell',num2str(cell),' Day',num2str(g)])
                    xlabel('Circle')
                    ylabel('Min Lenght')
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Lminestr%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                g=g+1;
                
            end;
            
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif  var == 15
      elseif var == 10

        reply = 'Yes';

        while strcmp('Yes', reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g = 1;
            
            while g < (size(DMg, 3) +1)
                
                if DMg(cell,20:29,g) ~= zeros(1,10,1)
                    
                    figure
                    plot(1:9, DMg(cell, 30:38, g));
                    title(['Reference System constant circle: Angle from extremity to centre Cell',num2str(cell),' Day',num2str(g)])
                    xlabel('Circle')
                    ylabel('Angles')
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Aestr%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                g=g+1;
                
            end;
            
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif  var == 16
      elseif var == 11
        
             for i = 1: size(DMg, 1)   %scorro le cellule

                for j = 1:size(DMg, 3)   %scorro il tempo

                    if DMg (i, 39, j) ~= 0

                        giniziale = j;
                        break;

                    end;

                end;

            end;    

        for g = giniziale:size(DMg, 3)
            
            for i = 1: size(DMg, 1)
                
                v(i) = DMg(i, 39, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure, plot(v,'*'),title(['Reference System constant distance inter-circle : min distance from main axes to centre for all cells Day',num2str(g)])
            
            cd(pathname2)
            saveas(gcf,sprintf('Passecells_%s.bmp',num2str(g)),'bmp')
            cd(olddir)
            
        end

%     elseif  var == 17
      elseif var == 12

        reply = 'Yes';

        while strcmp('Yes',reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g=1;
            
             while g < (size(DMg, 3) +1)
                 
                u = DMg(cell, 40:49, g) ~= zeros(1, 10, 1);
                z = find(u);
                
                if length(z) ~= 0
                    
                    ind = find(DMg(cell, 40:49, g));
                    c = DMg(cell, 40:40+max(ind)-1, g);
                    figure
                    plot(c);
                    title(['Reference System constant circle: min lenght from main axes extremity from centre Cell',num2str(cell),' Day',num2str(g)])
                    xlabel('Cerchio')
                    ylabel('Min lenght')
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Lminaxes%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;
                 
             end;
             
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif  var == 18
      elseif var == 13

        reply='Yes';

        while strcmp('Yes', reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);

            g=1;
            
            while g < (size(DMg, 3) +1)
                
                u = DMg(cell, 50:59, g) ~= zeros(1, 10, 1);
                z = find(u);
                if length(z) ~= 0
                    
                    ind = find(DMg(cell, 50:59, g));
                    c = DMg(cell,50:50+max(ind)-1,g);
                    figure
                    plot(c);
                    title(['Referernce System constant circle: Angle from main axes extremity to centre Cell',num2str(cell),' Day',num2str(g)])
                    xlabel('Circle')
                    ylabel('Angle')
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Aaxes%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                g=g+1;
                
            end;
            
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif var == 19
      elseif var == 14

        reply = 'Yes';

        while strcmp('Yes',reply)==1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
%             giorno= input('Giorno: ', 's');
%             g=str2num(giorno);
            g = 1;
            
             while g < (size(DMg, 3) +1)  
                 
                rmax = DMg(cell, 175, g);
                rmin = DMg(cell, 174, g);
                s = 60;
                r1 = rmin:s:rmax;
                u = DMg(cell,60:79,g) ~= zeros(1,20,1);
                z = find(u);
                
                if length(z) ~= 0
                    
%                     ind = find(DMg(cell, 60:79, g));
%                     Intersezioni = DMg(cell, 60 : 60+max(ind)-1, g);
                    Intersezioni = DMg(cell, 60 : 60+numel(r1)-1, g);
                    figure
                    r = rmin : s : r1(numel(r1));
                    %Intersezioni;
                    plot(r, Intersezioni, 'o')
                    title(['Reference System inter-circle costant distance: Cell Intersections', num2str(cell), ' Day', num2str(g)])
                    xlabel('r');
                    ylabel('Intersections');
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Intersections2%s_%s.bmp', num2str(cell), num2str(g)), 'bmp')
                    cd(olddir)
                    
                    
                end;
                
                 g=g+1;
                 
             end;
             
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;   
        
%     elseif var == 20
      elseif var == 15

        reply='Yes';

        while strcmp('Yes', reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 10: ', 's');
%             cell=str2num(cellula);
            g = 1;
            
             while g < size(DMg, 3)
                 
                s = 60;
                rmax = DMg(cell, 175, g);
                rmin = DMg(cell, 174, g);
                r = rmin : s : rmax;
                u = DMg(cell, 60 : 79, g) ~= zeros(1, 20, 1);
                z = find(u);
                
                if length(z) ~= 0
                    
                    ind = find(DMg(cell, 60 : 79, g));
                    c = DMg(cell, 60 : 60+max(ind)-1, g);
                    y = c(1 : length(r))./(pi*(r.^2));
                    %y
                    [xFit yFit yError y0 A lambda x0 sFormula] = myFitLogRS(r, y, 1000, 'none');
                    F{g} = sFormula;
                    figure
                    plot(r,y,'o')
                    hold on
                    plot(xFit,yFit)
                    xlabel('r');
                    ylabel('Intersections/Area');
                    title(['Reference System inter-circle costant distance : Method Linear Cell', num2str(cell), ' Day', num2str(g)])
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Intersections2Linear%s_%s.bmp', num2str(cell), num2str(g)), 'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;
                 
             end;
             
            cd(pathname2)
            save(sprintf('Formule%s.mat',num2str(cell),'F'))
            cd(olddir)
            
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;
           
%     elseif var == 21
      elseif var == 16

        reply = 'Yes';

        while strcmp('Yes',reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g = 1;
            
             while g< (size(DMg, 3) +1)
                 
                s = 60;
                rmax = DMg(cell, 175, g);
                rmin = DMg(cell,174, g);
                r = rmin : s : rmax;
                u = DMg(cell, 60 : 79, g) ~= zeros(1, 20, 1);
                z = find(u);
                
                if length(z) ~= 0
                    
                    ind = find(DMg(cell, 60 : 79, g));
                    c = DMg(cell, 60 : 60+max(ind)-1, g);
                    y = c(1:length(r))./(pi*(r.^2));
                    log10(y);
                    [p,ErrorEst] = polyfit(r, log10(y), 1);
                    pop_fit = polyval(p, r, ErrorEst);
                    [pop_fit,delta] = polyval(p,r,ErrorEst);
                    % Plot dei dati, del fit e degli intervalli di confidenza
                    figure
                    plot(r,log10(y), '+', r, pop_fit,'g-', r, pop_fit+2*delta, 'r:', r, pop_fit-2*delta, 'r:');
                    title(['Reference System inter-circle costant distance: Method Semi-Log Cell',num2str(cell),' Day',num2str(g)])
                    xlabel('r');
                    ylabel('log(Intersections/Area)');
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Intersezioni2Semi-Log%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;
                 
                end;
                
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif var == 22
      elseif var == 17

        reply = 'Yes';

        while strcmp('Yes',reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g = 1;
            
             while g < (size(DMg, 3) +1)
                 
                s = 60;
                rmax = DMg(cell, 175, g);
                rmin = DMg(cell, 174, g);
                r = rmin : s : rmax;
                u = DMg(cell, 60 : 79, g) ~= zeros(1, 20, 1);
                z = find(u);
                
                if length(z) ~= 0
                    
                    ind = find(DMg(cell, 60 : 79, g));
                    c = DMg(cell, 60 : 60+max(ind)-1, g);
                    y = c(1:length(r))./(pi*(r.^2));
                    [p,ErrorEst] = polyfit(log10(r), log10(y), 1);
                    pop_fit = polyval(p, log10(r), ErrorEst);
                    [pop_fit,delta] = polyval(p, log10(r), ErrorEst);
                    % Plot dei dati, del fit e degli intervalli di confidenza
                    figure
                    plot(log10(r), log10(y), '+', log10(r), pop_fit, 'g-', log10(r), pop_fit+2*delta, 'r:', log10(r), pop_fit-2*delta, 'r:');
                    log10(r);
                    log10(y);
                    title(['Reference System inter-circle costant distence: Method Log-Log Cell', num2str(cell), ' Day', num2str(g)])
                    xlabel('log(r)');
                    ylabel('log(Intersections/Area)');
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Intersections2Log-Log%s_%s.bmp', num2str(cell),num2str(g)), 'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;

                end;
                
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif var == 23
% 
%         Nm2 = DMg(cell, 81, g);

%     elseif var == 24
      elseif var == 18
        
             for i = 1: size(DMg, 1)   %scorro le cellule

                for j = 1:size(DMg, 3)   %scorro il tempo

                    if DMg (i, 175, j) ~= 0

                        giniziale = j;
                        break;

                    end;

                end;

            end;

%             for i = 1: size(DMg, 1)   %scorro le cellule
% 
%                 for j = size(DMg, 3): -1: 1   %scorro il tempo all'indietro
% 
%                     if DMg (i, 175, j) ~= 0
% 
%                         gfinale = j;
%                         break;
% 
%                     end;
% 
%                 end;
% 
%             end;       

        for g = giniziale:size(DMg, 3)
            
        for i = 1: size(DMg, 1)
            
            rmax = DMg(i, 175, g);
            v(i) = DMg(i, 80, g)/rmax;
            
        end;
        
        for j = 1:length(v)
            
            if v(j) == 0
                
                v(j)= NaN;
            end;
            
        end;
        
        figure, plot(v,'*'), title(['Reference System inter-circle costant distance: Critical radius for all cells Day', num2str(g)])
        xlabel('Cell')
        ylabel('rc')
        
        cd(pathname2)
        saveas(gcf,sprintf('rc2cells_%s.bmp',num2str(g)),'bmp')
        cd(olddir)
        
        end;


%     elseif var == 25
% 
%         Schoenen2 = DMg(cell, 82, g);

%     elseif var == 26
      elseif var == 19

            k = zeros(1, 23);
            
            for i = 1: size(DMg, 1)   %scorro le cellule
    
                for j = 1:size(DMg, 3)   %scorro il tempo

                    if DMg (i, 83, j) ~= 0

                        giniziale = j;
                        break;

                    end;

                end;

            end;

%             for i = 1: size(DMg, 1)   %scorro le cellule
% 
%                 for j = size(DMg, 3): -1: 1   %scorro il tempo all'indietro
% 
%                     if DMg (i, 83, j) ~= 0
% 
%                         gfinale = j;
%                         break;
% 
%                     end;
% 
%                 end;
% 
%             end;
            
            for g = giniziale:size(DMg, 3)
                
            for i = 1: size(DMg, 1) 
                
                v(i) = DMg(i, 83, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            k(g) = mean(v(~isnan(v)));
            figure, plot(v,'*'), title(['Reference System inter-circle costant distance: ksl fro all cells Day', num2str(g)])
            xlabel('Cell')
            ylabel('ksl')
            
            cd(pathname2)
            saveas(gcf,sprintf('ksl2cells_%s.bmp',num2str(g)),'bmp') 
            cd(olddir)
            
            end;

% 
%     elseif var == 27
% 
%         Rsl2 = DMg(cell,84,g);
% 
%     elseif var == 28
% 
%         kll2 = DMg(cell,85,g);
% 
%     elseif var == 29
% 
%         Rll2 = DMg(cell,86,g);
 
%     elseif var == 30
      elseif var == 20
        
        for i = 1: size(DMg, 1)   %scorro le cellule
    
            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 87, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;

         for g = giniziale:size(DMg, 3)
%g=1
            for i = 1: size(DMg, 1)
                
                v(i)= DMg(i, 87, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j)=NaN;
                    
                end;
                
            end;
            
%             v
            figure, plot(v,'*'),title(['Reference System inter-circle costant distance: Delta for all cells Day',num2str(g)])
            xlabel('Cell')
            ylabel('\Delta')
            x=1:0.1:10;
            y=1;
            hold on
            plot(x,y,'r--')
            
            cd(pathname2)
            saveas(gcf,sprintf('Deltacells_%s.bmp',num2str(g)),'bmp')      
            cd(olddir)
            
         end;

%     elseif var == 31
      elseif var == 21
        
        for i = 1: size(DMg, 1)   %scorro le cellule
    
            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 8, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;

        for g = giniziale:size(DMg, 3)
             
            for i = 1: size(DMg, 1)
                
                v(i) = DMg(i, 8, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure, plot(v,'*'), title(['Reference System constant circle: Fractal dimension for all cells Day', num2str(g)])
            
            cd(pathname2)
            saveas(gcf, sprintf('Pestrcells_%s.bmp', num2str(g)), 'bmp')
            cd(olddir)
            
        end;

%     elseif var == 32
      elseif var == 22

        reply='Yes';

        while strcmp('Yes',reply)==1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g = 1;
            
             while g < (size(DMg, 3) +1)
                 
                u = DMg(cell, 89:108, g) ~= zeros(1, 20, 1);
                z = find(u);
                
                if length(z) ~= 0
                    
                    ind = find(DMg(cell,89:108,g));
                    c = DMg(cell, 89:89+max(ind)-1, g);
                    figure
                    plot(c);
                    title({'Sistema di rif. distanza inter-cerchio cost.:'; ['Min lenght from the main axes extremity to centre', num2str(cell), ' Day', num2str(g)]})
                    xlabel('Circle')
                    ylabel('Min Lenght')
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Lminestr%s_%s.bmp', num2str(cell),num2str(g)), 'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;
                 
             end;
             
            reply = questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif var == 33
      elseif var == 23

        reply='Yes';

        while strcmp('Yes',reply) == 1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g = 1;
            
             while g < (size(DMg, 3) +1)
                 
                u = DMg(cell, 109:128, g )~= zeros(1, 20, 1);
                z = find(u);
                
                if length(z) ~= 0
                    
                    ind = find(DMg(cell, 109:128, g));
                    c = DMg(cell, 109:109+max(ind)-1, g);
                    figure
                    plot(c);
                    title({'Sistema di rif. distanza inter-cerchio cost.:'; ['Angles on main axes Cell',num2str(cell), ' Day', num2str(g)]})
                    xlabel('Circle')
                    ylabel('Angle')
                    saveas(gcf,sprintf('Aextrcells%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    
                end;
                
                 g=g+1;
                 
                end;
                
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif var == 34
      elseif var == 24
        
         for i = 1: size(DMg, 1)   %scorro le cellule

            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 129, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;   

        for g = giniziale:size(DMg, 3)
            
            for i = 1: size(DMg, 1)
                
                v(i) = DMg(i, 129, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            figure, plot(v,'*'), title(['Reference System constant circle: Axes distance for all cells Cell', num2str(cell), ' Day', num2str(g)])
            
            cd(pathname2)
            saveas(gcf, sprintf('Paxescells_%s.bmp',num2str(g)), 'bmp')
            cd(olddir)
            
        end;

%     elseif var == 35
      elseif var == 25

        reply='Yes';

        while strcmp('Yes',reply)==1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cell from 1 to 25: ', 's');
%             cell=str2num(cellula);
            g = 1;
            a = zeros(1, size(DMg, 3));
            
             while g < (size(DMg, 3) +1)
                 
                u = DMg(cell, 130:149, g) ~= zeros(1, 20, 1);
                z = find(u);
                
                if length(z) ~= 0
                    
                    ind = find(DMg(cell, 130:149, g));
                    c = DMg(cell, 130:130+max(ind)-1, g);
                    mas = max(c(2:length(c)-1));
                    mini = min(c(2:length(c)-1));
                    a(g) = mas-mini;
                    figure
                    plot(c(2:length(c)-1)); axis([2 length(c)-1 0 80])
                    title({'Reference System inter-circle constant distance:'; ['Min lenght on main axes Cell',num2str(cell)]})%,' Giorno',num2str(g)]})
                    xlabel('Circle')
                    ylabel('Min Lenght')
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Lminaxes%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;
                 
        end;
        
         reply= questdlg('Do you want to see the variable for an other cell?');
            
%         end;
%             for j=1:length(a)
%                 if a(j)==0
%                     a(j)=NaN;
%                 end;
%             end;
            
%             if cell<14
%                     x=17:2:23;
%                     y=a(17:2:23);
%                     x1=17:1:23;
%                     y1 =interp1(x,y,x1,'spline');
%                     a=cat(2,a(1:17),y1(2:length(y1)));
%             else
%                 if  ~isnan(a(17))
%                     x=15:2:17;
%                     y=a(15:2:17);
%                     x1=15:1:17;
%                     y1 =interp1(x,y,x1,'spline');
%                     a(15:17)=y1;
%                   end
%             end
%             plot(1:23,a,'-o')
%             title({'Sistema di rif. distanza inter-cerchio cost.:';['Indice di tortuosità Cellula',num2str(cell)]})
%             xlabel('t')
%             ylabel('\alpha')
%             saveas(gcf,sprintf('alfa%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
%             hold on
%             reply= input('Vuoi vedere la variabile per un''altra cellula Y/N:', 's');
        end;

%     elseif var == 36
      elseif var == 26

        reply = 'Yes';

        while strcmp('Yes',reply)==1
            
            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

%             cellula= input('Cellula da 1 a 25: ', 's');
%             cell=str2num(cellula);
            g=1;
            
             while g < (size(DMg, 3) +1)
                 
                u = DMg(cell, 150:169, g) ~= zeros(1, 20, 1);
                z = find(u);
                
                if length(z) ~= 0
                    
                    ind = find(DMg(cell, 150:169, g));
                    c = DMg(cell, 150:150+max(ind)-1, g);
                    figure
                    plot(2:length(c)-1, c(2:length(c)-1)); axis([2 length(c)-1 min(2:length(c)-1) max(2:length(c)-1)])
                    figure
%                     c
                    plot(c);
                    title({'Reference System inter-circle constant distance:';['Angle from the main axes extremity to centre  Cell',num2str(cell)]}) %,' Giorno',num2str(g)]})
                    xlabel('Circle')
                    ylabel('Angles')
                    
                    cd(pathname2)
                    saveas(gcf,sprintf('Aaxes%s_%s.bmp',num2str(cell),num2str(g)),'bmp')
                    cd(olddir)
                    
                end;
                
                 g=g+1;
                 
             end;
             
            reply = questdlg('Do you want to see the variable for an other cell?');
            
        end;

%     elseif var == 37
      elseif var == 27
        
        for i = 1: size(DMg, 1)   %scorro le cellule

            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 170, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;

%         for i = 1: size(DMg, 1)   %scorro le cellule
% 
%             for j = size(DMg, 3): -1: 1   %scorro il tempo all'indietro
% 
%                 if DMg (i, 170, j) ~= 0
% 
%                     gfinale = j;
%                     break;
% 
%                 end;
% 
%             end;
% 
%         end;        
        
           g = 1;
           
         for g = giniziale:size(DMg, 3)

            for i = 1: size(DMg, 1)
                
                v(i) = DMg(i, 170, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure, plot(v,'*'), title(['All cells extensions Day', num2str(g)])
            xlabel('Cell')
            ylabel('Extension')
            
            cd(pathname2)
            saveas(gcf,sprintf('Extensioncells_%s.bmp',num2str(g)),'bmp')
            cd(olddir)
            
         end;

%       elseif var == 38
        elseif var == 28
          
          g = 1;
          
            for i = 1: size(DMg, 1)   %scorro le cellule

                for j = 1:size(DMg, 3)   %scorro il tempo

                    if DMg (i, 171, j) ~= 0

                        giniziale = j;
                        break;

                    end;

                end;

            end;        
          
          for g = giniziale:size(DMg, 3)

            for i = 1: size(DMg, 1)
                
                v(i) = DMg(i, 171, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure,  plot(v, '*'), title(['All cell soma area Day', num2str(g)])
            xlabel('Cell')
            ylabel('Soma Area')
            
            cd(pathname2)
            saveas(gcf,sprintf('AreaSomacells_%s.bmp',num2str(g)),'bmp')
            cd(olddir)
            
          end;

%     elseif var == 39
      elseif var == 29
          
          g = 1;
   
        for i = 1: size(DMg, 1)   %scorro le cellule

            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 172, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;       

         for g = giniziale:size(DMg, 3)

            for i = 1:size(DMg, 1)
                
                v(i) = DMg(i, 172, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure, plot(v, '*'), title(['All cells cone angle Day', num2str(g)])
            xlabel('Cell')
            ylabel('Cone Angle')
            
            cd(pathname2)
            saveas(gcf,sprintf('Cone Anglecells_%s.bmp',num2str(g)),'bmp')
            cd(olddir)
            
         end;

%     elseif var == 40
      elseif var == 30

        reply = 'Yes';

        while strcmp('Yes',reply)==1
%             
%             a = 'Cell from 1 to ';
%             b = num2str(size(DMg, 1));
%             c = [a b];
%             prompt = {c};
%             dlg_title = 'cell choice';
%             num_lines = 1;
%             answer = inputdlg(prompt, dlg_title, num_lines);
%             cell = str2num(cell2mat(answer));
%             cellula = cell2mat(answer);

%          coltura= input('Culture ', 's')
%          cellula= input('Cell: ', 's')

        helpdlg('Select the cell you want to analyze');
        uiwait
        
        [filename, fileFolder] = uigetfile({'*.jpg;*.tif;*.bmp;*.png;*.gif','All Image Files'}, 'Pick an image');
        
%         cell = str2num(cellula);
        
        %fileFolder = fullfile('C:','Documents and Settings','chiara','Documenti','tesi_triennale_mia', 'NEMO','Immagini',sprintf('Coltura%s',coltura),sprintf('%s%s',coltura,cellula));

        dirOutput = dir(fullfile(fileFolder,'s_*.jpg'));
        fileNames = {dirOutput.name}' ;
        nu=numel(fileNames);
        addpath(fileFolder);
        
        for i = 1:nu
            
            scheletro1 = imread(fileNames{i});
            S = char(fileNames{i});
            [a b gg d] = strread(S, '%s %s %d %d', 'delimiter', '_');
            
            level = graythresh(scheletro1);
            scheletro = im2bw(scheletro1,level);
        
        figure
        imshow(scheletro)
        figure
        
        cd(olddir)  
        
        [x,y] = find(scheletro==0);
        coordmat=cat(2,x,y);
        frac_dim = boxcount(coordmat, 5, 1);
        
%         [n, r] = boxcount(scheletro, 1);
%         loglog(r, n, 'bo-', r, (r/r(end)).^(-2), 'r--')
%         xlabel('r')
%         ylabel('n(r)')
%         legend('actual box-count', 'space-filling box-count');
%          title(['Box-counting Giorno ', num2str(d)])
%          saveas(gcf,sprintf('Box-counting_%s_%s.bmp', char(b), num2str(d)), 'bmp')
        
%                 figure
%                 [n,r] = boxcount(scheletro, 'slope');
%                 s = -diff(log(n))./diff(log(r));
%                 semilogx(r(1:end-1), s, 's-');
%     xlabel('r, box size'); ylabel('- d ln n / d ln r, local dimension');
%                  title(['Box-counting slope Giorno ', num2str(d)])
                 
                 cd(pathname2)
                 saveas(gcf, sprintf('Box-countingslope_%s_%s.bmp', char(b), num2str(d)), 'bmp')
                 cd(olddir)
                 
        end;
        
            reply= questdlg('Do you want to see the variable for an other cell?');
            
        end;
        
%         cd('C:\Documents and Settings\Utente\Desktop\ProgMatlab\SOFTWARE_PURKINJE')   %???
        
%     elseif var == 41
      elseif var == 31
          
        g = 1;
        
        for i = 1: size(DMg, 1)   %scorro le cellule
    
            for j = 1:size(DMg, 3)   %scorro il tempo

                if DMg (i, 173, j) ~= 0

                    giniziale = j;
                    break;

                end;

            end;

        end;

%         for i = 1: size(DMg, 1)   %scorro le cellule
% 
%             for j = size(DMg, 3): -1: 1   %scorro il tempo all'indietro
% 
%                 if DMg (i, 173, j) ~= 0
% 
%                     gfinale = j;
%                     break;
% 
%                 end;
% 
%             end;
% 
%         end;
        
         for g = giniziale:size(DMg, 3)

            for i = 1:size(DMg, 1)
                
                v(i) = DMg(i, 173, g);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure, plot(v,'*'), title(['Reference System constant circle: All cells fractal dimensions']) % Giorno',num2str(g)])
            xlabel('Cell')
            ylabel('Fractal DImension')
            x1 = 1:0.1:25;
            y1 = 1.94;
            hold on
            plot(x1,y1, 'r--')
            x2 = 1:0.1:25;
            y2 = 2;
            plot(x2, y2, 'r--')
            
            cd(pathname2)
            saveas(gcf, sprintf('DimFrattcells_%s.bmp', num2str(g)), 'bmp')
            cd(olddir)
            
         end;
 end;
     
    
elseif strcmp('g', tipo) == 0

    reply = 'Yes';

    while strcmp('Yes', reply) == 1

%         cellula= input('Cell from 1 to 25: ', 's');
%         cell=str2num(cellula);

            a = 'Cell from 1 to ';
            b = num2str(size(DMg, 1));
            c = [a b];
            prompt = {c};
            dlg_title = 'cell choice';
            num_lines = 1;
            answer = inputdlg(prompt, dlg_title, num_lines);
            cell = str2num(cell2mat(answer));
            cellula = cell2mat(answer);

        if var == 1

            Int1t = zeros(10, size(DMg, 3));

            for j = 1:10
                
                for i = 1: size(DMg, 3)
                    
                    Int1t(j,i) = DMg(cell, j, i);
                    
                    if Int1t(j,i) == 0;
                        
                        Int1t(j,i) = NaN;
                        
                    end;
                    
                end;
                
            end;

                    for j = 1:size(Int1t, 2)   %scorro il tempo

                        if Int1t (:, j) ~= 0

                            giniziale = j;
                            break;

                        end;

                    end;
                    
        for i = 1:size(Int1t, 2)
        
        if Int1t (:, i) == zeros(size(Int1t, 1), 1)    %se ho un vettore colonna di tutti zeri
            
        salto = i;
        
        for i = 1:10
                    
            x = (salto-1):2:(salto+1);
            y = Int1t(i, (salto-1):2:(salto+1));
            x1 = (salto-1):1:(salto+1);
            y1 = interp1(x, y, x1, 'spline');
            Int1t(i, :) = cat(2, Int1t(i, 1:(salto-1)), y1(2:length(y1)));
                    
        end;
           
        end;
        
        end;          
            
%             if cell < size(DMg, 1)
                
%                 for i = 1:10
%                     
%                     x = giniziale:2:size(DMg, 3);
%                     y = Int1t(i, giniziale:2:size(DMg, 3));
%                     x1 = giniziale:1:size(DMg, 3);
%                     y1 = interp1(x, y, x1, 'spline');
%                     Int1t(i, :) = cat(2, Int1t(i, 1:giniziale), y1(2:length(y1)));
%                     
%                 end;
%                 
%             else
%                 
%                 if  ~isnan(Int1t(17))         %????
%                     
%                     x = 15:2:17;
%                     y = Int1t(15:2:17);
%                     x1 = 15:1:17;
%                     y1 = interp1(x, y, x1, 'spline');
%                     Int1t(15:17) = y1;
%                     
%                 end;
%                 
%             end;
            
                figure
                plot(1:1:size(DMg, 3), Int1t'), title(['Reference System constant circle: Intersections\time Cell', num2str(cell)])
                legend('circle1', 'circle2', 'circle3', 'circle4', 'circle5', 'circle6', 'cerchio7', 'circle8', 'circle9', 'circle10', 'Location', 'EastOutside')
                grid on
                xlabel('t')
                ylabel('Intersections')
                
                cd(pathname2)
                saveas(gcf, sprintf('Intersections1t_%s.bmp', cellula, 'bmp')) 
                cd(olddir)
                
           
        elseif var == 5
            
            for i = 1: size(DMg, 1)   %scorro le cellule

                for j = 1:size(DMg, 3)   %scorro il tempo

                    if DMg (i, 12, j) ~= 0

                        giniziale = j;
                        break;

                    end;

                end;

            end;         

            v = zeros(1, size(DMg, 3));
            
            for i = 1:size(DMg, 3)
                
                v(i) = DMg(cell, 12, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
         for i = 1:size(DMg, 3)

                if DMg (:, 12, i) == zeros(size(DMg, 1), 1, 1)    %se ho una colonna di tutti zeri

                salto = i;

%                 for i = 1:10

                    x = (salto-1):2:(salto+1);
                    y = v(salto-1):2:(salto+1);
                    x1 = (salto-1):1:(salto+1);
                    y1 = interp1(x, y, x1, 'spline');
                    v = cat(2, v(1:giniziale), y1(2:length(y1)));

%                 end;

                end;

        end;         
            
%             if cell < 14    %?????
%                 
%                     x = 17:2:size(DMg, 3);
%                     y = v(17:2:size(DMg, 3));
%                     x1 = 17:1:size(DMg, 3);
%                     y1 = interp1(x, y, x1, 'spline');
%                     v = cat(2, v(1:giniziale), y1(2:length(y1)));
%                     
%             else
%                 
%                 if  ~isnan(v(17))
%                     
%                     x = 15:2:17;    %??? 15 17
%                     y = v(15:2:17);
%                     x1 = 15:1:17;
%                     y1 = interp1(x, y, x1, 'spline');
%                     v(15:17) = y1;    %???
%                     
%                 end;
%                 
%             end;
            
                figure, plot(1:size(DMg, 3), v, '-o')
                title(['Reference Sustem constant cell: Nm  Cell', num2str(cell)])
                xlabel('t')
                ylabel('Nm')
                
                cd(pathname2)
                saveas(gcf, sprintf('Nm1t_%s.bmp', cellula, 'bmp'))
                cd(olddir)
    
       
        elseif var == 6
            
            for i = 1: size(DMg, 1)   %scorro le cellule

                for j = 1:size(DMg, 3)   %scorro il tempo

                    if DMg (i, 11, j) ~= 0

                        giniziale = j;
                        break;

                    end;

                end;

            end;       

            v = zeros(1, size(DMg, 3));
            
            for i = 1: size(DMg, 3)
                
                v(i) = DMg(cell, 11, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
                 for i = 1:size(DMg, 3)

                        if DMg (:, 12, i) == zeros(size(DMg, 1), 1, 1)    %se ho una colonna di tutti zeri

                        salto = i;

        %                 for i = 1:10

                            x = (salto-1):2:(salto+1);
                            y = v(salto-1):2:(salto+1);
                            x1 = (salto-1):1:(salto+1);
                            y1 = interp1(x, y, x1, 'spline');
                            v = cat(2, v(1:giniziale), y1(2:length(y1)));

        %                 end;

                        end;

                end;              
            
%             if cell<14    %????
%                 
%                     x = giniziale:2:size(DMg, 3);
%                     y = v(giniziale:2:size(DMg, 3));
%                     x1 = giniziale:1:size(DMg, 3);
%                     y1 = interp1(x, y, x1, 'spline');
%                     v = cat(2, v(1:17), y1(2:length(y1)));
%                     
%             else
%                 
%                 if  ~isnan(v(17))    %????
%                     
%                     x = 15:2:17;    %????
%                     y = v(15:2:17);
%                     x1 = 15:1:17;
%                     y1 = interp1(x, y, x1, 'spline');
%                     v(15:17) = y1;
%                     
%                 end;
%                 
%             end;
            
                figure,plot(1:size(DMg, 3),v,'-o')
                title(['Reference System constant circle: rc  Cell', num2str(cell)])
                xlabel('t')
                ylabel('rc')
                
                cd(pathname2)
                saveas(gcf, sprintf('rc1t_%s.bmp', cellula, 'bmp'))
                cd(olddir)
                

        elseif var == 7

            v = zeros(1, size(DMg, 3));
            
            for i = 1:size(DMg, 3)
                
                v(i) = DMg(cell, 13, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure, plot(v, '*')
            title('Reference System constant circle: Schoenen parameter')

%         elseif var == 8
% 
%             v = zeros(1, size(DMg, 3));
%             
%             for i = 1:size(DMg, 3)
%                 
%                 v(i) = DMg(cell, 14, i);
%                 
%             end;
%             
%             for j = 1:length(v)
%                 
%                 if v(j) == 0
%                     
%                     v(j) = NaN;
%                     
%                 end;
%                 
%             end;
%             
%             figure,plot(v, '*')
%             title('Reference System constant circle:  ksl')
% 
%         elseif var == 9
% 
%             v = zeros(1, size(DMg, 3));
%             
%             for i = 1:size(DMg, 3)
%                 
%                 v(i) = DMg(cell, 15, i);
%                 
%             end;
%             
%             for j = 1:length(v)
%                 
%                 if v(j) == 0
%                     
%                     v(j) = NaN;
%                     
%                 end;
%                 
%             end;
%             
%             figure,plot(v, '*')
%             title('Reference System constant circle: Rsl')
% 
% 
%         elseif var == 10
% 
%             v = zeros(1, size(DMg, 3));
%             
%             for i = 1:size(DMg, 3)
%                 
%                 v(i) = DMg(cell, 16, i);
%                 
%             end;
%             
%             for j = 1:length(v)
%                 
%                 if v(j) == 0
%                     
%                     v(j) = NaN;
%                     
%                 end;
%                 
%             end;
%             
%             figure,plot(v,'*')
%             title('Reference System constant circle: kll')
% 
%         elseif var == 11
% 
%             v = zeros(1,size(DMg, 3));
%             
%             for i = 1:size(DMg, 3)
%                 
%                 v(i) = DMg(cell, 17, i);
%                 
%             end;
%             
%             for j = 1:length(v)
%                 
%                 if v(j) == 0
%                     
%                     v(j) = NaN;
%                     
%                 end;
%                 
%             end;
%             figure, plot(v, '*')
%             title('Reference System constant circle: Rll')

%         elseif var == 12
          elseif var == 7

            v = zeros(1, size(DMg, 3));
            
            for i = 1:size(DMg, 3)
                
                v(i) = DMg(cell, 18, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure,plot(v, '*')
            title('Reference System constant circle: Delta')

%         elseif var == 13
          elseif var == 8

            v = zeros(1, size(DMg, 3));
            
            for i = 1:size(DMg, 3)
                
                v(i) = DMg(cell, 15, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
            figure, plot(v, '*')
            title('Reference System constant circle: Distance from the extremity to centre')
            
            cd(pathname2)
            saveas(gcf, sprintf('Pestr1t_%s.bmp', cellula, 'bmp'))
            cd(olddir)
            
%         elseif var == 16
          elseif var == 11
            
            for i = 1: size(DMg, 1)   %scorro le cellule

                for j = 1:size(DMg, 3)   %scorro il tempo

                    if DMg (i, variab, j) ~= 0

                        giniziale = j;
                        break;

                    end;

                end;

            end;            

            v = zeros(1, size(DMg, 3));
            
            for i = 1:10
                
                v(i) = DMg(cell, 39, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
%             if cell<14 %???
%                 
%                 x = giniziale:2:size(DMg, 3);    %???
%                 y = v(giniziale:2:size(DMg, 3));
%                 x1 = giniziale:1:size(DMg, 3);
%                 y1 = interp1(x, y, x1, 'spline');
%                 v = cat(2, v(1:17), y1(2:length(y1)));
%                 
%             else
%                
%                 if  ~isnan(v(17))   %???
%                     
%                     x = 15:2:17;
%                     y = v(15:2:17);
%                     x1 = 15:1:17;
%                     y1 = interp1(x, y, x1, 'spline');
%                     v(15:17) = y1;
%                     
%                 end;
%                 
%             end;
            
                figure,plot(1:size(DMg, 3), v, '-o')
                title(['Reference System constant circle: distance on main axes to centre Cell', num2str(cell)])
                xlabel('t')
                ylabel('Axis distance')
                
                cd(pathname2)
                saveas(gcf, sprintf('Distanceaxest_%s.bmp', cellula, 'bmp'))
                cd(olddir)

%         elseif var == 19
          elseif var == 14

            Int2t = zeros(20, size(DMg, 3));

            figure
            indice = 60;
            for j = 1:20
                
                for i = 1:size(DMg, 3)
                    
                    Int2t(j,i) = DMg(cell, indice, i);
                    
                    if Int2t(j, i)==0;
                        
                        Int2t(j,i) = NaN;
                        
                    end;
                    
                end;
                
                indice = indice+1;
            
            end;
            
            y = Int2t;
            %qui c'era Int1t
            for i = 1:size(Int2t, 2)

                    if Int2t (:, i) == zeros(size(Int2t, 1), 1)    %se ho un vettore colonna di tutti zeri

                    salto = i;

                    for j = 1:10

                                x = (salto-1):2:(salto+1);
                                y = Int1t(j, (salto-1):2:(salto+1));
                                x1 = (salto-1):1:(salto+1);
                                y1 = interp1(x, y, x1, 'spline');
                                Int2t(j, :) = cat(2, Int2t(j, 1:(salto-1)), y1(2:length(y1)));

                    end;

                    end;

            end;            
%             if cell<14
%                 for i=1:10
%                     x=17:2:23;
%                     y=Int2t(i,17:2:23);
%                     x1=17:1:23;
%                     y1 =interp1(x,y,x1,'spline');
%                     Int1t(i,:)=cat(2,Int2t(i,1:17),y1(2:length(y1)));
%                 end
%             else
%                 if  ~isnan(Int2t(17))
%                     x=15:2:17;
%                     y=Int2t(15:2:17);
%                     x1=15:1:17;
%                     y1 =interp1(x,y,x1,'spline');
%                     Int2t(15:17)=y1;
%                   end 
%             end;

            plot(1:size(DMg, 3),Int2t','-o'), title(['Reference System constant inter-circle distance: Intersection\time'])
            legend('circle1','circle2','circle3','circle4','circle5','circle6','circle7','circle8','circle9','circle10','circle11','circle12','Location','EastOutside')
            grid on
            
             cd(pathname2)
             saveas(gcf,sprintf('Intersections2t_%s.bmp',cellula,'bmp'))
             cd(olddir)

% %         elseif var == 23
%      
%             
%             v = zeros(25, size(DMg, 3));
%             
%             for j = 1:25
%                 
%             for i = 1:size(DMg, 3)
%                 
%                 v(j,i) = DMg(j, 81, i);
%                 
%                 if v(j,i) == 0;
%                     
%                     v(j,i) = NaN;
%                     
%                 end;
%                 
%             end;
%             
%             end;
% 
%             if cell<14
%                 
%                   x = 17:2:size(DMg, 3);   %???
%                   y = n(17:size(DMg, 3));
%                 x1 = 17:1:size(DMg, 3);
%                 y1 = interp1(x, y, x1, 'spline');
%                 v = cat(2, v(1:17), y1(2:length(y1)));
%                 
%             else
%                 
%                 if  ~isnan(v(17))    %????
%                     x = 15:2:17;
%                     y = v(15:2:17);
%                     x1 = 15:1:17;
%                     y1 = interp1(x, y, x1, 'spline');
%                     v(15:17) = y1;
%                 end;
%                 
%             end;

%                 n=nanmean(v);
%                  x=17:23;
%                   y=n(17:23);
%                 x1=17:1:23;
%                 y1 =interp1(x,y,x1,'spline');
%                 n=cat(2,n(1:17),y1(2:length(y1)));
%                x=1:23;
%                 E = nanstd(n) *ones(size(x));
%                 n
%                 E
%            figure,errorbar(x,n,E,'-o'),title('Sistema di riferimento distanza inter-cerchio costante: Andamento di Nm medio'),axis([1 23 min(n) max(n)])
%             xlabel('t')
%             ylabel('Nm')
%             saveas(gcf,sprintf('Nm2t_%s.bmp',cellula,'bmp'))
%             figure,plot(v,'-o'),title(['Sistema di riferimento distanza inter-cerchio costante: Andamento di Nm  Cellula',num2str(cell)]),axis([1 23 0 max(v)])
%             xlabel('t')
%             ylabel('Nm')
%             saveas(gcf,sprintf('Nm2t_%s.bmp',cellula,'bmp'))
            
%         elseif var == 24
        elseif var == 18
            
            v = zeros(25, size(DMg, 3));
   
            for i = 1:23
                
                rmax = DMg(j, 175, i);
                v(i) = DMg(j, 80, i)/rmax;
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
%             if cell<14
%                 
%                 x = 17:2:size(DMg, 3);
%                 y = v(17:2:size(DMg, 3));
%                 x1 = 17:1:size(DMg, 3);
%                 y1 = interp1(x, y, x1, 'spline');
%                 v = cat(2, v(1:17), y1(2:length(y1)));
%                 
%             else
%                 
%                 if  ~isnan(v(17))   %??
%                     x = 15:2:17;
%                     y = v(15:2:17);
%                     x1 = 15:1:17;
%                     y1 = interp1(x, y, x1, 'spline');
%                     v(15:17)=y1;
%                 end;
%                 
%             end;
            
            figure, plot(v, '-o'),title(['Reference System constant inter-circle distance: rc  Cell', num2str(cell)]), axis([1 23 0 max(v)])
            xlabel('t')
            ylabel('rc')
            
            cd(pathname2)
            saveas(gcf,sprintf('rc2t_%s.bmp',cellula),'bmp')
            cd(olddir)

%         elseif var == 25
% 
%             v=zeros(1,size(DMg, 3));
%             
%             for i=1:size(DMg, 3)
%                 
%                 v(i)= DMg(cell, 82, i);
%                 
%             end;
%             
%             for j=1:length(v)
%                 
%                 if v(j) == 0
%                     
%                     v(j)=NaN;
%                     
%                 end;
%                 
%             end;
%             
%             figure,plot(v,'*')
%             title('Reference System constant inter-circle distance: Schoenen parameter')

%         elseif var == 26
        elseif var == 19

%             v=zeros(1,23);
%             for i=1:23
%                 v(i)= DMg(cell,83,i);
%             end
%             for j=1:length(v)
%                 if v(j)==0
%                     v(j)=NaN;
%                 end;
%             end;
%             figure,plot(v,'*')
%             title('Sistema di riferimento distanza inter-cerchio costante: Andamento di ksl')

              v=zeros(size(DMg, 1),size(DMg, 3));
              
            for j=1:size(DMg, 1)
                
            for i = 1:size(DMg, 3)
                
                v(j,i) = DMg(j, 83, i);
                
                if v(j,i) == 0;
                    
                    v(j,i) = NaN;
                    
                end;
                
            end;
            
            end;
            
            n=nanmean(v);     %???
                  x = 17:size(DMg, 3);
                  y = n(17:size(DMg, 3));
                x1 = 17:1:size(DMg, 3);
                y1 = interp1(x,y,x1,'spline');
                n  =cat(2,n(1:17),y1(2:length(y1)));
                x = 1:size(DMg, 3);
                E = nanstd(n) *ones(size(x));
%             x
%             n
%             E
           figure,errorbar(x, n, E, 'o'),title('Reference System constant inter-circle distance: mean ksl'),axis([1 23 min(n) max(n)])
            xlabel('t')
            ylabel('ksl')
            
            cd(pathname2)
            saveas(gcf,sprintf('ksl2t_%s.bmp',cellula,'bmp'))
            cd(olddir)

%          elseif var == 27
% 
% 
%             v=zeros(1,size(DMg, 3));
%             
%             for i=1:c
%                 
%                 v(i)= DMg(cell, 84, i);
%                 
%             end;
%             
%             for j=1:length(v)
%                 
%                 if v(j) == 0
%                     
%                     v(j) = NaN;
%                     
%                 end;
%                 
%             end;
%             
%             figure,plot(v,'*')
%             title('Reference System constant inter-circle distance: Rsl')
% 
%         elseif var == 28
% 
%             v = zeros(1, size(DMg, 3));
%             
%             for i = 1:size(DMg, 3)
%                 
%                 v(i) = DMg(cell,85,i);
%                 
%             end;
%             
%             for j = 1:length(v)
%                  
%                 if v(j) == 0 
%                     
%                     v(j) = NaN;
%                     
%                 end;
%                 
%             end;
%             
%             figure,plot(v,'*')
%             title('Reference System constant inter-circle distance: kll')
% 
%         elseif var == 29
% 
%             v = zeros(1,size(DMg, 3));
%             
%             for i = 1:size(DMg, 3)
%                 
%                 v(i) = DMg(cell, 86, i);
%                 
%             end;
%             
%             for j = 1:length(v)
%                 
%                 if v(j) == 0
%                     
%                     v(j) = NaN;
%                     
%                 end;
%                 
%             end;
%             
%             figure,plot(v,'*')
%             title('Reference System constant inter-circle distance: Rll')

%         elseif var == 30
        elseif var == 20

%             v=zeros(1,23);
%             for i=1:23
%                 v(i)= DMg(cell,87,i);
%             end
%             for j=1:length(v)
%                 if v(j)==0
%                     v(j)=NaN;
%                 end;
%             end;
%             figure,plot(v,'-o'),axis([1 23 0.5 1.])
%             title('Sistema di riferimento distanza inter-cerchio costante: Andamento di Delta')

             v = zeros(size(DMg, 1), size(DMg, 3));
             
            for j = 1:size(DMg, 1)
                
            for i = 1:size(DMg, 3)
                
                v(j,i)= DMg(j, 87, i);
                
                if v(j,i) == 0;
                    
                    v(j,i) = NaN;
                    
                end;
                
            end;
            
            end;
            
            n = nanmean(v);    %???
                 x = 17:size(DMg, 3);
                  y = n(17:size(DMg, 3));
                x1=17:1:size(DMg, 3);
                y1 =interp1(x,y,x1,'spline');
                n=cat(2,n(1:17),y1(2:length(y1)));
               x=1:size(DMg, 3);
                E = nanstd(n) *ones(size(x));
            
           figure,plot(x,n,'-o'),title(' Delta\time'),axis([1 23 0.5 1.5])
            xlabel('t')
            ylabel('\Delta')
            
            cd(pathname2)
            saveas(gcf,sprintf('Deltat_%s.bmp',cellula,'bmp'))
            cd(olddir)

%         elseif var == 31
        elseif var == 21

            v = zeros(1,size(DMg, 3));
            
            for i = 1:size(DMg, 3)
                
                v(i)= DMg(cell, 88, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j)=NaN;
                    
                end;
                
            end;
            
            figure,plot(v,'*'), axis([1 23 0 max(v)])
            title('Reference System constant circle: distance from extremity to center')

        elseif var == 34

%             v=zeros(1,23);
%             for i=1:23
%                 v(i)= DMg(cell,129,i);
%             end
%             for j=1:length(v)
%                 if v(j)==0
%                     v(j)=NaN;
%                 end;
%             end;
%             if cell<14
%                 x=17:2:23;
%                 y=v(17:2:23);
%                 x1=17:1:23;
%                 y1 =interp1(x,y,x1,'spline');
%                 v=cat(2,v(1:17),y1(2:length(y1)));
%             else
%                 if  ~isnan(v(17))
%                     x=15:2:17;
%                     y=v(15:2:17);
%                     x1=15:1:17;
%                     y1 =interp1(x,y,x1,'spline');
%                     v(15:17)=y1;
%                 end
%             end
%                 figure,plot(1:23,v,'-o'),axis([1 23 0 max(v)])
%                 title({'Sistema di rif. distanza inter-cerchio cost.:';['Andamento del percorso dall''estremità dell''asse principale  Cellula',num2str(cell)]})
%                 xlabel('t')
%                 ylabel('Percorso asse')
%                 saveas(gcf,sprintf('Percorsoasset_%s.bmp',cellula),'bmp')

              v = zeros(size(DMg, 1), size(DMg,3));
              
            for j=1:size(DMg, 1)
                
            for i=1:size(DMg, 3)
                
                v(j,i) = DMg(j, 129, i);
                
                if v(j,i) == 0;
                    
                    v(j,i) = NaN;
                    
                end;
                
            end;
            
            end;
            
            n=nanmean(v);   %???
                 x=17:size(DMg, 3);
                  y=n(17:size(DMg, 3));
                x1=17:1:size(DMg, 3);
                y1 =interp1(x,y,x1,'spline');
                n = cat(2,n(1:17),y1(2:length(y1)));
               x=1:23;
                E = nanstd(n) *ones(size(x));
                figure,errorbar(x,n,E,'o'),title(' Mean extension\time'),axis([1 23 min(n) max(n)])
            xlabel('t')
            ylabel('ksl')
            
%         elseif var == 37
        elseif var == 37

%             v=zeros(1,23);
%             for i=1:23
%                 v(i)= DMg(cell,170,i);
%             end
%             for j=1:length(v)
%                 if v(j)==0
%                     v(j)=NaN;
%                 end;
%             end;
%             if cell<14
%                 x=17:2:23;
%                 y=v(17:2:23);
%                 x1=17:1:23;
%                 y1 =interp1(x,y,x1,'spline');
%                 v=cat(2,v(1:17),y1(2:length(y1)));
%             else
%                 if  ~isnan(v(17))
%                     x=15:2:17;
%                     y=v(15:2:17);
%                     x1=15:1:17;
%                     y1 =interp1(x,y,x1,'spline');
%                     v(15:17)=y1;
%                 end
%             end
%                 figure,plot(1:23,v,'-o'),axis([1 23 0 max(v)])
%                 title(['Andamento dell''estensione radiale nel tempo  Cellula',num2str(cell)])
%                 xlabel('t')
%                 ylabel('Estensione')
%                 saveas(gcf,sprintf('Estensionet_%s.bmp',cellula),'bmp')

             v=zeros(size(DMg, 1), size(DMg, 3));
             
            for j = 1:size(DMg, 1)
                
            for i = 1:size(DMg, 3)
                
                v(j, i) = DMg(j, 170, i);
                
                if v(j, i) == 0;
                    
                    v(j,i) = NaN;
                    
                end;
                
            end;
            
            end;
            
            n = nanmean(v);
                 x = 17:size(DMg, 3);
                  y = n(17:size(DMg, 3));
                x1 = 17:1:size(DMg, 3);
                y1 = interp1(x,y,x1,'spline');
                n = cat(2,n(1:17),y1(2:length(y1)));
               x = 1:size(DMg, 3);
           figure,errorbar(x,n,E,'o'),title('Mean Extension\time'),axis([1 23 min(n) max(n)])
            xlabel('t')
            ylabel('ksl')
            
            cd(pathname2)
            saveas(gcf,sprintf('ksl2t_%s.bmp',cellula,'bmp'))
            cd(olddir)
            
%         elseif var == 38
        elseif var == 28

            v = zeros(1, size(DMg, 3));
            
            for i = 1:size(DMg, 3)
                
                v(i) = DMg(cell, 171, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
%             if cell<14  %????
%                 
%                 x=17:2:size(DMg, 3);
%                 y=v(17:2:size(DMg, 3));
%                 x1=17:1:size(DMg, 3);
%                 y1 =interp1(x,y,x1,'spline');
%                 v=cat(2, v(1:17), y1(2:length(y1)));
%                 
%             else
%                 
%                 if  ~isnan(v(17))   %???
%                     
%                     x=15:2:17;
%                     y=v(15:2:17);
%                     x1=15:1:17;
%                     y1 =interp1(x,y,x1,'spline');
%                     v(15:17)=y1;
%                     
%                 end;
                
%             end;
%             v
                figure,plot(1:size(DMg, 3),v,'-o'),axis([1 size(DMg, 3) 0 max(v)])
                title(['Soma Area \ time  Cell',num2str(cell)])
                xlabel('t')
                ylabel('Area Soma')
                
                cd(pathname2)
                saveas(gcf,sprintf('AreaSomat_%s.bmp',cellula),'bmp')
                cd(olddir)
             
%         elseif var == 39
        elseif var == 29

            v = zeros(1, size(DMg, 3));
            
            for i = 1: size(DMg, 3)
                
                v(i) = DMg(cell, 172, i);
                
            end;
            
            for j = 1:length(v)
                
                if v(j) == 0
                    
                    v(j) = NaN;
                    
                end;
                
            end;
            
%             if cell<14
%                 
%                 x=17:2:size(DMg, 3);
%                 y=v(17:2:size(DMg, 3));
%                 x1=17:1:size(DMg, 3);
%                 y1 =interp1(x,y,x1,'spline');
%                 v=cat(2,v(1:17), y1(2:length(y1)));
%                 
%             else
%                 if  ~isnan(v(17))
%                     
%                     x=15:2:17;
%                     y = v(15:2:17);
%                     x1 = 15:1:17;
%                     y1 = interp1(x, y, x1, 'spline');
%                     v(15:17) = y1;
%                     
%                 end;
%                 
%             end;
            
                figure,plot(1:size(DMg, 3), v, '-o'),axis([1 size(DMg, 3) 0 max(v)])
                title(['Cone Angle\time  Cell',num2str(cell)])
                xlabel('t')
                ylabel('Cone Angle')
                
                cd(pathname2)
                saveas(gcf,sprintf('ConeAnglet_%s.bmp',cellula),'bmp')
                cd(olddir)

%         elseif var == 41
        elseif var == 31

%             v=zeros(1,23);
%             for i=1:23
%                 v(i)= DMg(cell,173,i);
%             end
%             for j=1:length(v)
%                 if v(j)==0
%                     v(j)=NaN;
%                 end;
%             end;
%             if cell<14
%                 x=17:2:23;
%                 y=v(17:2:23);
%                 x1=17:1:23;
%                 y1 =interp1(x,y,x1,'spline');
%                 v=cat(2,v(1:17),y1(2:length(y1)));
%             else
%                 if  ~isnan(v(17))
%                     x=15:2:17;
%                     y=v(15:2:17);
%                     x1=15:1:17;
%                     y1 =interp1(x,y,x1,'spline');
%                     v(15:17)=y1;
%                 end
%             end
%                 figure,plot(1:23,v,'-o'),axis([1 23 0 max(v)])
%                 title(['Andamento della dimansione frattale nel tempo  Cellula',num2str(cell)])
%                 xlabel('t')
%                 ylabel('Dimensione frattale')
%                 saveas(gcf,sprintf('Dimensionefrattalet_%s.bmp',cellula),'bmp')
             v=zeros(size(DMg, 1), size(DMg, 3));
             
            for j = 1:size(DMg, 1)
                
            for i = 1:size(DMg, 3)
                
                v(j,i) = DMg(j, 173, i);
                
                if v(j,i) == 0;
                    
                    v(j,i)= NaN;
                    
                end;
                
            end;
            
            end;
            
            n=nanmean(v);   %???
                 x=17:23;
                  y=n(17:23);
                x1=17:1:23;
                y1 =interp1(x,y,x1,'spline');
                n=cat(2,n(1:17),y1(2:length(y1)));
               x=1:23;
                E = nanstd(n) *ones(size(x));
%             x
%             n
%             E
           figure,plot(x,n,'-o'),title(' Fractal Dimension on time'),axis([1 23 1.5 2.5])
            xlabel('t')
            ylabel('Df')
            
            cd(pathname2)
            saveas(gcf,sprintf('Dft_%s.bmp',cellula,'bmp'))
            cd(olddir)
            
        end;
        
        reply= questdlg('Do you want to see the variable for an other cell Y/N:', 's');
        
    end;
    
end;

%%nanmean da rivedere.



