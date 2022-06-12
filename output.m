function [] = output(gAf)
   %figure;
   for i=1:size(gAf,1)
        plot(gAf(i,1),gAf(i,2),'sb');
        hold on;
   end
end

