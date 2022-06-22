clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folder=fullfile('E:\PhD data\Experimetal Data\July2019 few cycle 100 Hz\gallium2');
cd(folder);
ref_img=fitsread('spectrum2_0001.fts'); 
figure
imshow(ref_img, [100 120]); %[0 500] is just for the contrast management
% imshow(ref_img); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();
figure
imshow(cr_img_1st, [100 150]);
[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for i=1:16
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('spectrum2',name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    avr_img_1st=avr_img_1st+double(image2);
    avr_img_1st;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %Background
%     strip_length=strip;
%     [row1,col1]=size(avr_img_1st);
%     bkg=(avr_img_1st(1:strip_length,:)+avr_img_1st(row1-(strip_length-1):row1,:));
%     bkg_num=sum(sum(bkg))/(2*col1*strip_length); %what is the logic behind this background calculation??
% %img_plot_1st=double(sum(avr_img_1st-bkg_num));
%     img_plot_1st=double(sum(avr_img_1st));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qwerty=(img_plot_1st-min(img_plot_1st))./max(img_plot_1st-min(img_plot_1st));
area(qwerty,'LineWidth',4)
% area((img_plot_1st-min(img_plot_1st))./max(img_plot_1st-min(img_plot_1st)),'LineWidth',4)
%set(gca, 'YScale', 'log')
xlim([0 20])
% plot(X_axis_1st./.8552,(img_plot_1st-min(img_plot_1st))./max(img_plot_1st-min(img_plot_1st)),'LineWidth',3)
axis tight
%ylim([.0011 1.1])
set(gca,'FontSize',20,'FontWeight','bold');
xlabel('Harmonic Order','FontSize', 24,'FontWeight','bold');
ylabel('Normalized Intensity','FontSize', 24,'FontWeight','bold');














