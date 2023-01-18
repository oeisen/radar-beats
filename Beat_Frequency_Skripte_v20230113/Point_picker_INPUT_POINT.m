
% cache variables
x=[];
y=[];
xlay= [];
ylay= [];
index=[];

figure (f1);
figure (f2);
figure (f3);


zoom on;
pause() % zoom with your mouse and when the image is okay, press any key
zoom off; % to escape the zoom mode
hold on ;
[x,y] = ginput;
plot(x,y,'r-','LineWidth',2); 
xlay= [xlay;x];
ylay= [ylay;y];
%xlay{mm}=x;
%ylay{mm}=y;
zoom out;
hold off; 

% go to the original size of your image

  for k = 1:length(xlay)
    index(k) = find(xlay(k)<=zt,1);
  end

    zp_est_0(index)= ylay;

 close (f1);   
 close (f3); 

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
    
    f2=figure (2);
    f2.Position = [300 550 1295 400]; 
 
    imagesc(zDatasub_2); colormap(flipud(gray));

 
    f3=figure (3);
    f3.Position = [300 50 1380 500];
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
    ax.YAxis(1).Direction = 'normal';
    hold off;
    
    
    figure (f3);
    figure (f1);
    figure (f2);

