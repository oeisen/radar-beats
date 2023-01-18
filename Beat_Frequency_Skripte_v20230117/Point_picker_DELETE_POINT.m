
    %cache variables
    x=[];
    y=[];
    xlay= [];
    ylay= [];
    index=[];

    %plots the figures for further processing

    figure (f2);
    figure (f3);

    %zoom image

    zoom on;
    pause() % zoom with your mouse and when the image is okay, press any key
    zoom off; % to escape the zoom mode
    hold on ;
    [x,y] = ginput;
    xlay= [xlay;x];
    ylay= [ylay;y];
    hold off; 
    zoom out; % go to the original size of your image

   % find the closest point and delete it by clicking with the mouse

    xleer=isempty(xlay)

    if xleer == 1

     else
    
   for k = 1:length(xlay)
    index(k) = find(xlay(k)<=zt,1);
   end

    ylay(1:length(xlay))=NaN;  
    zp_est_0(index)= ylay;
    
    end

    %plots the figures for further processing

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
    yyaxis right; 
    ylim([0.095 0.7125]);
    ylabel('horz. aniso. (\delta\lambda)','Color','k'); 
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';
    ax.YAxis(1).Direction = 'normal';%
    hold off;

    figure (f3);
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


