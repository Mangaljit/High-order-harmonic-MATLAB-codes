clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folder=fullfile('C:\Users\Mangaljit Singh\Desktop\Delay HHG code\graphite2');
cd(folder);
ref_img=fitsread('spectrum7_0001.fts'); 
imshow(ref_img, [0 500]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
% figure
% imshow(cr_img_1st, [0 1000]);
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for j=1:10
avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image

for i=1:2
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('spectrum',num2str(j),name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    avr_img_1st=avr_img_1st+double(image2);
end

%Background
    strip_length=10;
    [row1,col1]=size(avr_img_1st);
    bkg=(avr_img_1st(1:strip_length,:)+avr_img_1st(row1-(strip_length-1):row1,:));
    bkg_num=sum(sum(bkg))/(2*col1*strip_length);
    img_plot_1st=double(sum(avr_img_1st-bkg_num));
    img_plot_series_1st(j,:)=img_plot_1st;
end

data=[img_plot_series_1st(1,:);img_plot_series_1st(2,:);img_plot_series_1st(3,:);img_plot_series_1st(4,:)
    ;img_plot_series_1st(5,:);img_plot_series_1st(6,:);img_plot_series_1st(7,:);img_plot_series_1st(8,:);
    img_plot_series_1st(9,:);img_plot_series_1st(10,:)];

delay=linspace(0,5,j); %delay defined

%Pixel to orders
figure(); 
area(abs(img_plot_1st)); 
[X_val, Y_val]=ginput(6);
close(); 
harmonics=(17:2:15+2*length(X_val)); 
P=polyfit(transpose(X_val), harmonics, 2); % does polynomial fitting of order 2.
X_axis_1st=polyval(P, 1:length(img_plot_1st)); %gives us wavelength values across the whole x axis of cropped image by polynomial evaluation


% set(gcf,'renderer','opengl');
% figure
% imagesc(x,X_axis_1st,(img_plot_series_1st')./(max(max(img_plot_series_1st))))
[X,Y]=meshgrid(delay,X_axis_1st);
figure
area(X_axis_1st,abs(img_plot_1st./max(img_plot_1st)));
figure
mesh(delay,fliplr(X_axis_1st),flipud(data'./max(max(data))));
view(0,90)
axis square
colormap jet
colorbar
xlim([0 max(delay)])
ylim([min(X_axis_1st) max(X_axis_1st)])
ylabel('Harmonic Order','FontSize', 24)
xlabel('delay (cycles)','FontSize', 24)
set(gca,'FontSize',15,'FontWeight','bold');

% area(X_axis_1st,abs(img_plot_1st)./max(abs(img_plot_1st)))
% imagesc(X_axis_1st,1,abs(img_plot_1st)./max(abs(img_plot_1st)));