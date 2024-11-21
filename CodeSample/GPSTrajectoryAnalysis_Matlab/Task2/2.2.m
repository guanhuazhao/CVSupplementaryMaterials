[num,text,raw]=xlsread('s.xlsx');
temp_s=num;
len_s=length(temp_s);
[num,text,raw]=xlsread('x.xlsx');
temp_x=num;
len_x=length(temp_x);

%1为车辆ID，共13辆车 2kong 3时间 45经纬度
bus_num=13;
%绘图
figure;
scatter(temp_s(:,3),temp_s(:,1),1,'b','.');
hold on
scatter(temp_x(:,3),temp_x(:,1),1,'r','.');
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','沪A-08706D','沪A-00576D','沪A-00577D','沪A-01202D','沪A-01339D','沪A-01722D','沪A-01880D','沪A-01976D','沪A-03593D','沪A-07360D','沪A-07695D','沪A-09169D','沪A-09359D'});
ylabel('公交车牌号');
title('9月7日嘉定104路公交车辆使用情况');
label('上行','下行');

%准点率
[num,text,raw]=xlsread('timetable_s.xlsx');
timetable_s=num;

   %用timetable储存，第一列为车牌号，第45为出发到达的时刻表时间，67为出发早一晚二对应时间,89为到达早一晚二的对应时间
    len=length(timetable);
    %timetable第一列为车牌序号，五六为出发到达时刻表
    for i = 1: len
       chufa=timetable(i,4);
       daoda=timetable(i,5);
       %0~1=0~86400s
       %1min=1/1440
       %早1
       timetable(i,6)=chufa-1/1440;
       timetable(i,8)=daoda-1/1440;
       %晚2
       timetable(i,7)=chufa+2/1440;
       timetable(i,9)=daoda+2/1440;
    end
    
    %用函数判断是否准点，计算准点率 储存在zhundianlv.xlsx中
[num,text,raw]=xlsread('zhundianlv.xlsx');
zhundianlv=num;
    %首末班车上下行
figure;
data=[1 0;0.5 0;1 0;1 0;0.5 0];

bar(data);
legend('上行','下行');
xlabel('日期');
ylabel('准点率');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'9月6日','9月7日','9月8日','9月9日','9月10日'});
title('首末班上下行准点率');

%全天与早晚高峰
figure;
subplot(3,2,1);
data=[0.8636 0.3846 1;0.806 0.8 0.92];
bar(data);
legend('全天','早高峰','晚高峰');
xlabel('日期');
ylabel('准点率');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'上行','下行'});
title('9月6日班次平均出发准点率');

subplot(3,2,2);
data=[0.9394 0.7692 0.92;0.8507 0.8 0.92];
bar(data);
legend('全天','早高峰','晚高峰');
xlabel('日期');
ylabel('准点率');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'上行','下行'});
title('9月7日班次平均出发准点率');

subplot(3,2,3);
data=[0.9394 0.7692 0.92;0.8955 0.8 0.92];
bar(data);
legend('全天','早高峰','晚高峰');
xlabel('日期');
ylabel('准点率');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'上行','下行'});
title('9月8日班次平均出发准点率');

subplot(3,2,4);
data=[0.9545 0.6923 0.92;0.8507 0.7333 0.92];
bar(data);
legend('全天','早高峰','晚高峰');
xlabel('日期');
ylabel('准点率');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'上行','下行'});
title('9月9日班次平均出发准点率');

subplot(3,2,5);
data=[0.894 0.6923 0.75;0.821 0.8 0.75];
bar(data);
legend('全天','早高峰','晚高峰');
xlabel('日期');
ylabel('准点率');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'上行','下行'});
title('9月10日班次平均出发准点率');