function [x_density] = Density(L)
    [K,~]=size(L);
     x_density=zeros(K,1);
    for i=1:K
        for j=1:K
            if i~=j            
            x_density(i)=x_density(i)+1/(pcd(i,j)^2);%�����ܶ�
            else
                continue;
            end
        end
    end

    function PCD = pcd(i,j)%ƽ�е�Ԫ�����
        PCD=sum(abs(L(i,:)-L(j,:))); 
         if PCD==0
             PCD=0.5;
         end
    end

end