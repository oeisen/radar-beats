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

  % calculation the average of the maximum and minimum frequency

  zp_max = max(max(zp));
  
  zp_freq = zp;
  zf_max_freq = [];
  zf_min_freq = [];
  
  [nrows,ncols] = size(zp_freq);

    for c = 1:ncols
        for r = 1:nrows
            if zp_freq(r,c) < sw;
            zp_freq(r,c) = 0;      
            else
            zp_freq(r,c) = zp_freq(r,c);
            end           
            
        end
    end
    
    for i = 1:ncols
        if max(zp_freq(:,i))==0
            zf_max_freq(i)=0;
        else
            zf_max_freq(i) = zf(find(zp_freq(:,i)==max(zp_freq(:,i))));  
        end
    end
    
    for i = 1:ncols
        if max(zp_freq(:,i))==0
           zf_min_freq(i)=9999;
        else
           zp_freq((zp_freq(:,i)==0),i) = 9999;
           zf_min_freq(i) = zf(find(zp_freq(:,i)==min(zp_freq(:,i)))); 
        end        
    end
    

    zp_freq(find(zp_freq==9999)) = 0;  
    zf_min_freq(find(zf_min_freq==9999)) = 0;
    zf_est= (zf_max_freq+zf_min_freq)/2;
   
   
    %Set all zeros to NaN to plot the line with zp_est_0.
    zp_est_0=zf_est;
    zp_est_0(find(zp_est_0==0)) = NaN;
    
    %delta lambda calculation

    z_deltalambda = (9.5 * 10^-7 )* zf_est;  
 
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
    hfig.CurrentAxes.CLim = [1 10];
    axis tight;
    colorbar
    
    hold on;     

    plot(zt,zp_est_0,'r-o','LineWidth',2);
    linkdata ('on');
    yyaxis right; 
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
    hfig.CurrentAxes.CLim = [1 10];
    axis tight;
    colorbar
   
    hold on;     
    plot(zt,zp_est_0,'r','LineWidth',2);
    %linkdata ('on');
    yyaxis right; 
    %ylim([0.0476 0.357]);
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    ax.YAxis(1).Direction = 'normal';%
    hold off;

    
    zp_est_0_alt=zp_est_0; % saves the last drawn line
    
    

    
    


