
close all

%Folder for reading data and write results

Ordner ='/Users/fvalero/Documents/MATLAB/ergebnisse/pft/'; %Folder where the "pft.mat" files are located
Ordner2 ='/Users/fvalero/Documents/MATLAB/ergebnisse/neu_pft/'; %Folder to save the data or "neu_pft.mat" file
Ordner3 ='/Users/fvalero/Documents/MATLAB/ergebnisse/csv/'; %Folder to save the data or ".csv" file
Ordner4 ='/Users/fvalero/Documents/MATLAB/ergebnisse/pft_png/'; %Folder to save the images

dinfo = dir(strcat(Ordner,'*.mat'));% Folder where the "pft.mat" files are located

Data_all=[];


sw1 = inputdlg("Schwellwert (3, 5, 8)"); %Power scale threshold
sw = str2num(sw1{1});

prof= inputdlg("Profi:Longitudinal(_L_), Diagonal(_D_), Quer(_Q_)");%Longitudinal (L), Diagonal (D), Quer (Q) Profil
prof = char(prof);


for K = 1 : length(dinfo)
  thisfilename = dinfo(K).name;  % Dateinamen der Ordner
  abbildung_vorname =  [thisfilename(1:end-7)];
  
  % Load the data
  load(strcat(Ordner, thisfilename));

  
  % New variables for the filename
  tab='_';
  dat = datetime('now','Format','yyMMdd'); %Date
  dat = char(dat); %Date zu str
  swchr = strcat(dat,tab,prof,tab,int2str(sw)); 

  % calculation the average of the maximum and minimum frequency

  zp_freq=zp;
  zf_max_freq=[];
  zf_min_freq=[];
  

  
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
    zf_est(find(zf_est==0)) = NaN;   

    %delta lambda calculation
    deltalambda = (9.5 * 10^-7 )* zf_est;
    
 
   
    %plots of the calculation

    f1=figure(501); 
    figurename501 = strcat(Ordner4,abbildung_vorname,swchr,'_f501_','.png');
    set(f1, 'Units', 'normalized', 'Position', [0.2, 0.1, 0.4, 0.75]);
    b1= subplot(4,20,[1:17]);
    imagesc(zDatadB); colormap(b1,(flipud(gray))); 
    op=colorbar;
    ylabel(op,'Power (dB)');  
 
    b2= subplot(4,20,[21:37]);
    imagesc((zDatasub_2)); colormap(b2,(flipud(gray)));
    pp=colorbar;
    ylabel(pp,'Power (dB)');  
  
    b3= subplot(4,20,[41:58]);
    mesh(zt,zf,zp);
    view(0,90);
    ylim([0 7.5]);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');     
    hfig = gcf;
    hfig.CurrentAxes.CLim = [1 10];  % power scale
    axis tight;
    colorbar;

    hold on;     
    plot3(zt,zf_est,repmat(50,255,1),'r','LineWidth',2)
    yyaxis right; 
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    hold off;
    
    b4= subplot(4,20,[61:78]);
    mesh(zt,zf,zp_freq );    
    view(0,90);
    ylim([0 7.5]);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)'); 
    hfig = gcf;  
    hfig.CurrentAxes.CLim = [1 10];  % power scale
    axis tight;
    colorbar;
    
    hold on;     
    plot3(zt,zf_est,repmat(50,255,1),'r','LineWidth',2)
    yyaxis right; 
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    hold off;


    %save figure
    print(f1,figurename501,'-dpng','-r300');

    
    %Set all NaN to zeros for the .csv file so QGIS can read the data
    deltalambda(isnan(deltalambda))=0;
    
    
    %save .csv file
    csvfilename=strcat(Ordner3, abbildung_vorname,swchr,'.csv');
    cHeader = {'Lat' 'Lon' 'Anisotropie'}; %dummy header
    commaHeader = [cHeader;repmat({','},1,numel(cHeader))]; %insert commaas
    commaHeader = commaHeader(:)';
    textHeader = cell2mat(commaHeader); %cHeader in text with commas

    %%write header to file
    fid = fopen(csvfilename,'w'); 
    fprintf(fid,'%s\n',textHeader)
    fclose(fid)

    %write data to end of file
    csvfile = [zlatq.' zlonq.' deltalambda.'];
    dlmwrite(csvfilename, csvfile, '-append');
    thisfilename_pft = strcat(abbildung_vorname,swchr,'_pft_qc_.mat');
    save([Ordner2,thisfilename_pft],'z*','sw','prof');

    

end
    
    %csvfilename2=strcat(Ordner3,'201805_all_sw_',swchr,'.csv');
    %fid2 = fopen(csvfilename2,'w'); 
    %fprintf(fid2,'%s\n',textHeader)
    %fclose(fid2)
    %csvfile = [zlatq_all.' zlonq_all.' deltalambda_all.'];
    %dlmwrite(csvfilename2, csvfile, '-append');
