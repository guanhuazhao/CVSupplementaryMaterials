%以上行为例
[num,text,raw]=xlsread('0910s.xlsx');
data=num;
len=length(data);


%3.1中已经计算了站点之间的行程时间,其中将每个站点的进站出站属性标记在12列 值=0时为进站点 2列是停靠的站点编号
b=zeros(24,1);%b记录站点经过次数
a=zeros(24,75);%a记录每个站点每趟公交经过的时刻
%统计10号每个站点的公交车进站时刻
for i =1:len
    if data(i,12)==0 %是进站点
        m=data(i,2);%记录站点编号；
        b(m,1)=b(m,1)+1;%某站点的第b（m,1）次时刻
        a(m,b(m,1))=data(i,1);%将时间记录在对应编号后；
    end
end
%某站点的车间时距 相邻公交的进站时刻 相减 得到 
%对a中每一行进行排序，方便计算
sort(a);
%用time_gap计算车间时距，time_gap的有效列数为a的列数-1
time_gap=zeros(24,74);
for i=1:74
    time_gap(:,i)=a(:,i+1)-a(:,i);
end
%对time_gap转置 方便绘图boxplot
time_gap=time_gap';
x1=time_gap(1,1:b(1,1)-1);
x2=time_gap(2,1:b(2,1)-1);
x3=time_gap(3,1:b(3,1)-1);
x4=time_gap(4,1:b(4,1)-1);
x5=time_gap(5,1:b(5,1)-1);
x6=time_gap(6,1:b(6,1)-1);
x7=time_gap(7,1:b(7,1)-1);
x8=time_gap(8,1:b(8,1)-1);
x9=time_gap(9,1:b(9,1)-1);
x10=time_gap(10,1:b(10,1)-1);
x12=time_gap(12,1:b(12,1)-1);
x11=time_gap(11,1:b(11,1)-1);
x13=time_gap(13,1:b(13,1)-1);
x14=time_gap(14,1:b(14,1)-1);
x15=time_gap(15,1:b(15,1)-1);
x16=time_gap(16,1:b(16,1)-1);
x17=time_gap(17,1:b(17,1)-1);
x18=time_gap(18,1:b(18,1)-1);
x19=time_gap(19,1:b(19,1)-1);
x20=time_gap(20,1:b(20,1)-1);
x21=time_gap(21,1:b(21,1)-1);
x22=time_gap(22,1:b(22,1)-1);
x23=time_gap(23,1:b(23,1)-1);
x24=time_gap(24,1:b(24,1)-1);

%绘制箱型图 不绘制起点站与终点站
[num,text,raw]=xlsread('boxplot.xlsx','s');
data=num;
len=length(data);

figure;
boxplot([x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23]);
xlabel('站点编号')

ylabel('站点车间时距/min');
title('9月10日 嘉定104路公交 上行 各站点车间时距')


%从这里开始
subplot(1,2,1);
[num,text,raw]=xlsread('boxplot.xlsx','s');
data_s=num';
boxplot(data_s(2:6,:),'Labels', {'2', '3', '4', '5', '6', '7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23'});
xlabel('站点编号')
ylabel('站点车间时距/min');
title('9月10日 嘉定104路公交 上行 各站点车间时距')
set(gca,'YLim',[-3 43]);
subplot(1,2,2);
[num,text,raw]=xlsread('boxplot.xlsx','x');
data_x=num';
boxplot(data_x(2:6,:),'Labels', {'2', '3', '4', '5', '6', '7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23'});
set(gca,'YLim',[-3 43]);
xlabel('站点编号')
ylabel('站点车间时距/min');
title('9月10日 嘉定104路公交 下行 各站点车间时距')