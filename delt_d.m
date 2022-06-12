function [d_d] = delt_d(m)

    ato0=zeros(1,m+1);
    ato1=ones(1,m+1);
    threhold=ato1*(1/m);
    a=rand(1,m+1);
    a(a<threhold)=ato0(a<threhold);
    a(a>=threhold)=ato1(a>=threhold);
    for i=0:m
        a(1,i+1)=a(1,i+1)/(2^i);
    end
    d_d=sum(a);
end

