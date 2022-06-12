clear all;
format long;%有效数字16位
tic;
clc
addpath(genpath("F:\01 【研究生工作内容】\02  【课题实验】\06  【优化实验程序】\05  【PIO-BLS】优化\存档"))
%% 参数初始化

stop_time=0;%粒子陷入稳定代数
p_num=5;%粒子个数
p_dim=3;%粒子维度
T_max=15;%最大迭代次数
pA=[];gA=[];%全局最优、个人最优初始化
gMax=50;pMax=5;%全局最优、个人最优存档上限

w(1)=0.9; step_w =(0.9-0.4)/T_max;%w与w步长初始化
c1(1)=1.5; step_c1=(2.5-0.5)/T_max;%c1与c1步长初始化
c2(1)=1.5; step_c2=(2.5-0.5)/T_max;%c2与c2步长初始化

lowbound=[1 1 1];
minvalue=repmat(lowbound,p_num,1);%粒子下界
upbound=[20 20 100];
maxvalue=repmat(upbound,p_num,1);%粒子上界


%% 初始化粒子群

for i=1:p_num
    for j=1:p_dim
        x(i,j)=rand(1);  %随机初始化位置
        v(i,j)=rand(1);  %随机初始化速度
    end
end
x=ceil([10 10 50].*x);   %（向下取整）

%% 初始化全局存档gA,粒子存档pA,全局目标最优存档gAf
        
    [gA,x] = NS_Update(gA,x,gMax,p_dim);
    pA=p_Update(pA,x,p_dim);
    
%% 粒子群迭代

for g=1:T_max
    %基础值计算
    gAf=gA(:,p_dim+1:end);
    [K,M]=size(gAf);
    L = Lprojection(gAf);%平行单元格投影
    x_density = Density(L);%计算密度
    x_potential = sum(L,2); %计算势能
    x_entropy(g) = Entropy(L);%计算第g时刻熵
    delt_entropy(g) = Delt_entropy(x_entropy,g);%计算第g时刻熵变化量    
    temp=1/(gMax*M);
    delt_threhold = -2*M*temp*log(temp);%计算第g时刻熵的阈值
    
    %选c-gBest
    cgB = cgBest(gAf,x_potential);
    %选d-gBest
    dgB = dgBest(gAf,x_density);
    %计算粒子拥挤度SP
%     SP(g)=spacing(x);
    %更新飞行参数
    [w(g+1),c1(g+1),c2(g+1)] = Adj_parameters(w(g),c1(g),c2(g),delt_entropy(g),delt_threhold,step_w,step_c1,step_c2);
    %选择gBest
    gB=gBest(gA(:,1:p_dim),cgB,dgB,delt_entropy(g),delt_threhold);
    %选择pBeat
    x=x(:,1:p_dim);
    pB=pBest(gB,pA(:,1:p_dim),x,v);
    %更新速度
    for k=1:p_num       
            v(k,:) = w(g+1)*v(k,:)+c1(g+1)*rand*(gA(dgB(round(rand)+1),1:p_dim)-x(k,:))+c2(g+1)*rand*(gA(cgB(round(rand)+1),1:p_dim)-x(k,:));
            x(k,:) = x(k,:)+v(k,:);         
    end
    
    %学习率部分
   if delt_entropy(g)==0
      stop_time=stop_time+1;%如果delt熵为0，则停滞次数加一
      if stop_time>=5 && stop_time<=20%累计停滞五次，且不大于20次
         x=perurbator(x);%扰动
      end
   else
      stop_time=0;
   end  
   
    x=ceil(x);
    
    %粒子越上下界处理
    x(x>maxvalue)=maxvalue(x>maxvalue);
    x(x<minvalue)=minvalue(x<minvalue);
    
    %全局最优存档更新
	[gA,x]=NS_Update(gA,x,gMax,p_dim);  
    
    %个人最优存档更新
    pA=p_Update(pA,x,p_dim);

    %全局最优目标存档更新
    gAf=gA(:,p_dim+1:end);
    %gAf=fitness(gA);   

end

%%
 load gA1;
 gAf=gA(:,4:5);
 a=gAf(:,1);b=gAf(:,2);
%% 绘图
[fitobj,goodness,~]=fit(gAf(:,1),gAf(:,2),'rat21');
plot(fitobj);
ra=differentiate(fitobj,x);
deltra=diff(ra,1);
x=0:1:2000;
% z=polyval(p,x);
z1=100./x;
plot(x,z1,'b');hold on
output(gAf);

%% 选唯一解
type=2;
p_sole=selectpoint(gAf,type);%1比值判断、2斜率
toc;