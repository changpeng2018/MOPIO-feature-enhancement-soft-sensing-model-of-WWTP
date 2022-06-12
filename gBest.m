function [gb] = gBest(gA,cgB,dgB,delt_entropy,delt_threhold)
    
    [M,~]=size(cgB);
    a_d_e=abs(delt_entropy);
    
    if a_d_e>=delt_threhold
        Pr=0.5-a_d_e;
    elseif a_d_e==0
        Pr=0;
    elseif 0<a_d_e && a_d_e<delt_threhold
        Pr=0.5+a_d_e;
    end
    r=rand(1);
    %决定候选组
    if r>Pr
        for i=1:M
        gB(i,:)=gA(cgB(i),:);
        end
    else
        for i=1:M
        gB(i,:)=gA(dgB(i),:);
        end
    end
    
    gb=gB(round(r)+1,:);
end

