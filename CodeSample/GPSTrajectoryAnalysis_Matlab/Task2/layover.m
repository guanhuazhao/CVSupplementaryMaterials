%��������
[num,text,raw]=xlsread('0907s.xlsx');
datas=num;
len_datas=length(datas);
[num,text,raw]=xlsread('0907x.xlsx');
datax=num;
len_datax=length(datax);
%1Ϊ������� 2kong 3ʱ�� 45��γ�� 6flag 
%��¼��ÿ���������뵽����վ��ʱ��  �����뵽�︱վ��ʱ��
%���з������վflagΪ1 ��վflagΪ2
%���з������վflagΪ2 ��վflagΪ1
ks=0;
kx=0;
%zhu fu 1Ϊ������� 2kong 3ʱ�� 45��γ�� 6flag 
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
%ʹzhu fu���ݳ���������򣬹�13����
%��������복�ƺŶ�Ӧ��ϵ�ͱ�3.1��ͬ
sortrows(zhu,1);
sortrows(fu,1);
%��������Ϊһ�����ʱ��� ��min��
%������Ҫ����˾��������վ����Ϣʱ�䣬���ÿ���������ӵڶ������ݿ�ʼ����
%�����д����ֵ 1λ���� 3Ϊʱ��
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


%��ͼ
figure;
sz1=linspace(1,100,length(zhu(:,7)));%�ı�ԲȦ�ߴ�
scatter(zhu(:,3),zhu(:,1),sz1,'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','��A-08706D','��A-00576D','��A-00577D','��A-01202D','��A-01339D',...
    '��A-01722D','��A-01880D','��A-01976D','��A-03593D','��A-07360D','��A-07695D','��A-09169D','��A-09359D'});
ylabel('�������ƺ�');
title('9��6�� �ζ�104·���� ��վ�����³�վ LAYOVERʱ��ͼ');
datetick('x',13);

figure;
sz2=linspace(1,100,length(fu(:,7)));%�ı�ԲȦ�ߴ�
scatter(fu(:,3),fu(:,1),sz2,'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','��A-08706D','��A-00576D','��A-00577D','��A-01202D','��A-01339D',...
    '��A-01722D','��A-01880D','��A-01976D','��A-03593D','��A-07360D','��A-07695D','��A-09169D','��A-09359D'});
ylabel('�������ƺ�');
title('9��6�� �ζ�104·���� ��վ����亳�վ LAYOVERʱ��ͼ');
datetick('x',13);



%%%%%%%%%�����￪ʼ
[num,text,raw]=xlsread('layover.xlsx','zhu');
zhu=num;

[num,text,raw]=xlsread('layover.xlsx','fu');
fu=num;


%��ͼ  1���� 23ʱ�� 4cha
figure;
time(:,1)=(zhu(:,2)+zhu(:,3))/2;
scatter(time(:,1),zhu(:,1),zhu(:,4)*20,'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
set(gca,'XLim',[5*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','��A-08706D','��A-00576D','��A-00577D','��A-01202D','��A-01339D',...
    '��A-01722D','��A-01880D','��A-01976D','��A-03593D','��A-07360D','��A-07695D','��A-09169D','��A-09359D'});
ylabel('�������ƺ�');
title('9��6�� �ζ�104·���� ��վ�����³�վ LAYOVERʱ��ͼ');
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
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
set(gca,'XLim',[5*1/24 23/24]);
set(gca,'YLim',[0 14]);
set(gca,'YTick',[0:1:14]);
set(gca,'YTickLabel',{'','��A-08706D','��A-00576D','��A-00577D','��A-01202D','��A-01339D',...
    '��A-01722D','��A-01880D','��A-01976D','��A-03593D','��A-07360D','��A-07695D','��A-09169D','��A-09359D'});
ylabel('�������ƺ�');
title('9��6�� �ζ�104·���� ��վ����亳�վ LAYOVERʱ��ͼ');
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
set(gca,'XTickLabel',{'��A-08706D','��A-00576D','��A-00577D','��A-01202D','��A-01339D',...
    '��A-01722D','��A-01880D','��A-01976D','��A-03593D','��A-07360D','��A-07695D','��A-09169D','��A-09359D'});
xlabel('�������ƺ�');
ylabel('ƽ����Ϣʱ��/min');
title('9��6�� �ζ�104·���� ��������վ ������ƽ����Ϣʱ��');
legend('��վ����','��վ����');


bar(x,yave);
set(gca,'XTickLabel',{'��A-08706D','��A-00576D','��A-00577D','��A-01202D','��A-01339D',...
    '��A-01722D','��A-01880D','��A-01976D','��A-03593D','��A-07360D','��A-07695D','��A-09169D','��A-09359D'});
xlabel('�������ƺ�');
ylabel('ƽ����Ϣʱ��/min');
title('9��6�� �ζ�104·���� ������ƽ����Ϣʱ��');