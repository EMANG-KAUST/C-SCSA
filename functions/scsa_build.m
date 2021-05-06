function [yscsa ,Nh,eig_v,eig_f] = scsa_build(h,y)
gm=0.5;
fs=1;
Lcl = (1/(2*sqrt(pi)))*(gamma(gm+1)/gamma(gm+(3/2)));
N=max(size(y));
Ymin=min(y);
y_scsa = y ;
feh = 2*pi/N;
D=delta(N,fs,feh);
Y = diag(y_scsa);
SC_h = -h*h*D-Y; % The Schrodinger operaor
% = = = = = = Begin : The eigenvalues and eigenfunctions
[psi,lamda] = eig(SC_h); % All eigenvalues and associated eigenfunction of the schrodinger operator
% Choosing  eigenvalues
All_lamda = diag(lamda);
ind = find(All_lamda<0);
%  negative eigenvalues
Nh=length(ind);
Neg_lamda = All_lamda(ind);
kappa = diag((abs(Neg_lamda)).^gm);
Nh = size(kappa,1); %%#ok<NASGU> % number of negative eigenvalues
    psin = psi(:,ind(:,1)); % The associated eigenfunction of the negarive eigenvalues
    I = simp(psin.^2,fs); % Normalization of the eigenfunction
    psinnor = psin./sqrt(I);  % The L^2 normalized eigenfunction    
    %yscsa =4*h*sum((psinnor.^2)*kappa,2); % The 1D SC_hSA formula
    yscsa1 =((h/Lcl)*sum((psinnor.^2)*kappa,2)).^(2/(1+2*gm));
   eig_v= kappa;
if size(y_scsa) ~= size(yscsa1)
    yscsa1 = yscsa1';
end
yscsa = yscsa1;

%hold on
eig_f=(h/Lcl)*(psinnor.^2*kappa);
%plot(eig_f)


 %plot(abs(hilbert((eig_f(:,1)))),'linewidth',2)
% xlabel('Samples')
 %ylabel('Amplitude')
 %set(gca, 'FontSize',20);