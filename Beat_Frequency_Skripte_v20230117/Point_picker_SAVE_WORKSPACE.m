

    zp_est_02=zp_est_0;
    zp_est_02(isnan(zp_est_02))=0; %Set all NaN to zeros for the .csv file so QGIS can read the data
    deltalambda_2 = (9.5 * 10^-7)* zp_est_02;

    %save new Data in "_neu_ptf.mat"

    dateiname = strcat(Ordner4, abbildung_vorname,swchr,'_pft_qc_','.mat');
    save(dateiname,'z*','sw','prof');
 

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
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    ax.YAxis(1).Direction = 'normal';%
    hold off;
 
    f2=figure (2);
    f2.Position = [270 550 1295 400]; 
    imagesc(zDatasub_2); colormap(flipud(gray));    

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
    
   %Sheet with four images
    f4=figure(501); 
    figurename501 = strcat(Ordner2,abbildung_vorname,swchr,'_f501_','.png');
    set(f4, 'Units', 'normalized', 'Position', [0.2, 0.1, 0.4, 0.75]);
    b1= subplot(4,20,[1:17]);
    imagesc(zDatadB); colormap(b1,(flipud(gray))); 
    xlabel('Trace');
    ylabel('Sample');
    
    op=colorbar;
    ylabel(op,'Power (dB)');  
    
    b2= subplot(4,20,[21:37]);
    imagesc((zDatasub_2)); colormap(b2,(flipud(gray)));
    xlabel('Trace');
    ylabel('Sample'); 
    pp=colorbar;
    ylabel(pp,'Power (dB)');  

    b3= subplot(4,20,[41:58]);
    imagesc(zt,zf,zp );    
    ylim([0 7.5]);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)'); 
    hfig = gcf;  
    hfig.CurrentAxes.CLim = [1 10];  % power scale
    axis tight;
    colorbar;
    qp=colorbar;
    ylabel(qp,'Power spectral density (a.u.)');  

    
    hold on;     
    plot(zt,zp_est_0_alt,'r','LineWidth',2)
    yyaxis right; 
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    ax.YAxis(1).Direction = 'normal';%
    hold off;
    
    
    
    b4= subplot(4,20,[61:78]);
    imagesc(zt,zf,zp);
    ylim([0 7.5]);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');     
    hfig = gcf;
    hfig.CurrentAxes.CLim = [1 10];  % power scale
    axis tight;
    colorbar;

    hold on;     
    plot(zt,zp_est_0,'r','LineWidth',2)
    yyaxis right; 
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    ax.YAxis(1).Direction = 'normal';%
    hold off;
    
    %save Sheet whith images

    print(f4,figurename501,'-dpng','-r300');

    %save .csv File

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

    csvfile = [zlatq.' zlonq.' deltalambda_2.'];
    dlmwrite(csvfilename, csvfile, '-append');
 
   

    








