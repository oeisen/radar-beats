clear all
close all


Ordner2 ='/Users/fvalero/Documents/MATLAB/ergebnisse/pft_png/';%path für Bilder Daten zu speichern
Ordner3 ='/Users/fvalero/Documents/MATLAB/ergebnisse/csv/';%path für csv Daten zu speichern
Ordner4 ='/Users/fvalero/Documents/MATLAB/ergebnisse/neu_pft/';%path neue ptf Daten zu speichern



[file,path] = uigetfile('*.mat');
filename =file;
pat=path;
load(strcat(pat,filename));
abbildung_vorname =  [filename(1:end-22)]; 


  
  % New variables for the filename 

   tab='_';
   dat = datetime('now','Format','yyMMdd'); %Datum
   dat = char(dat); %Datum zu str
   swchr = strcat(dat,tab,prof,tab,int2str(sw));

    %cache variables
    xlay=[];
    ylay=[];
    
    %plots the figures for further processing

    f3=figure(3);
    f3.Position = [300 20 1380 500];

    imagesc(zt,zf,zp );
    ylim([0 7.5]);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)'); 
    hfig = gcf;  
    hfig.CurrentAxes.CLim = [0 10];
    axis tight; 
    colorbar

    hold on;

    plot(zt,zp_est_0,'r-o','LineWidth',2);
    linkdata ('on');
    yyaxis right; 
    %ylim([0.0476 0.357]);
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    ax.YAxis(1).Direction = 'normal';%

    hold off;
    
    
    hold on;   

    plot(xlay,ylay,'r-','LineWidth',2); 
    linkdata('on');
    yyaxis left;
    ylim([0 750000]);
    yyaxis right; 
    %ylim([0.0476 0.357]);
    ylim([0.095 0.7125]);

    hold off ;

    brush('on');
    
    
    f2=figure (2);
    f2.Position = [270 550 1295 400]; 
 
    imagesc(zDatasub_2); colormap(flipud(gray));
    
    f1=figure(1);
    f1.Position = [300 900 1380 200];

    imagesc(zt,zf,zp);
    ylim([0 7.5]);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)'); 
    hfig = gcf;  
    hfig.CurrentAxes.CLim = [0 10];
    axis tight;
    colorbar
   
    hold on;     
    plot(zt,zp_est_0,'r','LineWidth',2);
    %linkdata ('on');
    yyaxis right; 
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    ax.YAxis(1).Direction = 'normal';%
    hold off;

    
    zp_est_0_alt=zp_est_0; % saves the last drawn line
    
    

    
    


