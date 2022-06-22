clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folder=fullfile('H:\feb 2016\indium');
cd(folder);
ref_img=fitsread('spectrum_0001.fts'); 
imshow(ref_img, [0 500]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
figure
imshow(cr_img_1st, [0 1000]);
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for i=1:10
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('spectrum',name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    avr_img_1st=avr_img_1st+double(image2);
    avr_img_1st;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Background
    strip_length=10;
    [row1,col1]=size(avr_img_1st);
    bkg=(avr_img_1st(1:strip_length,:)+avr_img_1st(row1-(strip_length-1):row1,:));
    bkg_num=sum(sum(bkg))/(2*col1*strip_length); %what is the logic behind this background calculation
    img_plot_1st=double(sum(avr_img_1st-bkg_num));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%Pixel to wavelength
figure(); 
area(abs(img_plot_1st)); 
[X_val, Y_val]=ginput(2);
close(); 
harmonics=800./(13:2:11+2*length(X_val)); 
P=polyfit(transpose(X_val), harmonics, 1); % does polynomial fitting of order 2.
X_axis_1st=polyval(P, 1:length(img_plot_1st)); %gives us wavelength values across the whole x axis of cropped image by polynomial evaluation
X_axis_1st=1.24./(X_axis_1st.*1e-3);
figure
img_plot_1st=sum(avr_img_1st); %creates a row vector by summing the matrix.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

area(X_axis_1st,(img_plot_1st-min(img_plot_1st))./max(img_plot_1st-min(img_plot_1st)),'LineWidth',3)
% plot(X_axis_1st./.8552,(img_plot_1st-min(img_plot_1st))./max(img_plot_1st-min(img_plot_1st)),'LineWidth',3)
axis tight
% ylim([0 1.1])
set(gca,'FontSize',20,'FontWeight','bold');
xlabel('Energy (in eV)','FontSize', 24,'FontWeight','bold');
ylabel('Intensity (Normalized)','FontSize', 24,'FontWeight','bold');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,col]=size(avr_img_1st);
Y=(((row:-1:1)./row))*1.5;
figure
surf(X_axis_1st,Y,(avr_img_1st-bkg_num)./2500);
view(0,90);
shading interp
axis tight
caxis ([0 1]);
%xlim ([21 31]);
%ylim ([0.3 1.3]);
%set(gca,'XTick',30:10:80);

xlabel('Energy (eV)','FontSize', 24);
ylabel('MCP Y-axis (cm)','FontSize', 24);
%ylabel('Divergence (mrad)','FontSize', 24);
colorbar

set(gcf,'color','w');
set(gca,'FontSize',20)

