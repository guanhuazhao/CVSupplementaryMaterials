%%计算每日标准发车间隔
%读入数据
[num,text,raw]=xlsread('tt06s.xlsx');
tt06s=num(:,1);
len_06s=length(tt06s);
[num,text,raw]=xlsread('tt06x.xlsx');
tt06x=num(:,1);
len_06x=length(tt06x);
[num,text,raw]=xlsread('tt07s.xlsx');
tt07s=num(:,1);
len_07s=length(tt07s);
[num,text,raw]=xlsread('tt07x.xlsx');
tt07x=num(:,1);
len_07x=length(tt07x);
[num,text,raw]=xlsread('tt08s.xlsx');
tt08s=num(:,1);
len_08s=length(tt08s);
[num,text,raw]=xlsread('tt08x.xlsx');
tt08x=num(:,1);
len_08x=length(tt08x);
[num,text,raw]=xlsread('tt09s.xlsx');
tt09s=num(:,1);
len_09s=length(tt09s);
[num,text,raw]=xlsread('tt09x.xlsx');
tt09x=num(:,1);
len_09x=length(tt09x);
[num,text,raw]=xlsread('tt10s.xlsx');
tt10s=num(:,1);
len_10s=length(tt10s);
[num,text,raw]=xlsread('tt10x.xlsx');
tt10x=num(:,1);
len_10x=length(tt10x);
%计算间隔,储存在ttdates/x的第二列
for i= 1:len_06s-1
    tt06s(i,2)=(tt06s(i+1,1)-tt06s(i,1))*1440;%min
end
for i= 1:len_06x-1
    tt06x(i,2)=(tt06x(i+1,1)-tt06x(i,1))*1440;%min
end
for i= 1:len_07s-1
    tt07s(i,2)=(tt07s(i+1,1)-tt07s(i,1))*1440;%min
end
for i= 1:len_07x-1
    tt07x(i,2)=(tt07x(i+1,1)-tt07x(i,1))*1440;%min
end
for i= 1:len_08s-1
    tt08s(i,2)=(tt08s(i+1,1)-tt08s(i,1))*1440;%min
end
for i= 1:len_08x-1
    tt08x(i,2)=(tt08x(i+1,1)-tt08x(i,1))*1440;%min
end    
for i= 1:len_09s-1
    tt09s(i,2)=(tt09s(i+1,1)-tt09s(i,1))*1440;%min
end
for i= 1:len_09x-1
    tt09x(i,2)=(tt09x(i+1,1)-tt09x(i,1))*1440;%min
end
for i= 1:len_10s-1
    tt10s(i,2)=(tt10s(i+1,1)-tt10s(i,1))*1440;%min
end
for i= 1:len_10x-1
    tt10x(i,2)=(tt10x(i+1,1)-tt10x(i,1))*1440;%min
end    
%计算每天上行与下行方向的实际发车间隔
%读取数据，
%由于之前的处理中已经将起始站的出站行数据flag标为1，
%因此这里只需要对flag=1的数据进行计算
[num,text,raw]=xlsread('06s.xlsx');
data=num;
len_data=length(data);
k_6s=0;%对进站点进行统计，列为新表格
data_06s=zeros(len_06s,2);
for i= 1:len_data
    if flag(i,1)==1
        k_6s=k_6s+1;
        data_06s(i,1)=data(i,1);%将起始站出站点时间储存在表格中
    end
end
%计算实际时间差
for i = 1:len_06s-1
    data_06s(i,2)=(data_06s(i+1,1)-data_06s(i,1))*1440;%min
end
xlswrite('tt06s_new.xlsx',tt06s);
xlswrite('tt06x_new.xlsx',tt06x);
xlswrite('tt07s_new.xlsx',tt07s);
xlswrite('tt07x_new.xlsx',tt07x);
xlswrite('tt08s_new.xlsx',tt08s);
xlswrite('tt08x_new.xlsx',tt08x);
xlswrite('tt09s_new.xlsx',tt09s);
xlswrite('tt09x_new.xlsx',tt09x);
xlswrite('tt10s_new.xlsx',tt10s);
xlswrite('tt10x_new.xlsx',tt10x);
%读取数据
%绘图,规定间隔画蓝色，实际间隔画红色
%6
figure;
subplot(1,2,1);
plot(tt06s(:,1),tt06s(:,2),'b');
hold on;
plot(data_06s(:,1),data_06s(:,2),'r');
xlabel('时间');
ylabel('发车间隔/min');
title('嘉定104路 9月6日 上行方向 发车间隔分析');
legend('计划发车间隔','发车间隔');
datetick('x',13);
subplot(1,2,2);
plot(tt06x(:,1),tt06x(:,2),'b');
hold on;
plot(data_06x(:,1),data_06x(:,2),'r');
xlabel('时间');
ylabel('与时刻表偏差/min');
title('嘉定104路 9月6日 下行方向 发车间隔分析');
legend('计划发车间隔','发车间隔');
datetick('x',13);
