function [cgB] = cgBest(gAf,x_potential)
    
    potential=x_potential;
    [~,M]=size(gAf);
    for i=1:M
        [~,index]=min(potential);%找势能最小的
        cgB(i,:) = index;
        potential(index)=+inf;
    end
          
end

