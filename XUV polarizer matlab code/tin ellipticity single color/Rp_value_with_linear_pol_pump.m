clc
clear all

% two spectrums, one with s-pol and other with p-pol is uploaded.
% crop the harmonic of interest(top-bottom) and then again crop with taking
% two samples. This is done with both s-pol as well as with p-pol. Make
% sure you crop precisely from top to bottom. Left-righ cropping is done by
% choosing the two samples again (with ginput having two samples). Then the intensity of two
% p-pol and s-pol harmonic is divided to give the ratio.


%Please give following inputs
no_of_images=1;
samples=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Spectrum for s-polarization
folder=fullfile('C:\Users\Mangaljit Singh\Desktop\indium5_2aug2017');
cd(folder);
ref_img=fitsread('spectrums_0001.fts'); 
%figure
imshow(ref_img, [100 170]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
% figure(1)
% imshow(cr_img_1st, [100 115]);
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for i=1:no_of_images
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('spectrums',name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    avr_img_1st=avr_img_1st+double(image2);
    avr_img_1st;
end
img_plot_1st=double(sum(avr_img_1st));
% dd=linspace(1,10,col_1st);
plot(img_plot_1st,'LineWidth',4)
axis tight
set(gca,'FontSize',20,'FontWeight','bold');
xlabel('pixel number','FontSize', 24,'FontWeight','bold');
ylabel('Intensity','FontSize', 24,'FontWeight','bold');
[xval, yval]=ginput(samples);
close();
h1s=sum(img_plot_1st(xval(1):xval(2)));
% h2s=sum(img_plot_1st(xval(3):xval(4)));
% h3s=sum(img_plot_1st(xval(5):xval(6)));
% h4s=sum(img_plot_1st(xval(7):xval(8)));
% array_spol=[h1s h2s h3s h4s];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Spectrum for p-polarization
folder=fullfile('C:\Users\Mangaljit Singh\Desktop\indium5_2aug2017');
cd(folder);
ref_img=fitsread('spectrump_0001.fts'); 
imshow(ref_img, [100 170]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
% figure(1)
% imshow(cr_img_1st, [100 115]);
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for i=1:no_of_images
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('spectrump',name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    avr_img_1st=avr_img_1st+double(image2);
    avr_img_1st;
end
img_plot_1st=double(sum(avr_img_1st));
plot(img_plot_1st,'LineWidth',4)
axis tight
set(gca,'FontSize',20,'FontWeight','bold');
xlabel('pixel number','FontSize', 24,'FontWeight','bold');
ylabel('Intensity','FontSize', 24,'FontWeight','bold');
[xval, yval]=ginput(samples);
close();
h1p=sum(img_plot_1st(xval(1):xval(2)));
% h2p=sum(img_plot_1st(xval(3):xval(4)));
% h3p=sum(img_plot_1st(xval(5):xval(6)));
% h4p=sum(img_plot_1st(xval(7):xval(8)));
% array_ppol=[h1p h2p h3p h4p];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% array_Rp=array_ppol./array_spol %this aray gives the value of Rp for individual harmonic
Rp_divided_Rs=h1p./h1s %this aray gives the value of Rp for individual harmonic


