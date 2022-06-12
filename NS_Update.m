function [A_new,P] = NS_Update(A,P,AMax,dim)
    
    Pf=fitness(P);
    P=[P,Pf];
    A=[A;P];
    Af=A(:,dim+1:end);
    %���з�֧������
    frontvalue=non_sort(Af);
    %���ݷ�֧������ӵ������ѡ����һ������
    fnum=0; %��ʼ��ǰ����
    fnum_max=max(frontvalue);%ǰ�������ֵ
    
	while (numel(frontvalue,frontvalue<=fnum+1)<=AMax && fnum+1<=fnum_max)
        fnum = fnum+1;
    end
    
    newnum=numel(frontvalue,frontvalue<=fnum);%ǰfnum����ĸ�����
    A_new(1:newnum,:)=A(frontvalue<=fnum,:);%��ǰfnum����ĸ������A�´浵
    
    if fnum==fnum_max
        return;
    end
    
    popu=find(frontvalue==fnum+1);%popu��¼��fnum+1�����ϵĸ�����
    distancevalue=zeros(size(popu));%popu�������ӵ������
    fmax=max(Af(popu,:),[],1);%popuÿά�ϵ����ֵ
    fmin=min(Af(popu,:),[],1);%popuÿά�ϵ���Сֵ
    for i=1:size(Af,2)%��Ŀ�����ÿ��Ŀ����popu�������ӵ������
        [~,newsite]=sortrows(Af(popu,i));
        distancevalue(newsite(1))=inf;
        distancevalue(newsite(end))=inf;
        for j=2:length(popu)-1
            distancevalue(newsite(j))=distancevalue(newsite(j))+(Af(popu(newsite(j+1)),i)-Af(popu(newsite(j-1)),i))/(fmax(i)-fmin(i));
        end
    end                                      
	popu=-sortrows(-[distancevalue;popu]')'; %��ӵ�����뽵�������fnum+1�����ϵĸ���
	A_new(newnum+1:AMax,:)=A(popu(2,1:AMax-newnum),:);	%����fnum+1������ӵ������ϴ��ǰpopnum-newnum�����帴������һ��
end

