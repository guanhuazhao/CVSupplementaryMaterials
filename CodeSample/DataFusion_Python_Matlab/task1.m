clc;
clear all;
[num,text,raw]= xlsread('1.xlsx','real');
%%计算干线平均行程速度
w=zeros(1,6);
w=[0.1708,0.2315,0.1651,0.2022,0.0900,0.1405];
len=length(num);
for i=1:len
    num(i,9)=num(i,3)*w(1,1)+num(i,4)*w(1,2)+num(i,5)*w(1,3)+num(i,6)*w(1,4)+num(i,7)*w(1,5)+num(i,8)*w(1,6);
end
xlswrite('allv',num);
plot(1:len,allv);
%%基本统计分析
allv=num(:,9);
allvmean=mean(allv);%均值
allvmedian=median(allv);%中位数
allvstd=std(allv);%标准差
allvmax=max(max(allv));%最大值
allvmin=min(min(allv));%最小值
allvmidrange=(allvmax+allvmin)/2;%中列数
allvcov=allvstd/allvmean;%变异系数
%%计算五数概括并绘制箱图
boxplot(allv);
%%计算五分位数
Q1=quantile(allv,0.2,1);
Q2=quantile(allv,0.4,1);
Q3=quantile(allv,0.6,1);
Q4=quantile(allv,0.8,1);
%%计算区间频数与累计分布频率
%法1：[d,zb1,ps]=pinshutongji(allv,2);
%2组分组
figure;
allv_x=[28 30 32 34 36 38 40 42 44 46 48];
allv_bin=[29.4414 39.4414 49.4414]
zj1= histc(allv,allv_x);
%求累计分布频率
xian = cumsum(zj1)/len;  
%绘图
histogram(allv,allv_bin);
hold on
plotyy(0,0,allv_x,xian);


%10组分组
figure;
allv_x=[28 30 32 34 36 38 40 42 44 46 48];
n_elements = histc(allv,allv_x);
%求累计分布频率
c_elements = cumsum(n_elements)/len;  
%绘图
axis([28 48,-inf,inf]);
hist(allv,10);
hold on
plotyy(0,0,allv_x,c_elements);

