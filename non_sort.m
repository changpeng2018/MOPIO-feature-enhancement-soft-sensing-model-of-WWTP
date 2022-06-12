function [frontvalue] = non_sort(Af)

    fnum=0;%前沿编号初始化
    cz=false(1,size(Af,1)); %是否已分配编号标记
    frontvalue=zeros(size(cz)); %每个粒子的前沿编号                        
        [Af_sorted,newsite]=sortrows(Af); %对粒子按第一维目标值大小进行排序   
        while ~all(cz) %迭代直到全部都被编号                                    
            fnum=fnum+1;
            d=cz;
            for i=1:size(Af,1)
                if ~d(i)%如果还没被编号
                    for j=i+1:size(Af,1)
                        if ~d(j)
                            k=1;                            
                            for m=2:size(Af,2)
                                if Af_sorted(i,m)>Af_sorted(j,m)%如果其他维不小于则不支配
                                    k=0;
                                    break
                                end
                            end
                            if k%其他维都小于第j个，所以支配
                                d(j)=true;
                            end
                        end
                    end
                    frontvalue(newsite(i))=fnum;
                    cz(i)=true;%第i个被编号
                end
            end
        end
end

