function [L] = Lprojection(gAf)

    [K,M]=size(gAf);    
    for m=1:M
            f_min(m)=min(gAf(:,m));%找第m个目标的最小值
            f_max(m)=max(gAf(:,m));%找第m个目标的最大值
    end
    for k=1:K
        for m=1:M
            delt=f_max(m)-f_min(m);
            if delt~=0
            L(k,m)=floor(K*(gAf(k,m)-f_min(m))/delt);%单元格投影
            if L(k,m)==0
                L(k,m)=1;
            end
            else
                L(k,m)=1;
            end
        end
    end
    
end

