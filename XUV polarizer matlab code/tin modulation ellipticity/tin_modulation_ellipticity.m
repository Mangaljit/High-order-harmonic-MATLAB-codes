clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Please give the following inputs
samples=2; %2 samples per harmonic selection
no_avg_images=4; %
no_of_data_points=37;
% angle_hwp=[0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,45]; %Angle by which you are rotating the HWP
angle_hwp=linspace(0,10,no_of_data_points);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folder=fullfile('D:\PhD data\Experimetal Data\Beamtime 10 Hz Dec2017\tin6_14dec2017\tin6_1');
cd(folder);
ref_img=fitsread('tinspectrum7_0001.fts'); 
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
%     strip_length=strip;
%     [row1,col1]=size(avr_img_1st);
%     bkg=(avr_img_1st(1:strip_length,:)+avr_img_1st(row1-(strip_length-1):row1,:));
%     bkg_num=sum(sum(bkg))/(2*col1*strip_length);
%     img_plot_1st=double(sum(avr_img_1st-bkg_num));
    img_plot_1st=double(sum(avr_img_1st));
    img_plot_series_1st(j,:)=(img_plot_1st);
end

plot(abs(img_plot_series_1st(1,:))./max(abs(img_plot_series_1st(1,:))));
%set(gca, 'YScale', 'log')
[xval, yval]=ginput(samples);
close();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:length(angle_hwp);
      h1(j,:)=sum(img_plot_series_1st(j,xval(1):xval(2)));
end
% for j=1:length(angle_hwp);
%       h2(j,:)=sum(img_plot_series_1st(j,xval(3):xval(4)));
% end
% for j=1:length(angle_hwp);
%       h3(j,:)=sum(img_plot_series_1st(j,xval(5):xval(6)));
% end
% for j=1:length(angle_hwp);
%       h4(j,:)=sum(img_plot_series_1st(j,xval(7):xval(8)));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(angle_hwp,abs(h1./max(h1)),'o-',angle_hwp,abs(h2./max(h2)),angle_hwp,abs(h3./max(h3)),angle_hwp,abs(h4./max(h4)),'Linewidth',3);
% ylim([0 1.1])
%set(gca, 'YScale', 'log')
ylabel('Normalized Harmonic Intensity','Fontsize',16)
xlabel('HWP Angle (in degrees)','Fontsize',16)
set(gca,'Fontsize',16) 
%grid on
legend('1H','2H','3H','4H')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%