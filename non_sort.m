function [frontvalue] = non_sort(Af)

    fnum=0;%ǰ�ر�ų�ʼ��
    cz=false(1,size(Af,1)); %�Ƿ��ѷ����ű��
    frontvalue=zeros(size(cz)); %ÿ�����ӵ�ǰ�ر��                        
        [Af_sorted,newsite]=sortrows(Af); %�����Ӱ���һάĿ��ֵ��С��������   
        while ~all(cz) %����ֱ��ȫ���������                                    
            fnum=fnum+1;
            d=cz;
            for i=1:size(Af,1)
                if ~d(i)%�����û�����
                    for j=i+1:size(Af,1)
                        if ~d(j)
                            k=1;                            
                            for m=2:size(Af,2)
                                if Af_sorted(i,m)>Af_sorted(j,m)%�������ά��С����֧��
                                    k=0;
                                    break
                                end
                            end
                            if k%����ά��С�ڵ�j��������֧��
                                d(j)=true;
                            end
                        end
                    end
                    frontvalue(newsite(i))=fnum;
                    cz(i)=true;%��i�������
                end
            end
        end
end

