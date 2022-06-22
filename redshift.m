% This code is written to calculate the red shift at 4different wavelengths
             

close all
clc

% Redshift in graphtie at 1450nm wavelength (1st Wavelength)
folder=fullfile('C:\Users\mangaliitd\Desktop\New folder (2)');
cd(folder);

ref_img=imread('spectrum1_0001.fts'); 
imshow(ref_img, [110 700]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle
close();

[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image
avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image



for i=1:6
avr_img_1st=zeros(row_1st,col_1st);
    
    name=sprintf('_%3.4d', i); %makes 0001, 0002, 0003.....
    joiname=cat(2,strcat('spectrum1',name,'.fts'));
    image=imread(joiname);
    image2=imcrop(image, im_axis_1st);
    avr_img_1st=avr_img_1st+double(image2);

        %Background
    strip_length=10;
    [row1,col1]=size(avr_img_1st);
    bkg=(avr_img_1st(1:strip_length,:)+avr_img_1st(row1-(strip_length-1):row1,:));
    bkg_num=sum(sum(bkg))/(2*col1*strip_length);
    img_plot_1st=double(sum(avr_img_1st-bkg_num));
    img_plot_series_1st(i,:)=img_plot_1st;
    
end
%%%%%%%%%%

figure

[a b]=size(cr_img_1st);
% xx=linspace(0,1,b);
plot(unnamed,img_plot_series_1st,'LineWidth',3);
axis tight
set(gca,'FontSize',20,'FontWeight','bold');
xlim([12.34 15.6]);
legend
grid on
xlabel('Wavelength (nm)','FontSize', 24,'FontWeight','bold');
ylabel('Intensity (a.u)','FontSize', 24,'FontWeight','bold');
saveas(gcf,'9H.png')
%%%%%%%%%%%%%

figure

[a b]=size(cr_img_1st);
% xx=linspace(0,1,b);
plot(unnamed,img_plot_series_1st,'LineWidth',3);
axis tight
set(gca,'FontSize',20,'FontWeight','bold');
xlim([15.6 18.66]);
legend
grid on
xlabel('Wavelength (nm)','FontSize', 24,'FontWeight','bold');
ylabel('Intensity (a.u)','FontSize', 24,'FontWeight','bold');
saveas(gcf,'11H.png')
%%%%%
figure

[a b]=size(cr_img_1st);
% xx=linspace(0,1,b);
plot(unnamed,img_plot_series_1st,'LineWidth',3);
axis tight
set(gca,'FontSize',20,'FontWeight','bold');
xlim([18.66 21.81]);
legend
grid on
xlabel('Wavelength (nm)','FontSize', 24,'FontWeight','bold');
ylabel('Intensity (a.u)','FontSize', 24,'FontWeight','bold');

saveas(gcf,'13H.png')
%%%%%%%
figure

[a b]=size(cr_img_1st);
% xx=linspace(0,1,b);
plot(unnamed,img_plot_series_1st,'LineWidth',3);
axis tight
set(gca,'FontSize',20,'FontWeight','bold');
xlim([21.81 24.91]);
legend
grid on
xlabel('Wavelength (nm)','FontSize', 24,'FontWeight','bold');
ylabel('Intensity (a.u)','FontSize', 24,'FontWeight','bold');
saveas(gcf,'15H.png')
%%%%%%%%%%%%%%%%%
figure

[a b]=size(cr_img_1st);
% xx=linspace(0,1,b);
plot(unnamed,img_plot_series_1st,'LineWidth',3);
axis tight
set(gca,'FontSize',20,'FontWeight','bold');
xlim([24.91 27.7]);
legend
grid on
xlabel('Wavelength (nm)','FontSize', 24,'FontWeight','bold');
ylabel('Intensity (a.u)','FontSize', 24,'FontWeight','bold');
% legend('1','2','3','4','5')
saveas(gcf,'17H.png')
