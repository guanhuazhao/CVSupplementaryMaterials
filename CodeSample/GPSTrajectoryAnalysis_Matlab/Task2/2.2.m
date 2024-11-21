[num,text,raw]=xlsread('s.xlsx');
temp_s=num;
len_s=length(temp_s);
[num,text,raw]=xlsread('x.xlsx');
temp_x=num;
len_x=length(temp_x);

%1Ϊ����ID����13���� 2kong 3ʱ�� 45��γ��
bus_num=13;
%��ͼ
figure;
scatter(temp_s(:,3),temp_s(:,1),1,'b','.');
hold on
scatter(temp_x(:,3),temp_x(:,1),1,'r','.');
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','��A-08706D','��A-00576D','��A-00577D','��A-01202D','��A-01339D','��A-01722D','��A-01880D','��A-01976D','��A-03593D','��A-07360D','��A-07695D','��A-09169D','��A-09359D'});
ylabel('�������ƺ�');
title('9��7�ռζ�104·��������ʹ�����');
label('����','����');

%׼����
[num,text,raw]=xlsread('timetable_s.xlsx');
timetable_s=num;

   %��timetable���棬��һ��Ϊ���ƺţ���45Ϊ���������ʱ�̱�ʱ�䣬67Ϊ������һ�����Ӧʱ��,89Ϊ������һ����Ķ�Ӧʱ��
    len=length(timetable);
    %timetable��һ��Ϊ������ţ�����Ϊ��������ʱ�̱�
    for i = 1: len
       chufa=timetable(i,4);
       daoda=timetable(i,5);
       %0~1=0~86400s
       %1min=1/1440
       %��1
       timetable(i,6)=chufa-1/1440;
       timetable(i,8)=daoda-1/1440;
       %��2
       timetable(i,7)=chufa+2/1440;
       timetable(i,9)=daoda+2/1440;
    end
    
    %�ú����ж��Ƿ�׼�㣬����׼���� ������zhundianlv.xlsx��
[num,text,raw]=xlsread('zhundianlv.xlsx');
zhundianlv=num;
    %��ĩ�೵������
figure;
data=[1 0;0.5 0;1 0;1 0;0.5 0];

bar(data);
legend('����','����');
xlabel('����');
ylabel('׼����');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'9��6��','9��7��','9��8��','9��9��','9��10��'});
title('��ĩ��������׼����');

%ȫ��������߷�
figure;
subplot(3,2,1);
data=[0.8636 0.3846 1;0.806 0.8 0.92];
bar(data);
legend('ȫ��','��߷�','��߷�');
xlabel('����');
ylabel('׼����');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'����','����'});
title('9��6�հ��ƽ������׼����');

subplot(3,2,2);
data=[0.9394 0.7692 0.92;0.8507 0.8 0.92];
bar(data);
legend('ȫ��','��߷�','��߷�');
xlabel('����');
ylabel('׼����');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'����','����'});
title('9��7�հ��ƽ������׼����');

subplot(3,2,3);
data=[0.9394 0.7692 0.92;0.8955 0.8 0.92];
bar(data);
legend('ȫ��','��߷�','��߷�');
xlabel('����');
ylabel('׼����');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'����','����'});
title('9��8�հ��ƽ������׼����');

subplot(3,2,4);
data=[0.9545 0.6923 0.92;0.8507 0.7333 0.92];
bar(data);
legend('ȫ��','��߷�','��߷�');
xlabel('����');
ylabel('׼����');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'����','����'});
title('9��9�հ��ƽ������׼����');

subplot(3,2,5);
data=[0.894 0.6923 0.75;0.821 0.8 0.75];
bar(data);
legend('ȫ��','��߷�','��߷�');
xlabel('����');
ylabel('׼����');
set(gca,'YLim',[0 1.1]);
% set(gca,'YTick',[0:10:1.1]);
% set(gca,'YTickLabel',{'0','0.5','1'});
set(gca,'XTickLabel',{'����','����'});
title('9��10�հ��ƽ������׼����');