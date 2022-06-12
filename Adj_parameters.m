function [w,c1,c2] = Adj_parameters(w,c1,c2,delt_entropy,delt_threhold,step_w,step_c1,step_c2)
   
    a_d_e=abs(delt_entropy);
    
    if delt_entropy==0
         %什么都不做
         
    elseif  0<a_d_e && a_d_e<delt_threhold %小于阈值,追求多样性
         w  = w+2*step_w*(1+a_d_e);%w增大
         c1 = c1+2*step_c1*(1+a_d_e);%c1增大
         c2 = c2-2*step_c2*(1+a_d_e);%c2减小
        %韩老师版
%         w = w+w*exp(1/(SP+1)-1);
%         c1 = c1+c1*exp(1/(SP+1)-1);
%         c2 = c2*exp(1/(SP+1)-1);
        
    elseif a_d_e >= delt_threhold %大于阈值，追求收敛
         w  = w-step_w*a_d_e;%w减小
         c1 = c1-step_c1*a_d_e;%c1减小
         c2 = c2+step_c2*a_d_e;%c2增大
        %韩老师版
%         w = w*exp(1/(SP+1)-1);
%         c1 = c1*exp(1/(SP+1)-1);
%         c2 = c2+c2*exp(1/(SP+1)-1);
    end

end

