function [L] = Lprojection(gAf)

    [K,M]=size(gAf);    
    for m=1:M
            f_min(m)=min(gAf(:,m));%�ҵ�m��Ŀ�����Сֵ
            f_max(m)=max(gAf(:,m));%�ҵ�m��Ŀ������ֵ
    end
    for k=1:K
        for m=1:M
            delt=f_max(m)-f_min(m);
            if delt~=0
            L(k,m)=floor(K*(gAf(k,m)-f_min(m))/delt);%��Ԫ��ͶӰ
            if L(k,m)==0
                L(k,m)=1;
            end
            else
                L(k,m)=1;
            end
        end
    end
    
end

