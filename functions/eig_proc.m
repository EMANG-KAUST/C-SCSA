function [ y ] = eig_proc( x,IMF,c,tho,k)

m=size(IMF,1);
I=(x<0);
x=abs(x);
T=c*norm(IMF(1,:))^2*tho^(-k); %%%%needs to be changed
T
[pks,locs,widths,proms] = findpeaks(x);


for i=1:length(pks)
    if pks(i)<T
        temp_p=pks(i);
        x(locs(i))=0;
        temp=locs(i);
        index_a=temp-1;
        index_b=temp+1;
        %%%%%%%init index for the width of peaks%%%%%%
        while index_a>0&x(index_a)>0.00001 &x(index_a)<temp_p 
            x(index_a)=0;
            index_a=index_a-1;

        end
        while x(index_b)>0.00001 &x(index_b)<temp_p&index_b<length(x)
            x(index_b)=0;
            index_b=index_b+1;
        end    
    end
end
for j=1:length(I)
    if I(j)>0
        x(j)=-x(j);
    end
end

y=x;
end

