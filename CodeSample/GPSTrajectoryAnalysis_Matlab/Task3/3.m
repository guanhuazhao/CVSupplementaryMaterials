%������Ϊ��
[num,text,raw]=xlsread('0910s.xlsx');
data=num;
len=length(data);


%3.1���Ѿ�������վ��֮����г�ʱ��,���н�ÿ��վ��Ľ�վ��վ���Ա����12�� ֵ=0ʱΪ��վ�� 2����ͣ����վ����
b=zeros(24,1);%b��¼վ�㾭������
a=zeros(24,75);%a��¼ÿ��վ��ÿ�˹���������ʱ��
%ͳ��10��ÿ��վ��Ĺ�������վʱ��
for i =1:len
    if data(i,12)==0 %�ǽ�վ��
        m=data(i,2);%��¼վ���ţ�
        b(m,1)=b(m,1)+1;%ĳվ��ĵ�b��m,1����ʱ��
        a(m,b(m,1))=data(i,1);%��ʱ���¼�ڶ�Ӧ��ź�
    end
end
%ĳվ��ĳ���ʱ�� ���ڹ����Ľ�վʱ�� ��� �õ� 
%��a��ÿһ�н������򣬷������
sort(a);
%��time_gap���㳵��ʱ�࣬time_gap����Ч����Ϊa������-1
time_gap=zeros(24,74);
for i=1:74
    time_gap(:,i)=a(:,i+1)-a(:,i);
end
%��time_gapת�� �����ͼboxplot
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

%��������ͼ ���������վ���յ�վ
[num,text,raw]=xlsread('boxplot.xlsx','s');
data=num;
len=length(data);

figure;
boxplot([x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23]);
xlabel('վ����')

ylabel('վ�㳵��ʱ��/min');
title('9��10�� �ζ�104·���� ���� ��վ�㳵��ʱ��')


%�����￪ʼ
subplot(1,2,1);
[num,text,raw]=xlsread('boxplot.xlsx','s');
data_s=num';
boxplot(data_s(2:6,:),'Labels', {'2', '3', '4', '5', '6', '7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23'});
xlabel('վ����')
ylabel('վ�㳵��ʱ��/min');
title('9��10�� �ζ�104·���� ���� ��վ�㳵��ʱ��')
set(gca,'YLim',[-3 43]);
subplot(1,2,2);
[num,text,raw]=xlsread('boxplot.xlsx','x');
data_x=num';
boxplot(data_x(2:6,:),'Labels', {'2', '3', '4', '5', '6', '7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23'});
set(gca,'YLim',[-3 43]);
xlabel('վ����')
ylabel('վ�㳵��ʱ��/min');
title('9��10�� �ζ�104·���� ���� ��վ�㳵��ʱ��')