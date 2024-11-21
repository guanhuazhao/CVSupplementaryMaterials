[num,text,raw]=xlsread('tingkao.xlsx');
data=num;
len=length(data);


%3.1���Ѿ�������վ��֮����г�ʱ��,���н�ÿ��վ��Ľ�վ��վ���Ա����12�У��������data��13����

%������ȡ�켣�еĽ���վ�㣬������Ϊ��
jin=zeors(len,12);
chu=zeros(len,12);
k_jin=0;
k_chu=0;
a=zeros(24,80);
for i =1:len
    if data(i,12)==0 %�ǽ�վ��
        k_jin=k_jin+1;
        jin(k_jin,:)=data(i,12);
    else if data(i,12)==1 %�ǳ�վ��
         k_chu=k_chu+1;
        chu(k_chu,:)=data(i,12);   
        end
    end
end

%����ÿ��վ���ͣ��ʱ��
tingkao=zeros(k_jin,2);
tingkao(:,1)=chu(:,1)-jin(:,1);%1�д���ʱ�� 2�д���վ��
tingkao(:,2)=chu(:,3);
len_tk=length(tingkao);
%a1����������ÿ��վ���ͣ������ ����ÿ�д���һ��ͣ��ʱ��
for i=1:len_tk
    m=tingkao(i,2)%�õ����ĸ�վ��;
    a(m,1)=a(m,1)+1;
    a(m,a(m,1)+1)=tingkao(i,1);
end        
%����10������ÿ��վ��ƽ��ͣ��ʱ��
for i=1:24
    data(i,1)=i;
    data(i,2)=average(a(i,2):a(i,1));
end
%������data�� 1վ�� 2����ƽ��ͣ��ʱ�� 
%����ͬ��3������ƽ��ͣ��ʱ��
%10�ŷֱ���78��77�������й켣

%��ͼ
figure;
%s
plot(data(:,1),data(:,2),'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
hold on;
%x
plot(data(:,1),data(:,3),'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
ylabel('ʱ��/s');
xlabel('վ��');
title('�ζ�104·���� 9��10�� ��/���� վ��ƽ��ͣ��ʱ��');
legend('����վ��ƽ��ͣ��ʱ��','����վ��ƽ��ͣ��ʱ��');
set(gca,'XLim',[0 25]);
set(gca,'XTick',[0:1:25]);
set(gca,'YLim',[0 110]);

figure;
%s
plot(data(:,1),data(:,2),'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
hold on;
%x
plot(data(:,1),data(:,4),'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%�����������
ylabel('ʱ��/s');
xlabel('վ��');
title('�ζ�104·���� 9��10�� ��/���� վ��ƽ��ͣ��ʱ��');
legend('����վ��ƽ��ͣ��ʱ��','����վ��ƽ��ͣ��ʱ��');
set(gca,'XLim',[0 25]);
set(gca,'XTick',[0:1:25]);
set(gca,'YLim',[0 110]); 


%3��վ
[num,text,raw]=xlsread('tingkao.xlsx');
data=num;
len=length(data);

a=[100 118 144 65 118 180 65 65 128 10];
aver=mean(a);
b=[0.399305555555556 0.413194444444444 0.447222222222222 0.472222222222222 0.638888888888889 0.673611111111111 0.684027777777778 0.732638888888889 0.763888888888889 0.857638888888889];
plot(b,a);
ylabel('ʱ��/s');
xlabel('ʱ��');
title('�ζ�104·���� 9��10�� 3��վ ���� ͣ��ʱ����ʱ��仯����ͼ');
datetick('x',13);