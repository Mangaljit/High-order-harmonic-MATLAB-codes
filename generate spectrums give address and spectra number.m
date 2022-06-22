% clear all
% close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Please give following inputs
strip=10; %strip length for background elimination
% samples=12; % no. of data sample for polynomial fitting
% poly_order=4; %order for polynomial fitting
no_of_images=16;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folder=fullfile('E:\PhD data\Experimetal Data\Beamtime Feb 2019 100 Hz\chromium tunable SHG feb2019\chromium832nm feb2019');
cd(folder);
ref_img=fitsread('chromium7_0001.fts'); 
figure
imshow(ref_img, [100 200]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
%figure
%imshow(cr_img_1st, [100 115]);
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %reading xaxis from excel file
% path='E:\PhD Folder\Data Analysis\Beamtime May 2018 OPA 100 Hz\indium_Beamtime May 2018 OPA 100 Hz\x-axis_generation_indium\x-axis_generation_indium5_0001_indium3_870nm_SHG.xlsx';
% xaxis=xlsread(path);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pixel to orders conversion
% area((sum(cr_img_1st)-min(sum(cr_img_1st)))./max(sum(cr_img_1st)-min(sum(cr_img_1st))));
% figure
% imshow(cr_img_1st, [100 500]);
% [X_val, Y_val]=ginput(samples);
% close();
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for i=1:no_of_images
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('chromium7',name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    avr_img_1st=avr_img_1st+double(image2);
    avr_img_1st;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Background
    strip_length=strip;
    [row1,col1]=size(avr_img_1st);
    bkg=(avr_img_1st(1:strip_length,:)+avr_img_1st(row1-(strip_length-1):row1,:));
    bkg_num=sum(sum(bkg))/(2*col1*strip_length); %what is the logic behind this background calculation??
%img_plot_1st=double(sum(avr_img_1st-bkg_num));
img_plot_1st=double(sum(avr_img_1st));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%Pixel to wavelength
% figure(); 
% area(abs(img_plot_1st)); 
% [X_val, Y_val]=ginput(samples);
% close(); 
% harmonics=(9:1:8+length(X_val)); 
% %harmonics=(9:2:14+length(X_val)); 
% P=polyfit(transpose(X_val), harmonics, poly_order); % does polynomial fitting of order .
% X_axis_1st=polyval(P, 1:length(img_plot_1st)); %gives us wavelength values across the whole x axis of cropped image by polynomial evaluation
% X_axis_1st=(1240/860).*X_axis_1st;
figure
img_plot_1st=sum(avr_img_1st); %creates a row vector by summing the matrix.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norm_y=(img_plot_1st-1.7e+6)./1.9e+6;
plot(unnamed,norm_y,'LineWidth',4); %multiplied by two to mke it  20 shot spectra
% set(gca, 'YScale', 'log')

% plot(X_axis_1st./.8552,(img_plot_1st-min(img_plot_1st))./max(img_plot_1st-min(img_plot_1st)),'LineWidth',3)
axis tight
xlim([11 55])
grid on
%ylim([.0011 1.1])
set(gca,'FontSize',20,'FontWeight','bold');
xlabel('Energy (in eV)','FontSize', 24,'FontWeight','bold');
ylabel('Normalized Intensity ','FontSize',14,'FontWeight','bold');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,col]=size(avr_img_1st);
Y=(((row:-1:1)./row))*1.5;
% Y=linspace(0,52.7,row_1st)-13.57;
% Y=linspace(0,52.7,row_1st)-16;
figure
% surf(unnamed,fliplr(Y),(avr_img_1st-bkg_num)./2500);
surf(unnamed,fliplr(Y),(avr_img_1st-bkg_num)./2500);
view(0,90);
shading interp
axis tight
caxis ([0 0.2]);
% xlim([12.33 40]);
ylim ([-7 7.5]);
xlabel('Energy (eV)','FontSize', 16);
ylabel('Divergence (mrad)','FontSize', 16);
colorbar
set(gcf,'color','w');
set(gca,'FontSize',16)












