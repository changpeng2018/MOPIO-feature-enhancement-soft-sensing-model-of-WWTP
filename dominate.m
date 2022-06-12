function [flag] = dominate(af,bf)
    
    flag=0;
    for i=1:size(af,2)
        if af(i)>bf(i)%如果a有任意点大于b，则不支配
            flag=0;
            break;
        elseif af(i)<bf(i) %如果a有点小于b，标记为支配         
                flag=1;
        end

end

