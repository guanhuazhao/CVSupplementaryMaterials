% %上行
% [num,text,raw]=xlsread('timetable_s.xlsx');
% timetable_s=num;
% %用timetable储存，第一列为车牌号，第45为出发到达的时刻表时间，67为出发早一晚二对应时间,89为到达早一晚二的对应时间
% len_time=length(timetable_s);
% %timetable第一列为车牌序号，五六为出发到达时刻表
%     for i = 1: len_time
%        chufa=timetable_s(i,4);
%        daoda=timetable_s(i,5);
%        %0~1=0~86400s
%        %1min=1/1440
%        %早1
%        timetable_s(i,6)=chufa-1/1440;
%        timetable_s(i,8)=daoda-1/1440;
%        %晚2
%        timetable_s(i,7)=chufa+2/1440;
%        timetable_s(i,9)=daoda+2/1440;
%     end

%上行
[num,text,raw]=xlsread('timetable_s.xlsx');
timetable_s=num;
len_time=length(timetable_s);
%读入需要判断的数据组
[num,text,raw]=xlsread('0906S.xlsx');
data=num;
len_data=length(data);
%终点站坐标
sz_x0=121.297079;
sz_y0=31.27175;
%起点站坐标
sq_x0=121.354537;
sq_y0=31.264483;
r=6371.004;
%求每个点距离起点站与终点站坐标的距离，
%起点站距离记录在data7 终点站距离记录在data8
for i=1:len_data
    x1=data(i,2);
    y1=data(i,3);
    data(i,7)=distance(y1,x1,sq_y0,sq_x0,r)*1000;   %起点站
    data(i,8)=distance(y1,x1,sz_y0,sz_x0,r)*1000;   %终点站 
end
%寻找每条轨迹中：：真新车站出站时刻 寻找封浜汽车站到站时刻
%9月6日上行有75条轨迹，故各有75个点
%起始站出站时刻列入chu表中，终点站到站时刻列入dao表中

 n=0;%储存终点的进站点.
 dao=zeros(75,8);
% %终点站进站点 找到离终点站距离最近的点
%%%记录下该行数据；
area_d=178;
for i=3:len_data-2
    s=data(i,8);   %该个
    s1=data(i-1,8); %上一个
    s2=data(i-2,8); %上两个
    s3=data(i+1,8);%下一个
    if s1>s && s2>s && s<s3  &&s<area_d
        n=n+1;
        dao(n,:)=data(i,:);
    end
end
m=0;%储存起始点的出站点
chu=zeros(75,8);
area_c=220;
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
    if  v(i)>=15 && s<area_c && s3>area_c && s1<area_c
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
        time_c_abs(i,j)=abs((chu(i,1)-timetable_s(j,4))*1440);%min
        time_c(i,j)=(chu(i,1)-timetable_s(j,4))*1440;
    end
end
%到达
time_d=zeros(n,len_time);
time_d_abs=zeros(n,len_time);
for i = 1:n
     for j= 1:len_time
        time_d(i,j)=(chu(i,1)-timetable_s(j,5))*1440;%min  
        time_d_abs(i,j)=abs((chu(i,1)-timetable_s(j,5))*1440);%min  
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
    chu(i,10)=1440*(chu(i,1)-timetable_s(hao_c(1,i),4));
end
%到达
for i = 1:n
%     dao(i,10)=1440*(dao(i,1)-timetable_s(hao_d(1,i),5));
    dao(i,10)=time_d(hao_d(1,i),i);
end
xlswrite('s_dao.xls',dao(1:63,:));
xlswrite('s_chu.xls',chu(1:63,:));

subplot(1,2,1)
stem(chu(:,1),chu(:,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
% set(gca,'YLim',[-50 20]);
xlabel('时间');
ylabel('与时刻表偏差/min');
title('上行 出发 与时刻表偏差');
subplot(1,2,2)
stem(dao(1:63,1),dao(1:63,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[-50 50]);
xlabel('时间');
ylabel('与时刻表偏差/min');
title('上行 到达 与时刻表偏差');




