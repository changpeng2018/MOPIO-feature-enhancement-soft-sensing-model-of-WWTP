function [pB] = pBest(gB,pA,x,v)

    [K,D]=size(pA);
    k_sco=ones(K,1);
    for k=1:K
        for d=1:D            
            delt_L=Delt_L(d,x(k,:),v(k,:),pA(k,:),gB);
            k_sco(k)=k_sco(k)*delt_L;%差值积累乘
        end       
    end
    [~,no]=min(k_sco);
    pB=pA(no,:);
end

    function [delt_L]=Delt_L(d,x,v,pBk,gB)
        
        xd_max=max(x(:,d));vd_max=max(v(:,d));gB_max=gB(:,d);
        L=[xd_max,vd_max,pBk(d),gB_max];
        L_max = max(L);%选出Lmax
        
        xd_min=min(x(:,d));vd_min=min(v(:,d));gB_min=gB(:,d);
        L=[xd_min,vd_min,pBk(d),gB_min];
        L_min = min(L);%选出Lmin
        
        delt_L = L_max-L_min;%算差值
    end
    
    
    



