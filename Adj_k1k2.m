function [k1,k2] = Adj_k1k2(k1,k2,SP)
    t=tao(SP(end));
    if size(SP,2)==1
        k1=k1*(t+1);
        k2=k2*t;
    elseif SP(end)>SP(end-1)
        k1=k1*(t+1);
        k2=k2*t;
    elseif SP(end)<SP(end-1)
        k1=k1*t;
        k2=k2*(t+1);
    elseif SP(end)==SP(end-1)
        k1=k1;
        k2=k2;
    end   
end
    function [t]=tao(sp)
        variate=1/(sp+1)-1;
        t=exp(variate);
    end
