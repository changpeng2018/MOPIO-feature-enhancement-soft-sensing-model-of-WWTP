function [A_new,P] = NS_Update(A,P,AMax,dim)
    
    Pf=fitness(P);
    P=[P,Pf];
    A=[A;P];
    Af=A(:,dim+1:end);
    %进行非支配排序
    frontvalue=non_sort(Af);
    %根据非支配排序、拥挤距离选出下一代个体
    fnum=0; %初始化前沿面
    fnum_max=max(frontvalue);%前沿面最大值
    
	while (numel(frontvalue,frontvalue<=fnum+1)<=AMax && fnum+1<=fnum_max)
        fnum = fnum+1;
    end
    
    newnum=numel(frontvalue,frontvalue<=fnum);%前fnum个面的个体数
    A_new(1:newnum,:)=A(frontvalue<=fnum,:);%将前fnum个面的个体放入A新存档
    
    if fnum==fnum_max
        return;
    end
    
    popu=find(frontvalue==fnum+1);%popu记录第fnum+1个面上的个体编号
    distancevalue=zeros(size(popu));%popu各个体的拥挤距离
    fmax=max(Af(popu,:),[],1);%popu每维上的最大值
    fmin=min(Af(popu,:),[],1);%popu每维上的最小值
    for i=1:size(Af,2)%分目标计算每个目标上popu各个体的拥挤距离
        [~,newsite]=sortrows(Af(popu,i));
        distancevalue(newsite(1))=inf;
        distancevalue(newsite(end))=inf;
        for j=2:length(popu)-1
            distancevalue(newsite(j))=distancevalue(newsite(j))+(Af(popu(newsite(j+1)),i)-Af(popu(newsite(j-1)),i))/(fmax(i)-fmin(i));
        end
    end                                      
	popu=-sortrows(-[distancevalue;popu]')'; %按拥挤距离降序排序第fnum+1个面上的个体
	A_new(newnum+1:AMax,:)=A(popu(2,1:AMax-newnum),:);	%将第fnum+1个面上拥挤距离较大的前popnum-newnum个个体复制入下一代
end

