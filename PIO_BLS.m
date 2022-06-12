clear all;
format long;%��Ч����16λ
tic;
clc
addpath(genpath("F:\01 ���о����������ݡ�\02  ������ʵ�顿\06  ���Ż�ʵ�����\05  ��PIO-BLS���Ż�\�浵"))
%% ������ʼ��

stop_time=0;%���������ȶ�����
p_num=5;%���Ӹ���
p_dim=3;%����ά��
T_max=15;%����������
pA=[];gA=[];%ȫ�����š��������ų�ʼ��
gMax=50;pMax=5;%ȫ�����š��������Ŵ浵����

w(1)=0.9; step_w =(0.9-0.4)/T_max;%w��w������ʼ��
c1(1)=1.5; step_c1=(2.5-0.5)/T_max;%c1��c1������ʼ��
c2(1)=1.5; step_c2=(2.5-0.5)/T_max;%c2��c2������ʼ��

lowbound=[1 1 1];
minvalue=repmat(lowbound,p_num,1);%�����½�
upbound=[20 20 100];
maxvalue=repmat(upbound,p_num,1);%�����Ͻ�


%% ��ʼ������Ⱥ

for i=1:p_num
    for j=1:p_dim
        x(i,j)=rand(1);  %�����ʼ��λ��
        v(i,j)=rand(1);  %�����ʼ���ٶ�
    end
end
x=ceil([10 10 50].*x);   %������ȡ����

%% ��ʼ��ȫ�ִ浵gA,���Ӵ浵pA,ȫ��Ŀ�����Ŵ浵gAf
        
    [gA,x] = NS_Update(gA,x,gMax,p_dim);
    pA=p_Update(pA,x,p_dim);
    
%% ����Ⱥ����

for g=1:T_max
    %����ֵ����
    gAf=gA(:,p_dim+1:end);
    [K,M]=size(gAf);
    L = Lprojection(gAf);%ƽ�е�Ԫ��ͶӰ
    x_density = Density(L);%�����ܶ�
    x_potential = sum(L,2); %��������
    x_entropy(g) = Entropy(L);%�����gʱ����
    delt_entropy(g) = Delt_entropy(x_entropy,g);%�����gʱ���ر仯��    
    temp=1/(gMax*M);
    delt_threhold = -2*M*temp*log(temp);%�����gʱ���ص���ֵ
    
    %ѡc-gBest
    cgB = cgBest(gAf,x_potential);
    %ѡd-gBest
    dgB = dgBest(gAf,x_density);
    %��������ӵ����SP
%     SP(g)=spacing(x);
    %���·��в���
    [w(g+1),c1(g+1),c2(g+1)] = Adj_parameters(w(g),c1(g),c2(g),delt_entropy(g),delt_threhold,step_w,step_c1,step_c2);
    %ѡ��gBest
    gB=gBest(gA(:,1:p_dim),cgB,dgB,delt_entropy(g),delt_threhold);
    %ѡ��pBeat
    x=x(:,1:p_dim);
    pB=pBest(gB,pA(:,1:p_dim),x,v);
    %�����ٶ�
    for k=1:p_num       
            v(k,:) = w(g+1)*v(k,:)+c1(g+1)*rand*(gA(dgB(round(rand)+1),1:p_dim)-x(k,:))+c2(g+1)*rand*(gA(cgB(round(rand)+1),1:p_dim)-x(k,:));
            x(k,:) = x(k,:)+v(k,:);         
    end
    
    %ѧϰ�ʲ���
   if delt_entropy(g)==0
      stop_time=stop_time+1;%���delt��Ϊ0����ͣ�ʹ�����һ
      if stop_time>=5 && stop_time<=20%�ۼ�ͣ����Σ��Ҳ�����20��
         x=perurbator(x);%�Ŷ�
      end
   else
      stop_time=0;
   end  
   
    x=ceil(x);
    
    %����Խ���½紦��
    x(x>maxvalue)=maxvalue(x>maxvalue);
    x(x<minvalue)=minvalue(x<minvalue);
    
    %ȫ�����Ŵ浵����
	[gA,x]=NS_Update(gA,x,gMax,p_dim);  
    
    %�������Ŵ浵����
    pA=p_Update(pA,x,p_dim);

    %ȫ������Ŀ��浵����
    gAf=gA(:,p_dim+1:end);
    %gAf=fitness(gA);   

end

%%
 load gA1;
 gAf=gA(:,4:5);
 a=gAf(:,1);b=gAf(:,2);
%% ��ͼ
[fitobj,goodness,~]=fit(gAf(:,1),gAf(:,2),'rat21');
plot(fitobj);
ra=differentiate(fitobj,x);
deltra=diff(ra,1);
x=0:1:2000;
% z=polyval(p,x);
z1=100./x;
plot(x,z1,'b');hold on
output(gAf);

%% ѡΨһ��
type=2;
p_sole=selectpoint(gAf,type);%1��ֵ�жϡ�2б��
toc;