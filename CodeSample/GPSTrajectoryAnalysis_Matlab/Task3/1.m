%������Ϊ��
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
%%��ͼ
figure;
%sz
x=data(:,1);
y1=data(:,2);
y2=data(:,3);
y3=data(:,4);

subplot(1,2,1);

yyaxis left;%������ߵ���
c=bar(y3,'FaceColor',...
    [0.941176470588235,0.972549019607843,1]);
set(gca,'YLim',[0 1]);
set(c,'edgecolor','none');%��״ͼ�ޱ߿�
ylabel('����ռ��');

yyaxis right;%�����ұߵ���
plot(x,y1,'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
hold on ;
plot(x,y2,'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
ylabel('ʱ��/min');

xlabel('·�α��');
title('9��10�� ���� ��߷� ·���г�ʱ�估����');
legend('ƽ������ռ��','ƽ������','ƽ����Ӫʱ��');
set(gca,'XLim',[0 24]);
set(gca,'XTick',[0:1:24]);
%sw
x=data(:,1);
y1=data(:,5);
y2=data(:,6);
y3=data(:,7);

subplot(1,2,2);

yyaxis left;%������ߵ���
c=bar(y3,'FaceColor',...
    [0.941176470588235,0.972549019607843,1]);
set(gca,'YLim',[0 1]);
set(c,'edgecolor','none');%��״ͼ�ޱ߿�
ylabel('����ռ��');

yyaxis right;%�����ұߵ���
plot(x,y1,'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
hold on ;
plot(x,y2,'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
ylabel('ʱ��/min');

xlabel('·�α��');
title('9��10�� ���� ��߷� ·���г�ʱ�估����');
legend('ƽ������ռ��','ƽ������','ƽ����Ӫʱ��');
set(gca,'XLim',[0 24]);
set(gca,'XTick',[0:1:24]);


%%%%%%%%����
figure;
%sz
x=data(1:23,1);
y1=data(1:23,8);
y2=data(1:23,9);
y3=data(1:23,10);
subplot(1,2,1);

yyaxis left;%������ߵ���
c=bar(y3,'FaceColor',...
    [0.941176470588235,0.972549019607843,1]);
set(gca,'YLim',[0 1]);
set(c,'edgecolor','none');%��״ͼ�ޱ߿�
ylabel('����ռ��');

yyaxis right;%�����ұߵ���
plot(x,y1,'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
hold on ;
plot(x,y2,'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
ylabel('ʱ��/min');

xlabel('·�α��');
title('9��10�� ���� ��߷� ·���г�ʱ�估����');
legend('ƽ������ռ��','ƽ������','ƽ����Ӫʱ��');
set(gca,'XLim',[0 24]);
set(gca,'XTick',[0:1:24]);
%sw
x=data(1:23,1);
y1=data(1:23,11);
y2=data(1:23,12);
y3=data(1:23,13);

subplot(1,2,2);

yyaxis left;%������ߵ���
c=bar(y3,'FaceColor',...
    [0.941176470588235,0.972549019607843,1]);
set(gca,'YLim',[0 1]);
set(c,'edgecolor','none');%��״ͼ�ޱ߿�
ylabel('����ռ��');

yyaxis right;%�����ұߵ���
plot(x,y1,'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
hold on ;
plot(x,y2,'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
ylabel('ʱ��/min');

xlabel('·�α��');
title('9��10�� ���� ��߷� ·���г�ʱ�估����');
legend('ƽ������ռ��','ƽ������','ƽ����Ӫʱ��');
set(gca,'XLim',[0 24]);
set(gca,'XTick',[0:1:24]);
