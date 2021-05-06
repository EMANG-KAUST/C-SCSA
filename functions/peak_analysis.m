function [ wa1,wa2,wa3,sg1,sg2,sg3,scsa1,scsa2,scsa3 ,emd1, emd2,emd3,tv1,tv2,tv3] = peak_analysis(  )
pos=[5]; hgt= [2]; wdt=[15];
scsa1=[];
wa1=[];
sg1=[];
wa2=[];
sg2=[];
scsa2=[];
emd1=[];
emd2=[];
wa3=[];
sg3=[];
scsa3=[];
emd3=[];
scsaa1=[];
scsaa2=[];
scsaa3=[];
tv1=[];
tv2=[];
tv3=[];
% ascsaa1=[];
% ascsaa2=[];
% ascsaa3=[];

for i=10:10:100
    
position_errorwa=[];
relative_amplitude_errorwa=[];
 width_errorwa=[];
 
 position_errortv=[];
relative_amplitude_errortv=[];
 width_errortv=[];
 
position_errorsg=[];
relative_amplitude_errorsg=[];
 width_errorsg=[];
 
 position_errorscsa=[];
relative_amplitude_errorscsa=[];
 width_errorscsa=[];
%  
%   position_errorascsa=[];
% relative_amplitude_errorascsa=[];
%  width_errorascsa=[];
 
   position_erroremd=[];
relative_amplitude_erroremd=[];
 width_erroremd=[];
 
    for j=1:1
[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,i);
yf=yf+15;
yf0=yf0+15;
[de1, mse,snr,psnr ] = wa( yf',yf0' );
[de2, mse,snr,psnr ] = sg( yf,yf0 );
 [ de3,mse,snr ,psnr] = SCSAden( yf,yf0 );
 [ de4,mse,snr ,psnr] = eemd_den( yf,yf0 );
  [ de5,mse,snr ,psnr] = TV_den( yf,yf0 );
 %  [ de5,mse,snr ,psnr] = SCSAdenp( yf',yf0' );
 %[ de6,mse,snr ,psnr] = SCSAalpha_den( yf,yf0 );


[ position_error,relative_amplitude_error ] = peak_error( de1,yf0 )
[ width_error ] = peak_errorw( de1,yf0 )
position_errorwa(end+1)=position_error;
relative_amplitude_errorwa(end+1)=relative_amplitude_error;
width_errorwa(end+1)=width_error;



[ position_error,relative_amplitude_error ] = peak_error( de2,yf0 )
[ width_error ] = peak_errorw( de2,yf0 )
position_errorsg(end+1)=position_error;
relative_amplitude_errorsg(end+1)=relative_amplitude_error;
width_errorsg(end+1)=width_error;

[ position_error,relative_amplitude_error ] = peak_error( de3,yf0 )
[ width_error ] = peak_errorw( de3,yf0 )
position_errorscsa(end+1)=position_error;
relative_amplitude_errorscsa(end+1)=relative_amplitude_error;
width_errorscsa(end+1)=width_error;

[ position_error,relative_amplitude_error ] = peak_error( de4,yf0 )
[ width_error ] = peak_errorw( de4,yf0 )
position_erroremd(end+1)=position_error;
relative_amplitude_erroremd(end+1)=relative_amplitude_error;
width_erroremd(end+1)=width_error;


[ position_error,relative_amplitude_error ] = peak_error( de5,yf0 )
[ width_error ] = peak_errorw( de5,yf0 )
position_errortv(end+1)=position_error;
relative_amplitude_errortv(end+1)=relative_amplitude_error;
width_errortv(end+1)=width_error;
% [ position_error,relative_amplitude_error ] = peak_error( de5,yf0 )
% [ width_error ] = peak_errorw( de5,yf0 )
% scsaa1=[scsaa1;position_error];
% scsaa2=[scsaa2;relative_amplitude_error];
% scsaa3=[scsaa3;width_error];
% [ position_error,relative_amplitude_error ] = peak_error( de6,yf0 )
% [ width_error ] = peak_errorw( de6,yf0 )
% [ width_error ] = peak_errorw( de3,yf0 )
% position_errorascsa(end+1)=position_error;
% relative_amplitude_errorascsa(end+1)=relative_amplitude_error;
% width_errorascsa(end+1)=width_error;
    end
    



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%append section%%%%%%%%%%%%%%%%%%%%%%%%
wa1=[wa1;mean(position_errorwa)];
wa2=[wa2;mean(relative_amplitude_errorwa)];
wa3=[wa3;mean(width_errorwa)];

sg1=[sg1;mean(position_errorsg)];
sg2=[sg2;mean(relative_amplitude_errorsg)];
sg3=[sg3;mean(width_errorsg)];

scsa1=[scsa1;mean(position_errorscsa)];
scsa2=[scsa2;mean(relative_amplitude_errorscsa)];
scsa3=[scsa3;mean(width_errorscsa)];

emd1=[emd1;mean(position_erroremd)];
emd2=[emd2;mean(relative_amplitude_erroremd)];
emd3=[emd3;mean(width_erroremd)];

tv1=[tv1;mean(position_errortv)];
tv2=[tv2;mean(relative_amplitude_errortv)];
tv3=[tv3;mean(width_errortv)];
% 
% ascsaa1=[ascsaa1;mean(position_errorascsa)];
% ascsaa2=[ascsaa2;mean(relative_amplitude_errorascsa)];
% ascsaa3=[ascsaa3;mean(width_errorascsa)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%append section%%%%%%%%%%%%%%%%%%%%%%%%%
end

end