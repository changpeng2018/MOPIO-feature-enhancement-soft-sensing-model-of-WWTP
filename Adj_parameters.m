function [w,c1,c2] = Adj_parameters(w,c1,c2,delt_entropy,delt_threhold,step_w,step_c1,step_c2)
   
    a_d_e=abs(delt_entropy);
    
    if delt_entropy==0
         %ʲô������
         
    elseif  0<a_d_e && a_d_e<delt_threhold %С����ֵ,׷�������
         w  = w+2*step_w*(1+a_d_e);%w����
         c1 = c1+2*step_c1*(1+a_d_e);%c1����
         c2 = c2-2*step_c2*(1+a_d_e);%c2��С
        %����ʦ��
%         w = w+w*exp(1/(SP+1)-1);
%         c1 = c1+c1*exp(1/(SP+1)-1);
%         c2 = c2*exp(1/(SP+1)-1);
        
    elseif a_d_e >= delt_threhold %������ֵ��׷������
         w  = w-step_w*a_d_e;%w��С
         c1 = c1-step_c1*a_d_e;%c1��С
         c2 = c2+step_c2*a_d_e;%c2����
        %����ʦ��
%         w = w*exp(1/(SP+1)-1);
%         c1 = c1*exp(1/(SP+1)-1);
%         c2 = c2+c2*exp(1/(SP+1)-1);
    end

end

