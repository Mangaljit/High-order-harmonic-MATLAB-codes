clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Please give following inputs
strip=10; %strip length for background elimination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
folder=fullfile('D:\PhD Folder\HHG Code\ellipticity HHG code\Sample');
cd(folder);
ref_img=fitsread('spectrum1_0001.fts'); 
imshow(ref_img, [110 115]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

angle_hwp=[2,5,8,15,18,22];
angle_qwp=2.*angle_hwp;

for j=1:length(angle_qwp)
avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for i=1:10
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
    img_plot_series_1st(j,:)=sum(img_plot_1st);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ellipticity=tand(angle_qwp);
plot(ellipticity,img_plot_series_1st./(img_plot_series_1st),'-*','linewidth',3);
ylim([0 1.2])
ylabel('Normalized Harmonic Intensity','Fontsize',16)
xlabel('Ellipticity','Fontsize',16)
set(gca,'Fontsize',16)
grid on