function [cgB] = cgBest(gAf,x_potential)
    
    potential=x_potential;
    [~,M]=size(gAf);
    for i=1:M
        [~,index]=min(potential);%��������С��
        cgB(i,:) = index;
        potential(index)=+inf;
    end
          
end

