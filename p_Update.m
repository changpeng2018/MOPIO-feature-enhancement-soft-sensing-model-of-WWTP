function [pA] = p_Update(pA,x,dim)
     if size(pA,1)==0
         pA=x;
     else
        for i=1:size(x,1)
            if dominate(x(i,dim+1:end),pA(i,dim+1:end))
                pA(i,:)=x(i,:);
            end
        end
    end
end

