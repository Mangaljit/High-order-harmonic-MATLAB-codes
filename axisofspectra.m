clc
clear all
a=imread('D:\PhD Folder\Discussion Ozaki\spectra', 'png');
a=double(a);
a(:,:,2)=[];
a(:,:,2)=[];
%Please give following inputs
strip=10; %strip length for background elimination
samples=4; % no. of data sample for polynomial fitting
poly_order=2; %order for polynomial fitting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pixel to orders conversion
% area((sum(cr_img_1st)-min(sum(cr_img_1st)))./max(sum(cr_img_1st)-min(sum(cr_img_1st))));
figure
imshow(a, [100 115]);
[X_val, Y_val]=ginput(samples);
close();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
harmonics=(19:2:17+2*length(X_val)); 
P=polyfit(transpose(X_val), harmonics, poly_order); % does polynomial fitting of order .
X_axis_1st=polyval(P, 1:length(a)); %gives us wavelength values across the whole x axis of cropped image by polynomial evaluation
% X_axis_1st=1.24./(X_axis_1st.*1e-3);
figure
 %creates a row vector by summing the matrix.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,col]=size(a);
Y=(((row:-1:1)./row))*1.5;
figure
surf(0.696.*X_axis_1st,Y,a);
caxis([0 1])
view(0,90);
shading interp
axis tight
xlabel('Energy (eV)','FontSize', 24);
% xlabel('Harmonic Order','FontSize', 24);
%ylabel('MCP Y-axis (cm)','FontSize', 24);
%ylabel('Divergence (mrad)','FontSize', 24);
colorbar

set(gcf,'color','w');
set(gca,'FontSize',20)

