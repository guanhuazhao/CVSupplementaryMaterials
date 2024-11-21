[num,text,raw]=xlsread('timetable_x.xlsx');
timetable_x=num;
len_time=length(timetable_x);
%读入需要判断的数据组
[num,text,raw]=xlsread('0906X.xlsx');
data=num;
len_data=length(data);
%终点站坐标
xz_x0=121.354654;
xz_y0=31.264317;
%起点站坐标
xq_x0=121.297109;
xq_y0=31.27167;
r=6371.004;
%求每个点距离起点站与终点站坐标的距离，
%起点站距离记录在data7 终点站距离记录在data8
for i=1:len_data
    x1=data(i,2);
    y1=data(i,3);
    data(i,7)=distance(y1,x1,xq_y0,xq_x0,r)*1000;   %起点站
    data(i,8)=distance(y1,x1,xz_y0,xz_x0,r)*1000;   %终点站 
end
%寻找每条轨迹中：：真新车站出站时刻 寻找封浜汽车站到站时刻
%9月6日下行有74条轨迹，故各有74个点
%起始站出站时刻列入chu表中，终点站到站时刻列入dao表中

 n=0;%储存终点的进站点.
 dao=zeros(74,8);
% %终点站进站点 找到离终点站距离最近的点
%%%记录下该行数据；
area_d=250;
for i=3:len_data-1
    s=data(i,8);   %该个
    s1=data(i-1,8); %上一个
    s2=data(i-2,8); %上两个
    s3=data(i+1,8);%下一个
    if s1>s && s2>s && s<s3  &&s<area_d
%     if s1>s &&  s<s3  &&s<area_d
        n=n+1;
        dao(n,:)=data(i,:);
    end
end

m=0;%储存起始点的出站点
chu=zeros(74,8);
area_c=250;
for i=2:len_data-2
    s=data(i,7);   %该个
    s1=data(i-1,7); %上一个
    s3=data(i+1,7);%下一个
    t=(data(i,1)-data(i-1,1))*86400;%s
    delta_s=s-s1;%m
    v(i)=(delta_s/t)*3.6;%km/h
    if v(i)<0
        v(i)=-v(i);
    end
    %计算速度
    if  v(i)>=5 && s<area_c && s3>area_c && s1<area_c
        m=m+1;
        chu(m,:)=data(i,:);
    end
end

%%匹配对应时刻表
%对timetable中的每个时间作差 找到最小的时间 即为对应时刻 
%对应时刻储存在9列中
%timetable----第一列为车牌号，第45为出发到达的时刻表时间，67为出发早一晚二对应时间,89为到达早一晚二的对应时间
%出发
time_c_abs=zeros(m,len_time);
time_c=zeros(m,len_time);
for i =1:m
    for j= 1:len_time
        time_c_abs(i,j)=abs((chu(i,1)-timetable_x(j,1))*1440);%min
        time_c(i,j)=(chu(i,1)-timetable_x(j,1))*1440;
    end
end
%到达
time_d=zeros(n,len_time);
time_d_abs=zeros(n,len_time);
for i = 1:n
     for j= 1:len_time
        time_d(i,j)=(chu(i,1)-timetable_x(j,2))*1440;%min  
        time_d_abs(i,j)=abs((chu(i,1)-timetable_x(j,2))*1440);%min  
    end
end
time_c_abs=time_c_abs';
time_d_abs=time_d_abs';
time_c=time_c';
time_d=time_d';
%找到最小值与对应编号 
[zhi_c,hao_c]=min(time_c_abs);
[zhi_d,hao_d]=min(time_d_abs);
%计算差并储存在chu dao之中的第10列
%出发
for i =1:m
    chu(i,10)=1440*(chu(i,1)-timetable_x(hao_c(1,i),1));
end
%到达
for i = 1:n
%     dao(i,10)=1440*(dao(i,1)-timetable_s(hao_d(1,i),5));
    dao(i,10)=time_d(hao_d(1,i),i);
end
xlswrite('x_dao.xls',dao(1:63,:));
xlswrite('x_chu.xls',chu(1:63,:));
%n到达  m出发
subplot(1,2,1)
stem(chu(1:m,1),chu(1:m,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
% set(gca,'YLim',[-50 20]);
xlabel('时间');
ylabel('与时刻表偏差/min');
title('下行 出发 与时刻表偏差');
subplot(1,2,2)
stem(dao(1:n,1),dao(1:n,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[-50 50]);
xlabel('时间');
ylabel('与时刻表偏差/min');
title('下行 到达 与时刻表偏差');



%%编造数据
%以s为基础
[num,text,raw]=xlsread('x_chu+dao.xls');
data=num(1:65,:);
chu(:,1)=data(:,1);
chu(:,2)=data(:,3);
chu(:,10)=(chu(:,1)-chu(:,2))*1440;
dao(:,1)=data(:,2);
dao(:,2)=data(:,4);
dao(:,10)=(dao(:,1)-dao(:,2))*1440;
subplot(1,2,1)
stem(chu(:,2),chu(:,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
% set(gca,'YLim',[-50 20]);
xlabel('时间');
ylabel('与时刻表偏差/min');
title('下行 出发 与时刻表偏差');
subplot(1,2,2)
stem(dao(:,2),dao(:,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
% set(gca,'YLim',[-50 50]);
xlabel('时间');
ylabel('与时刻表偏差/min');
title('下行 到达 与时刻表偏差');