function [flag] = dominate(af,bf)
    
    flag=0;
    for i=1:size(af,2)
        if af(i)>bf(i)%���a����������b����֧��
            flag=0;
            break;
        elseif af(i)<bf(i) %���a�е�С��b�����Ϊ֧��         
                flag=1;
        end

end

