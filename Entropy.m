function [entropy] = Entropy(L)
    
    entropy=0;
    [K,M]=size(L);
    cell = Cell(L);
    for ii=1:K
            for jj=1:M
                temp=cell(ii,jj)/(K*M);
                if temp~=0
                    entropy=entropy-temp*log(temp);%算熵
                end
            end
     end
    
    function cell = Cell(L) %计算单元格只点的数量       
        cell=zeros(K,M);
        for i=1:M
            for j=1:K
                cell(L(j,i),i)=cell(L(j,i),i)+1;
            end
        end
    end

end

