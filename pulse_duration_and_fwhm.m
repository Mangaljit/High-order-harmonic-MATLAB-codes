clc
clear all

lambda= 47.15 %central wavelength in nm
pulse_duration= 4.5e-15;  %required pulse duration in 
pulse_duration_fsec=pulse_duration*1e15
c=3e8*1e9; % in nm
fwhm_nm=(lambda^2*0.44)/(c*pulse_duration)
fwhm_eV= (1240/(lambda-fwhm_nm/2)-1240/(lambda+fwhm_nm/2))
