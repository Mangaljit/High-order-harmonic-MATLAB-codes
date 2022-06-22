clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Please give following inputs
strip=10; %strip length for background elimination
samples=10; % no. of data sample for polynomial fitting
poly_order=6; %order for polynomial fitting
no_of_delays=40; % no. of delay points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
folder=fullfile('D:\PhD data\Experimetal Data\Beamtime 10 Hz July2017\tin20_21jul2017');
cd(folder);
ref_img=fitsread('tinspectrum1_0001.fts'); 
imshow(ref_img, [110 115]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
figure
imshow(cr_img_1st, [100 115]);
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image
close();


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pixel to orders conversion
figure(); 
area((sum(cr_img_1st)-min(sum(cr_img_1st)))./max(sum(cr_img_1st)-min(sum(cr_img_1st))));
[X_val, Y_val]=ginput(samples);
close();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




for j=1:no_of_delays;
avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image

for i=1:2
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('tinspectrum',num2str(j),name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    avr_img_1st=avr_img_1st+double(image2);
end

%Background
    strip_length=strip;
    [row1,col1]=size(avr_img_1st);
    bkg=(avr_img_1st(1:strip_length,:)+avr_img_1st(row1-(strip_length-1):row1,:));
    bkg_num=sum(sum(bkg))/(2*col1*strip_length);
    img_plot_1st=double(sum(avr_img_1st-bkg_num));
    img_plot_series_1st(j,:)=img_plot_1st;
end


for j=1:no_of_delays
    data(j,:)=img_plot_series_1st(j,:);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


delay=linspace(0,4,no_of_delays); %delay defined


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %Pixel to orders conversion
% figure(); 
% area((sum(cr_img_1st)-min(sum(cr_img_1st)))./max(sum(cr_img_1st)-min(sum(cr_img_1st))));
% [X_val, Y_val]=ginput(samples);
% close(); 
harmonics=(8:1:7+length(X_val)); 
P=polyfit(transpose(X_val), harmonics, poly_order); % does polynomial fitting of order 2.
X_axis_1st=polyval(P, 1:length(img_plot_1st)); %gives us wavelength values across the whole x axis of cropped image by polynomial evaluation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% [X,Y]=meshgrid(delay,X_axis_1st);
figure
surf(delay,fliplr(X_axis_1st),flipud(data'./max(max(data))));
view(0,90)
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(X_axis_1st) max(X_axis_1st)])
ylabel('Harmonic Order','FontSize', 24)
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BB=flipud(data'./max(max(data)));
figure;
imagesc(BB); axis square
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Harmonic Number=8
firstpoint=2084;
lastpoint=2339;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=8','FontSize', 24)
caxis([0.02 0.09])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Harmonic Number=9
firstpoint=1835;
lastpoint=2084;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=9','FontSize', 24)
caxis([0.005 0.12])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Harmonic Number=10

firstpoint=1647;
lastpoint=1835;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=10','FontSize', 24)
caxis([0.02 0.24])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmoni c)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Harmonic Number=11
firstpoint=1496;
lastpoint=1647;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=11','FontSize', 24)
caxis([0.1 0.32])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp

% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Harmonic Number=12
firstpoint=1351;
lastpoint=1496;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=12','FontSize', 24)
caxis([0.02 0.08])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Harmonic Number=13
firstpoint=1226;
lastpoint=1351;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=13','FontSize', 24)
caxis([0.06 0.5])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp

%%%%%%%%%%%%%%%%%%%%%%%%%%

%Harmonic Number=14
firstpoint=1127;
lastpoint=1226;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=14','FontSize', 24)
caxis([0.06 0.5])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Harmonic Number=15
firstpoint=1044;
lastpoint=1127;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=15','FontSize', 24)
caxis([0.06 0.5])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Harmonic Number=16
firstpoint=966;
lastpoint=1044;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=16','FontSize', 24)
caxis([0.06 0.5])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Harmonic Number=17
firstpoint=810;
lastpoint=966;
BBB=BB(firstpoint:lastpoint,1:no_of_delays);
[a,b]=size(BBB);
xaxis=1:1:a;
figure
surf(delay,xaxis,BBB);
view(0,90)
title('Harmonic Order=17','FontSize', 24)
caxis([0.06 0.5])
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(xaxis) max(xaxis)])
xlabel('delay (cycles of second harmonic)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
shading interp








%%%%%%%%%%%%%

norm=max(sum(BB(1271:1410,1:no_of_delays)));
figure
plot(delay, sum(BB(1271:1410,1:no_of_delays))./norm,'-*','Linewidth',2)
xlabel('delay (cycles of second harmonic)','FontSize', 24)
ylabel('13H Amplitude (au)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
grid on
xlswrite('13H delay variation',sum(BB(1271:1410,1:no_of_delays)));


% 
% 
figure
plot(delay, sum(BB(1411:1550,1:no_of_delays))./norm,'-*','Linewidth',2)
xlabel('delay (cycles of second harmonic)','FontSize', 24)
ylabel('12H Amplitude (au)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
grid on
%%%%%%%
%%%%%%%%%%
figure
plot(delay, sum(BB(1411:1550,1:no_of_delays))./norm,'-*',delay, sum(BB(1271:1410,1:no_of_delays))./norm,'-*','Linewidth',2)
xlabel('delay (cycles of second harmonic)','FontSize', 24)
ylabel('Normalized Intensity','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');
grid on
legend('12H','13H')








