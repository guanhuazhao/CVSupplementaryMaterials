%补充进出站信息 
%stan_s 与stan_x的第五列储存进站信息 第六列储存出站信息
%stan_s与stan_x第五列第一个为0，第六列第二个为0

%补充上行数据基础
[num,text,raw]=xlsread('jizhun.xls');
stan_s=num;
stan_s_num=length(stan_s);
%求各个站点到起始点的距离，储存在stan_s第六列
%stan_s（，4）=1为站点 2为交叉口 3为中间点
%查看有多少个站点，包括起始站与终点站
% k=0
% for i= 1:stan_s_num
%     if stan_s(i,4)==1
%         k=k+1;
%     end
% end
%共有24个站点，k为站点个数
%确定每个数据点距离起始站的累计行程距离,储存在stan_s第六列，第一站为0
stan_s(1,6)=0;
L=0;
for i=2:stan_s_num
    L=L+stan_s(i-1,5);
    stan_s(i,6)=L;
end
%取出其中的站点数据，储存在zhan中
%zhan 12为经纬度 3为点的类型 4为距离起始点距离
%
k=0
zhan_s=zeros(24,4);
for i=1:stan_s_num
    if stan_s(i,4)==1
        k=k+1;
        zhan_s(k,1:2)=stan_s(i,1:2);
        zhan_s(k,3)=stan_s(i,4);
        zhan_s(k,4)=stan_s(i,6);
    end
end
xlswrite('zhan_s',zhan_s);

%%以09060100为例补充基础信息
%12经纬度 3位累积行程距离 4为时间
[num,text,raw]=xlsread('xiufu.xls');
temp=num;
temp_num=length(temp);
%寻找进站点2-24，将进站点的GPS轨迹点数据记录到zhan56列之中9记录点i
%第一个站的56列为0,在temp第5列中进行标记，5为0表示为中间点，1为进站点 2为出站点
zhan_s(1,5)=0;
zhan_s(1,6)=0;
x=2;
for i =1:temp_num
    s=(zhan_s(x,4)-temp(i,3))*1000;
    if s<=25 
        zhan_s(x,5:6)=temp(i,1:2);%找到进站点
        temp(i,5)=1;
        zhan_s(x,9)=i;
        x=x+1;%对x进行更新，寻找下一个站的进站点
    end
    %对最近站进行修改
end

%寻找出站点1-23，78列距离10，10记录点i
y=2;
zhan_s(24,7)=0;
zhan_s(24,8)=0;
for i =1:temp_num-1
    s=(temp(i,3)-zhan_s(y,4))*1000;%该点
    s1=(temp(i+1,3)-zhan_s(y,4))*1000 %下一个点  
    if s<=25 && s1>25%当该点<25且下一个点>25时，该点为距离该站驶出阈值范围内最远的点
        zhan_s(y,7:8)=temp(i,1:2);%找到出站点
        zhan_s(y,10)=i;
        temp(i,5)=2;
        y=y+1;%对y进行更新，寻找下一个站的出站点
    end
    %对最近站进行修改
end

k1=0;
k2=0;
%绘图，进站为红* 出站为蓝。
plot(temp(:,4),temp(:,3));
hold on
for i= 1:temp_num
    if temp(i,5)==1
        k1=k1+1;
        scatter(temp(i,4),temp(i,3),'r','*');
    else if temp(i,5)==2
            k2=k2+1;
            scatter(temp(i,4),temp(i,3),'b','*');
        end
    end
end
hold on
for i = 1:24
    y=zhan_s(i,4);
    line([0.3800 0.4323],[y y],'Color','yellow','LineStyle','--');
    hold on;
end
xlabel('时间');
ylabel('行程距离');
title('补充数据基础后时空轨迹图');



%补充下行数据基础
[num,text,raw]=xlsread('mapxia.xlsx');
stan_x=num;
