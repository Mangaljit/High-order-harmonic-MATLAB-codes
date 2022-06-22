clear all
close all
clc

no_of_images=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folder=fullfile('C:\Users\mangaliitd\Desktop\New folder');
cd(folder);
ref_img=fitsread('chromium1_0001.fts'); 
figure
imshow(ref_img, [100 130]); %[0 500] is just for the contrast management
[cr_img_1st, im_axis_1st]=imcrop(); %cr_img_1st gives cropped image and im_axis_1st gives the cropping rectangle [xmin ymin width height]
close();


[row_1st,col_1st]=size(cr_img_1st); %no. of rows and columns in cropped image



for j=1:2
for i=1:no_of_images
    name=sprintf('_%3.4d',  i);  %makes 0001, 0002, 0003..... program works even without this line
    joiname=cat(2,strcat('chromium',num2str(j),name,'.fts'));
    image=fitsread(joiname); %what image is this?
    image2=imcrop(image, im_axis_1st); %to make sure cropped image matches with the previous 
    ss=figure;    
   imshow(image2, [100 130]);
    saveas(ss,sprintf('chromium%d_00%d.png',j,i));
end
end

