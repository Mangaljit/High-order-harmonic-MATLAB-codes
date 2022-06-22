clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Please give the following inputs
strip=10; %strip length for background elimination
samples=8; %2 samples per harmonic selection
tau= 50e-15; %pulse duration
no_avg_images=10; %
mpo= 1e-3; %pulse energy in joule
f=50e-2; % focal length of focussing mirror in m
lambda=800e-9;
D=10e-3; % beam size in m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
omega=(2.*lambda.*f)./(pi.*D);
angle_hwp=[0,5,15 ,25 ,35,45]; %Angle by which you are rotating the HWP
angle_pol=2.*angle_hwp; %rotatoin angle for the polarization is doubled
intensity= (((mpo./(pi.*omega.^2)))./(tau)).*((cosd(angle_pol)).^2);
intensity=intensity.*1e-4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folder=fullfile('D:\PhD Folder\HHG Code\ellipticity HHG code\Sample');
cd(folder);
ref_img=fitsread('spectrum1_0001.fts'); 
imshow(ref_img, [110 115]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:length(angle_hwp);
avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for i=1:no_avg_images;
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('spectrum',num2str(j),name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
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

area(abs(img_plot_series_1st(1,:))./max(abs(img_plot_series_1st(1,:))));
[xval, yval]=ginput(samples);
close();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:length(angle_pol);
      h1(j,:)=sum(img_plot_series_1st(j,xval(1):xval(2)));
end
for j=1:length(angle_pol);
      h2(j,:)=sum(img_plot_series_1st(j,xval(3):xval(4)));
end
for j=1:length(angle_pol);
      h3(j,:)=sum(img_plot_series_1st(j,xval(5):xval(6)));
end
for j=1:length(angle_pol);
      h4(j,:)=sum(img_plot_series_1st(j,xval(7):xval(8)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(intensity./(10e14),h1./max(h1),intensity./(10e14),h2./max(h2)-0.05,intensity./(10e14),h3./max(h3)-0.1,intensity./(10e14),h4./max(h4)-0.15,'Linewidth',3);
ylim([0 1.1])
ylabel('Normalized Harmonic Intensity','Fontsize',16)
xlabel('Intensity (W/cm^{2}, in the units of 10^{14}) ','Fontsize',16)
set(gca,'Fontsize',16) 
grid on
legend('1H','2H','3H','4H')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%