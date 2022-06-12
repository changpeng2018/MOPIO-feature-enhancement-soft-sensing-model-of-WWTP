function [delt_entropy] = Delt_entropy(x_entropy,g)
    
    if g==1
       delt_entropy = x_entropy(g);
    else
       delt_entropy = x_entropy(g)- x_entropy(g-1);
    end

end

