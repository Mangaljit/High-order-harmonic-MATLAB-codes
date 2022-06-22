clear all
close all
clc
no_of_spectra=6;
no_of_images=16;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% row_1st=1154;
% col_1st=2560;
% im_axis_1st = [0.0005*1000    1.1385*1000    2.5600*1000    0.9220*1000];

folder=fullfile('E:\PhD data\Experimetal Data\July2019 few cycle 100 Hz\gallium2');
cd(folder);
ref_img=fitsread('spectrum1_0001.fts'); 

figure
imshow(ref_img, [100 120]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();


[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image



for j=1:no_of_spectra
for i=1:no_of_images
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('spectrum',num2str(j),name,'.fts'));
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    ss=figure;    
   imshow(image2, [100 130]);
    saveas(ss,sprintf('spectrum_surf%d_00%d.png',j,i));
end
end


avr_img_1st=zeros(row_1st,col_1st); % blank image having same size as the cropped image
for j=1:no_of_spectra
for i=1:no_of_images
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('spectrum',num2str(j),name,'.fts'));
%     joiname=cat(2,strcat('chromium100',name,'.fts')); %strcat will place '2' and '265' together as 2265 and cat with 2 also does the same thing
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 

avr_img_1st=double(image2);
   a(i,:)=sum(avr_img_1st); 
end
for i=1:no_of_images
line_loop=a(i,:);
ss=figure;    
plot(line_loop-min(line_loop),'LineWidth',4)    
set(gca,'FontSize',20,'FontWeight','bold');
xlabel('pixels','FontSize', 24,'FontWeight','bold');
ylabel('Intensity (au)','FontSize', 24,'FontWeight','bold');
% name2=sprintf('_%3.4d', i);
% joiname2=cat(2,strcat('chromium',num2str(j),name2,'.fts'));
saveas(ss,sprintf('spectrum_line%d_00%d.png',j,i));

end
end
