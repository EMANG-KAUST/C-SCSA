%% MRS signal Denosiing  using SCSA Method :
% This function denoised the real part of the MRS signal using and optimal
% value of the h the ensures the preservation of the metabolite area,
% determined by <Metabolite>, while remove as maximuim as possible the noise from the
% region determined by <Noise>

%% ######################  PARAMETERS ######################################
% Input
% ppm         : The MRS spectrum fequancies in ppm
% yf          : Noisy real art of the  complex MRS FID signal
% Th_peaks_ratio  : The ratio w.r.t metabolite amplitude to set the threshold from which the peak can be selected
% width_peaks  : The with of the peak from its center(max values)
% gm, fs  : SCSA parameter: gm=0.5, fs=1

% Output
% yscsa: Densoied real art of the  complex MRS FID signal
% h_op : The  real art of the  complex MRS FID signal
% Nh   : Densoied real art of the  complex MRS FID signal

%% ###########################################################################
%  Author:
%  Abderrazak Chahid (abderrazak.chahid@gmail.com)
%  Adviser:
%  Taous-Meriem Laleg (taousmeriem.laleg@kaust.edu.sa)
% Done: June,  2018
% King Abdullah University of Sciences and Technology (KAUST)

function [truth,harray,se,yscsa, Nh]=SCSA_MRS_Denoising(Denoising_coeff, ppm, yf, gm , fs , Th_peaks_ratio, width_peaks,lambda,yf0)

global shif
truth=[];
hhh=[];


%% Get the noise and metabolites locations
%  [Noise,Metabolite]=find_metabolite_Noisy_Area(yf, Th_peaks_ratio, width_peaks)
%  [m,n]=size(Metabolite);
%  if m<1
%      yscsa=1;
%      return 
%  end
%  
%  Noise(2)=Noise(1)+10;
%% Generate signals
fprintf('\n_____________________________________________________________')
fprintf('\n_____________________________________________________________\n\n')

Max_empty_iter=10;     % the the maximuim iteration allows with increasing cost function [H goes far from the optimal h]

%% MRS signal
y = real(yf);%/max(real(yf))*76;

% you can choose either a vecotr for h or one value
hh=max(y)/100 : 1 :max(y);  % search in this interval

%% Some specific values for the real signal
% a1= 812;b1= 822;
% a2= 874;b2= 882;
% a3= 882;b3= 893;



fprintf('\n-->Searching for the optimal h')
harray=[];
se=[];

% start the loop for several values of h

for i=1:length(hh)
    
    h = hh(i);%0.045;%15.2;
    
    % yscsa = scsa(h);
    [h, yscsa,Nh,psinnor,kappa,Ymin,squaredEIGF0]= SCSA_1D(y,fs,h,gm);
   
    % coco1(i) = norm(y(a1:b1) - yscsa(a1:b1));
    % coco2(i) =  norm(y(a2:b2) - yscsa(a2:b2));
    % coco3(i) =  norm(y(a3:b3) - yscsa(a3:b3));
    % % coco(i) =norm(y - yscsa);
    
    y_res=y-yscsa;
    lenSCSA=length(yscsa);
    y_res;
    y_p1=gradient(yscsa);
    y_p2=gradient(y_p1);
    curv=abs(y_p2)./(1+y_p1.^2).^(1.5);
    %curv=abs(y_p2.^2);
    q = simpsons(y_p2,1,lenSCSA);
    second_term=sum(curv);
    second_term=second_term*lambda;
    se(end+1)=second_term;
    %SNR_y=max(yscsa)/std(y(Noise(1):Noise(2)));   %second term retaed to the  SNR
    %SNR_scsa=max(yscsa)/std(yscsa(Noise(1):Noise(2)));   %second term retaed to the  residual SNR
    
   % Cost_SNR=(Denoising_coeff/abs(SNR_scsa));%*abs(SNR_y);
    
%
Cost_peak=0;
   %  for k=1:size(Metabolite,1)
    %     Cost_peak=Cost_peak + norm(y_res(Metabolite(k,1:2)));
    % end
     if size(y_res,1)>1
         y_res=y_res';
     end
     
    Cost_peak=y_res*y_res';
   
   % Cost_func_SNR(i)=Cost_SNR;
  %  Cost_func_MSE(i)=Cost_peak;
  Cost_peak;

   Cost_function(i)=Cost_peak;
   Cost_function(i)=second_term+Cost_peak;
    fprintf('.')
    harray(end+1)=second_term+Cost_peak;
    res=Cost_peak;
    truth(end+1)=res;
    hhh(end+1)=h;
end

[M,I]=min(truth)
hhh(I)
h_op=min(hh(find(Cost_function==min(Cost_function))));

[h_op, yscsa,Nh,psinnor,kappa,Ymin,squaredEIGF0]= SCSA_1D(y,fs,h_op,gm);
% find_metabolite_Noisy_Area(yscsa, Th_peaks_ratio, width_peaks);
% string='h value is'
% h_op
% string='SNR before is'
% s_11=max(yf)/std(y(Noise(1):Noise(2)))
% st=s_11;
% string='SNR after is'
% s_22=max(yscsa)/std(yscsa(Noise(1):Noise(2)))
% string='gain is %'
% s_22/s_11*100

%% plot the results
% 
% figure(1);
% plot(ppm,y,'b','LineWidth',2);hold on
% plot(ppm, yscsa ,'r','LineWidth',2);hold on
% plot(ppm, y-yscsa-5,'g','LineWidth',1)
% legend('yscsa','y')
% legend({'Noisy input spectrum ', 'Denoised Spectrum ','Residue'},'Location','northwest');
% xlabel('ppm')
% ylabel('Intensity')
% yl=ylim;
% %set(gca,'YTickLabel',[])
% %xlim([0 5])
% title([ ' SCSA MRS densoing with : h = ' num2str(h_op) , '   Nh = ' num2str(Nh) ]);% ', fe = ' num2str(fe) ', amp noise = ' num2str(amp_noise)])
% set(gcf,'color','w')
%set(gca,'Xdir','reverse');
% text(1.9,90,'NAA');text(1.40,63,'Lac(1)');text(1.2,55,'Lac(2)');text(4.7,45,'Water residue');
box
% X=[];Y=[];

% for k=1:size(Metabolite,1)
% X(:,k)=[Metabolite(k,1);Metabolite(k,1);Metabolite(k,2);Metabolite(k,2)];
% end
% for k=1:size(Metabolite,1)
% Y(:,k)=[yl(1); yl(2); yl(2); yl(1)];
% end
% X=X/1000*10;
% Y=Y;
% patch(X,Y,'k',...
%     'facecolor',[.4 .6 .4],'edgecolor',[.4 .6 .4],...
%     'facealpha',0.3,'edgealpha',0.3)

fprintf('--> MRS denoising is completed h=%f!!',h_op)

%% Get the optimal
% figure(2)
% plot(Cost_function); hold on
% plot(Cost_func_SNR); hold on
% plot(Cost_func_MSE); hold on
%
% xlabel('Iterations')
% ylabel('Cost function ')
% title([ 'The Iterative MRS signal denoising']);% ', fe = ' num2str(fe) ', amp noise = ' num2str(amp_noise)])





% figure;plot(yf_peaks);hold on;plot(yf_smooth);hold on;plot(diff(yf_smooth));hold on;plot(yf_smooth*0+Th);

function [h, yscsa,Nh,psinnor,kappa,Ymin,squaredEIGF0]= SCSA_1D(y,fs,h,gm)

Lcl = (1/(2*sqrt(pi)))*(gamma(gm+1)/gamma(gm+(3/2)));
N=max(size(y));
%% remove the negative part
Ymin=min(y);

y_scsa = y -Ymin;
%% Build Delta metrix for the SC_hSA
feh = 2*pi/N;
D=delta(N,fs,feh);

%% start the SC_hSA
Y = diag(y_scsa);
SC_h = -h*h*D-Y; % The Schrodinger operaor

% = = = = = = Begin : The eigenvalues and eigenfunctions
[psi,lamda] = eig(SC_h); % All eigenvalues and associated eigenfunction of the schrodinger operator
% Choosing  eigenvalues
All_lamda = diag(lamda);
ind = find(All_lamda<0);


%  negative eigenvalues
Neg_lamda = All_lamda(ind);
kappa = diag((abs(Neg_lamda)).^gm);
Nh = size(kappa,1); %%#ok<NASGU> % number of negative eigenvalues



if Nh~=0
    
    % Associated eigenfunction and normalization
    psin = psi(:,ind(:,1)); % The associated eigenfunction of the negarive eigenvalues
    I = simp(psin.^2,fs); % Normalization of the eigenfunction
    psinnor = psin./sqrt(I);  % The L^2 normalized eigenfunction
    
    
    %yscsa =4*h*sum((psinnor.^2)*kappa,2); % The 1D SC_hSA formula
    yscsa1 =((h/Lcl)*sum((psinnor.^2)*kappa,2)).^(2/(1+2*gm));
else
    
    psinnor = 0*psi;  % The L^2 normalized eigenfunction
    
    yscsa1=0*y;
    yscsa1=yscsa1-10*abs(max(y));
    disp('There are no negative eigenvalues. Please change the SCSA parameters: h, gm ')
end


if size(y_scsa) ~= size(yscsa1)
    yscsa1 = yscsa1';
end

%% add the removed negative part
yscsa = yscsa1 + Ymin;


squaredEIGF0=(h/Lcl)*(psinnor.^2)*kappa;




%**********************************************************************
%*********              Numerical integration                 *********
%**********************************************************************

% Author: Taous Meriem Laleg

function y = simp(f,dx);
%  This function returns the numerical integration of a function f
%  using the Simpson method

n=length(f);
I(1)=1/3*f(1)*dx;
I(2)=1/3*(f(1)+f(2))*dx;

for i=3:n
    if(mod(i,2)==0)
        I(i)=I(i-1)+(1/3*f(i)+1/3*f(i-1))*dx;
    else
        I(i)=I(i-1)+(1/3*f(i)+f(i-1))*dx;
    end
end
y=I(n);


%**********************************************************************
%*********             Delata Metrix discretization           *********
%**********************************************************************


%Author: Zineb Kaisserli

function [Dx]=delta(n,fex,feh)
ex = kron([(n-1):-1:1],ones(n,1));
if mod(n,2)==0
    dx = -pi^2/(3*feh^2)-(1/6)*ones(n,1);
    test_bx = -(-1).^ex*(0.5)./(sin(ex*feh*0.5).^2);
    test_tx =  -(-1).^(-ex)*(0.5)./(sin((-ex)*feh*0.5).^2);
else
    dx = -pi^2/(3*feh^2)-(1/12)*ones(n,1);
    test_bx = -0.5*((-1).^ex).*cot(ex*feh*0.5)./(sin(ex*feh*0.5));
    test_tx = -0.5*((-1).^(-ex)).*cot((-ex)*feh*0.5)./(sin((-ex)*feh*0.5));
end
Ex = full(spdiags([test_bx dx test_tx],[-(n-1):0 (n-1):-1:1],n,n));

Dx=(feh/fex)^2*Ex;




