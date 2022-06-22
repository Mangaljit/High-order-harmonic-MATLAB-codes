clear all
clc
close all

folder=fullfile ('D:\Google drive\Ashiq code-20161106T165328Z\Ashiq code\graphite2');
cd(folder);

ref_img=imread('spectrum2_0001.fts');
imshow(ref_img, [0 1000]);
[img_crop img_axis]=imcrop();
close();
[row col]=size(img_crop);
avr_img=zeros(row, col);

% 1.75 um wavelength

for i=1:10;
   name=sprintf('_%3.4d', i);
   joiname=cat(2,strcat('spectrum2',name,'.fts'));
   image=imread(joiname);
   image2=imcrop (image, img_axis);
   avr_img=avr_img+ double(image2);    
end

% Background subtract
strip_length=10;
[row1,col1]=size(avr_img);
bkg=(avr_img(1:strip_length,:)+avr_img(row1-(strip_length-1):row1,:));
bkg_num=sum(sum(bkg))/(2*col1*strip_length);
%img_plot=(sum(avr_img)-bkg_num*2);

B=avr_img;
C=sum(B)-bkg_num*2;
[row,col]=size(B);
figure();
%plot(C);
imshow(B, [0 2000]);
[X_val, Y_val]=ginput(7);
close();
harmonics=1786./(29:2:27+2*length(X_val));
P=polyfit(transpose(X_val), harmonics, 2);
X=polyval(P, 1:length(C));

Y=(((row:-1:1)./row))*1.5;

figure
surf(1240./X,Y,(B-bkg_num)./350);
view(0,90);
shading interp
axis tight
caxis ([0 1]);
xlim ([21 31]);
%ylim ([0.3 1.3]);
%set(gca,'XTick',30:10:80);

xlabel('Energy (eV)','FontSize', 24);
ylabel('MCP Y-axis (cm)','FontSize', 24);
%ylabel('Divergence (mrad)','FontSize', 24);
colorbar

set(gcf,'color','w');
set(gca,'FontSize',20)