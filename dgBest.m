function [dgB] = dgBest(gAf,x_density)
 
    density=x_density;
    [~,M]=size(gAf);
    for i=1:M
        [~,index]=min(density);%���ܶ���С��
        dgB(i,:) = index;
        density(index)=+inf;
    end
    
end

