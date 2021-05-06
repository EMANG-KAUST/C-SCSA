a1=[];
a2=[];
a3=[];
b1=[];
b2=[];
b3=[];
c1=[];
c2=[];
c3=[];
d1=[];
d2=[];
d3=[];
i=[8,9,10,11];


for j=1:length(i)
    true_signal=rescale( load_signal('Bumps',2^i(j)) )*80+50
   [f, yf, yf0]=Noisy_signal_generation(true_signal,5) 
   [ yscsa,mse,snr ,psnr] = SCSAden( yf',yf0' );
   b1(end+1)=snr;
   [ yscsa,mse,snr ,psnr] = sg( yf',yf0' );
   b2(end+1)=snr;
   [ de,mse,snr ,psnr] = emd_den( yf',yf0' );
   b3(end+1)=snr;
   
end

