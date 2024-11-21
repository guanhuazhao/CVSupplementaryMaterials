%读入数据
[num,text,raw]=xlsread('0907s.xlsx');
datas=num;
len_datas=length(datas);
[num,text,raw]=xlsread('0907x.xlsx');
datax=num;
len_datax=length(datax);
%1为车辆编号 2kong 3时间 45经纬度 6flag 
%记录下每辆车出发与到达主站的时间  出发与到达副站的时间
%上行方向的主站flag为1 副站flag为2
%下行方向的主站flag为2 副站flag为1
ks=0;
kx=0;
%zhu fu 1为车辆编号 2kong 3时间 45经纬度 6flag 
zhu=zeros(150,9);
fu=zeros(150,9);
for i= 1:len_datas
    if datas(i,6)==1 
       ks=ks+1;
       zhu(ks,:)=datas(i,:);
    else if datas(i,6)==2
            kx=kx+1;
            fu(kx,:)=datas(i,:);
        end
    end
end
for i= 1:len_datax
    if datax(i,6)==2 
       ks=ks+1;
       zhu(ks,:)=datas(i,:);
    else if datax(i,6)==1
            kx=kx+1;
            fu(kx,:)=datas(i,:);
        end
    end
end        
%使zhu fu根据车辆编号排序，共13辆车
%车辆编号与车牌号对应关系和表3.1相同
sortrows(zhu,1);
sortrows(fu,1);
%两个数据为一组计算时间差 （min）
%由于是要计算司机在主副站的休息时间，因此每辆公交车从第二个数据开始计算
%第七列储存差值 1位车牌 3为时间
m=length(zhu);
n=length(fu);
for i =2:m
    if zhu(i-1,1)==zhu(i,1)
        zhu(i,7)=(zhu(i,3)-zhu(i-1,3))*1440;%min
    end    
end
for i =2:n
    if fu(i-1,1)==fu(i,1)
        fu(i,7)=(fu(i,3)-fu(i-1,3))*1440;%min
    end    
end


%绘图
figure;
sz1=linspace(1,100,length(zhu(:,7)));%改变圆圈尺寸
scatter(zhu(:,3),zhu(:,1),sz1,'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','沪A-08706D','沪A-00576D','沪A-00577D','沪A-01202D','沪A-01339D',...
    '沪A-01722D','沪A-01880D','沪A-01976D','沪A-03593D','沪A-07360D','沪A-07695D','沪A-09169D','沪A-09359D'});
ylabel('公交车牌号');
title('9月6日 嘉定104路公交 主站：真新车站 LAYOVER时间图');
datetick('x',13);

figure;
sz2=linspace(1,100,length(fu(:,7)));%改变圆圈尺寸
scatter(fu(:,3),fu(:,1),sz2,'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','沪A-08706D','沪A-00576D','沪A-00577D','沪A-01202D','沪A-01339D',...
    '沪A-01722D','沪A-01880D','沪A-01976D','沪A-03593D','沪A-07360D','沪A-07695D','沪A-09169D','沪A-09359D'});
ylabel('公交车牌号');
title('9月6日 嘉定104路公交 副站：封浜车站 LAYOVER时间图');
datetick('x',13);



%%%%%%%%%从这里开始
[num,text,raw]=xlsread('layover.xlsx','zhu');
zhu=num;

[num,text,raw]=xlsread('layover.xlsx','fu');
fu=num;


%绘图  1车号 23时间 4cha
figure;
time(:,1)=(zhu(:,2)+zhu(:,3))/2;
scatter(time(:,1),zhu(:,1),zhu(:,4)*20,'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
set(gca,'XLim',[5*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','沪A-08706D','沪A-00576D','沪A-00577D','沪A-01202D','沪A-01339D',...
    '沪A-01722D','沪A-01880D','沪A-01976D','沪A-03593D','沪A-07360D','沪A-07695D','沪A-09169D','沪A-09359D'});
ylabel('公交车牌号');
title('9月6日 嘉定104路公交 主站：真新车站 LAYOVER时间图');
datetick('x',13);


time1(:,1)=(fu(:,2)+fu(:,3))/2;
figure;
for i = 1:61
    if fu(i,4)~=0
        scatter(time1(i,1),fu(i,1),fu(i,4)*10,'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
         hold on;
    else
         scatter(time1(i,1),fu(i,1),'*','r');
         hold on;
    end
end

% scatter(time1(:,1),fu(:,1),fu(:,4)*20,'MarkerFaceColor','r','MarkerEdgeColor','r',...
%     'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
set(gca,'XLim',[5*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','沪A-08706D','沪A-00576D','沪A-00577D','沪A-01202D','沪A-01339D',...
    '沪A-01722D','沪A-01880D','沪A-01976D','沪A-03593D','沪A-07360D','沪A-07695D','沪A-09169D','沪A-09359D'});
ylabel('公交车牌号');
title('9月6日 嘉定104路公交 副站：封浜车站 LAYOVER时间图');
datetick('x',13);

%
[num,text,raw]=xlsread('layover.xlsx','avezhu');
avezhu=num;

[num,text,raw]=xlsread('layover.xlsx','avefu');
avefu=num;

x=avezhu(:,1)';
y1=avezhu(:,2)';
y2=avefu(:,2)';
y=[y1;y2]';
yave=(y1+y2)/2;
yave=yave';

bar(x,y);
set(gca,'XTickLabel',{'沪A-08706D','沪A-00576D','沪A-00577D','沪A-01202D','沪A-01339D',...
    '沪A-01722D','沪A-01880D','沪A-01976D','沪A-03593D','沪A-07360D','沪A-07695D','沪A-09169D','沪A-09359D'});
xlabel('公交车牌号');
ylabel('平均休息时间/min');
title('9月6日 嘉定104路公交 主、副车站 各车辆平均休息时间');
legend('主站车辆','副站车辆');


bar(x,yave);
set(gca,'XTickLabel',{'沪A-08706D','沪A-00576D','沪A-00577D','沪A-01202D','沪A-01339D',...
    '沪A-01722D','沪A-01880D','沪A-01976D','沪A-03593D','沪A-07360D','沪A-07695D','沪A-09169D','沪A-09359D'});
xlabel('公交车牌号');
ylabel('平均休息时间/min');
title('9月6日 嘉定104路公交 各车辆平均休息时间');