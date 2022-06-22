clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Please give the following inputs
strip=10; %strip length for background elimination
samples=8; %2 samples per harmonic selection
no_avg_images=10; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

angle_hwp=[0,2,4,6,8,10 12 14, 16 18,20,22.5]; %Angle by which you are rotating the HWP
angle_qwp=2.*angle_hwp; %rotatoin angle for the polarization is doubled
ellipticity=tand(angle_qwp); %ellpticity introduced  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folder=fullfile('C:\Users\Mangaljit Singh\Desktop\tin7_18jul2017');
cd(folder);
ref_img=fitsread('tinspectrum2_0001.fts'); 
imshow(ref_img, [110 115]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:length(angle_hwp);
avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for i=1:no_avg_images;
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
    img_plot_series_1st(j,:)=(img_plot_1st);
end
area(abs(img_plot_series_1st(2,:))./max(abs(img_plot_series_1st(10,:))));
[xval, yval]=ginput(samples);
close();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:length(angle_qwp);
      h1(j,:)=sum(img_plot_series_1st(j,xval(1):xval(2)));
end
for j=1:length(angle_qwp);
      h2(j,:)=sum(img_plot_series_1st(j,xval(3):xval(4)));
end
for j=1:length(angle_qwp);
      h3(j,:)=sum(img_plot_series_1st(j,xval(5):xval(6)));
end
for j=1:length(angle_qwp);
      h4(j,:)=sum(img_plot_series_1st(j,xval(7):xval(8)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax1=subplot(2,2,1);
plot(ax1,ellipticity,h1./max(h1),'*-','Linewidth',2);
set(gca,'Fontsize',16)
xlim([0 1])
ylim([0 1.2])
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax2=subplot(2,2,2);
plot(ax2,ellipticity,h2./max(h2),'*-','Linewidth',2);
ylabel('Normalized 2H Intensity','Fontsize',16)
xlabel('Ellipticity','Fontsize',16)
set(gca,'Fontsize',16)
xlim([0 1])
ylim([0 1.2])
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax3=subplot(2,2,3);
plot(ax3,ellipticity,h3./max(h3),'*-','Linewidth',2);
ylabel('Normalized 3H Intensity','Fontsize',16)
xlabel('Ellipticity','Fontsize',16)
set(gca,'Fontsize',16)
xlim([0 1])
ylim([0 1.2])
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax4=subplot(2,2,4);
plot(ax4,ellipticity,h4./max(h4),'*-','Linewidth',2);
ylabel('Normalized 4H Intensity','Fontsize',16)
xlabel('Ellipticity','Fontsize',16)
set(gca,'Fontsize',16) 
ylim([0 1.2])
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%