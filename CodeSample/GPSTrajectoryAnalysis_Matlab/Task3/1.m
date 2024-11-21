%以上行为例
[num,text,raw]=xlsread('data.xlsx');
data=num;
len=length(data);
for i = 1:len
data(i,4)=data(i,2)/data(i,3);
data(i,7)=data(i,5)/data(i,6);
data(i,10)=data(i,8)/data(i,9);
data(i,13)=data(i,11)/data(i,12);
end
xlswrite('data.xlsx',data);

data(24,:)=0;
%%绘图
figure;
%sz
x=data(:,1);
y1=data(:,2);
y2=data(:,3);
y3=data(:,4);

subplot(1,2,1);

yyaxis left;%激活左边的轴
c=bar(y3,'FaceColor',...
    [0.941176470588235,0.972549019607843,1]);
set(gca,'YLim',[0 1]);
set(c,'edgecolor','none');%柱状图无边框
ylabel('延误占比');

yyaxis right;%激活右边的轴
plot(x,y1,'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
hold on ;
plot(x,y2,'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
ylabel('时间/min');

xlabel('路段编号');
title('9月10日 上行 早高峰 路段行程时间及延误');
legend('平均延误占比','平均延误','平均运营时间');
set(gca,'XLim',[0 24]);
set(gca,'XTick',[0:1:24]);
%sw
x=data(:,1);
y1=data(:,5);
y2=data(:,6);
y3=data(:,7);

subplot(1,2,2);

yyaxis left;%激活左边的轴
c=bar(y3,'FaceColor',...
    [0.941176470588235,0.972549019607843,1]);
set(gca,'YLim',[0 1]);
set(c,'edgecolor','none');%柱状图无边框
ylabel('延误占比');

yyaxis right;%激活右边的轴
plot(x,y1,'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
hold on ;
plot(x,y2,'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
ylabel('时间/min');

xlabel('路段编号');
title('9月10日 上行 晚高峰 路段行程时间及延误');
legend('平均延误占比','平均延误','平均运营时间');
set(gca,'XLim',[0 24]);
set(gca,'XTick',[0:1:24]);


%%%%%%%%下行
figure;
%sz
x=data(1:23,1);
y1=data(1:23,8);
y2=data(1:23,9);
y3=data(1:23,10);
subplot(1,2,1);

yyaxis left;%激活左边的轴
c=bar(y3,'FaceColor',...
    [0.941176470588235,0.972549019607843,1]);
set(gca,'YLim',[0 1]);
set(c,'edgecolor','none');%柱状图无边框
ylabel('延误占比');

yyaxis right;%激活右边的轴
plot(x,y1,'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
hold on ;
plot(x,y2,'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
ylabel('时间/min');

xlabel('路段编号');
title('9月10日 下行 早高峰 路段行程时间及延误');
legend('平均延误占比','平均延误','平均运营时间');
set(gca,'XLim',[0 24]);
set(gca,'XTick',[0:1:24]);
%sw
x=data(1:23,1);
y1=data(1:23,11);
y2=data(1:23,12);
y3=data(1:23,13);

subplot(1,2,2);

yyaxis left;%激活左边的轴
c=bar(y3,'FaceColor',...
    [0.941176470588235,0.972549019607843,1]);
set(gca,'YLim',[0 1]);
set(c,'edgecolor','none');%柱状图无边框
ylabel('延误占比');

yyaxis right;%激活右边的轴
plot(x,y1,'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
hold on ;
plot(x,y2,'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
ylabel('时间/min');

xlabel('路段编号');
title('9月10日 下行 晚高峰 路段行程时间及延误');
legend('平均延误占比','平均延误','平均运营时间');
set(gca,'XLim',[0 24]);
set(gca,'XTick',[0:1:24]);
