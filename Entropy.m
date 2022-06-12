function [entropy] = Entropy(L)
    
    entropy=0;
    [K,M]=size(L);
    cell = Cell(L);
    for ii=1:K
            for jj=1:M
                temp=cell(ii,jj)/(K*M);
                if temp~=0
                    entropy=entropy-temp*log(temp);%����
                end
            end
     end
    
    function cell = Cell(L) %���㵥Ԫ��ֻ�������       
        cell=zeros(K,M);
        for i=1:M
            for j=1:K
                cell(L(j,i),i)=cell(L(j,i),i)+1;
            end
        end
    end

end

