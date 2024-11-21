[num,text,raw]=xlsread('tingkao.xlsx');
data=num;
len=length(data);


%3.1中已经计算了站点之间的行程时间,其中将每个站点的进站出站属性标记在12列，标记在了data的13列中

%计算提取轨迹中的进出站点，以上行为例
jin=zeors(len,12);
chu=zeros(len,12);
k_jin=0;
k_chu=0;
a=zeros(24,80);
for i =1:len
    if data(i,12)==0 %是进站点
        k_jin=k_jin+1;
        jin(k_jin,:)=data(i,12);
    else if data(i,12)==1 %是出站点
         k_chu=k_chu+1;
        chu(k_chu,:)=data(i,12);   
        end
    end
end

%计算每个站点的停靠时间
tingkao=zeros(k_jin,2);
tingkao(:,1)=chu(:,1)-jin(:,1);%1列储存时间 2列储存站号
tingkao(:,2)=chu(:,3);
len_tk=length(tingkao);
%a1列用来储存每个站点的停靠次数 后面每列储存一个停靠时间
for i=1:len_tk
    m=tingkao(i,2)%得到是哪个站点;
    a(m,1)=a(m,1)+1;
    a(m,a(m,1)+1)=tingkao(i,1);
end        
%计算10号上行每个站点平均停靠时间
for i=1:24
    data(i,1)=i;
    data(i,2)=average(a(i,2):a(i,1));
end
%储存在data中 1站点 2上行平均停靠时间 
%下行同理，3列下行平均停靠时间
%10号分别有78与77个上下行轨迹

%绘图
figure;
%s
plot(data(:,1),data(:,2),'color',...
    [0.415686274509804,0.352941176470588,0.803921568627451]);
hold on;
%x
plot(data(:,1),data(:,3),'color',...
    [0.627450980392157,0.321568627450980,0.176470588235294]);
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
ylabel('时间/s');
xlabel('站点');
title('嘉定104路公交 9月10日 上/下行 站点平均停靠时间');
legend('上行站点平均停靠时间','下行站点平均停靠时间');
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
grid on;set(gca,'GridLineStyle',':','GridColor','b','GridAlpha',1);%添加网格虚线
ylabel('时间/s');
xlabel('站点');
title('嘉定104路公交 9月10日 上/下行 站点平均停靠时间');
legend('上行站点平均停靠时间','下行站点平均停靠时间');
set(gca,'XLim',[0 25]);
set(gca,'XTick',[0:1:25]);
set(gca,'YLim',[0 110]); 


%3号站
[num,text,raw]=xlsread('tingkao.xlsx');
data=num;
len=length(data);

a=[100 118 144 65 118 180 65 65 128 10];
aver=mean(a);
b=[0.399305555555556 0.413194444444444 0.447222222222222 0.472222222222222 0.638888888888889 0.673611111111111 0.684027777777778 0.732638888888889 0.763888888888889 0.857638888888889];
plot(b,a);
ylabel('时间/s');
xlabel('时间');
title('嘉定104路公交 9月10日 3号站 下行 停靠时间随时间变化折线图');
datetick('x',13);