%�����׼��Ӫʱ��
[num,text,raw]=xlsread('tt06s.xlsx');
tt06s=num(:,1:2);
len_06s=length(tt06s);
[num,text,raw]=xlsread('tt06x.xlsx');
tt06x=num(:,1:2);
len_06x=length(tt06x);
[num,text,raw]=xlsread('tt07s.xlsx');
tt07s=num(:,1:2);
len_07s=length(tt07s);
[num,text,raw]=xlsread('tt07x.xlsx');
tt07x=num(:,1:2);
len_07x=length(tt07x);
[num,text,raw]=xlsread('tt08s.xlsx');
tt08s=num(:,1:2);
len_08s=length(tt08s);
[num,text,raw]=xlsread('tt08x.xlsx');
tt08x=num(:,1:2);
len_08x=length(tt08x);
[num,text,raw]=xlsread('tt09s.xlsx');
tt09s=num(:,1:2);
len_09s=length(tt09s);
[num,text,raw]=xlsread('tt09x.xlsx');
tt09x=num(:,1:2);
len_09x=length(tt09x);
[num,text,raw]=xlsread('tt10s.xlsx');
tt10s=num(:,1:2);
len_10s=length(tt10s);
[num,text,raw]=xlsread('tt10x.xlsx');
tt10x=num(:,1:2);
len_10x=length(tt10x);
%�����׼��Ӫʱ�� 3��Ϊ��Ӫʱ�� min
for i= 1:len_06s
    tt06s(i,3)=(tt06s(i,2)-tt06s(i,1))*1440;%min
end
for i= 1:len_06x
    tt06x(i,3)=(tt06x(i,2)-tt06x(i,1))*1440;%min
end
for i= 1:len_07s
    tt07s(i,3)=(tt07s(i,2)-tt07s(i,1))*1440;%min
end
for i= 1:len_07x
    tt07x(i,3)=(tt07x(i,2)-tt07x(i,1))*1440;%min
end
for i= 1:len_08s
    tt08s(i,3)=(tt08s(i,2)-tt08s(i,1))*1440;%min
end
for i= 1:len_08x
    tt08x(i,3)=(tt08x(i,2)-tt08x(i,1))*1440;%min
end    
for i= 1:len_09s
    tt09s(i,3)=(tt09s(i,2)-tt09s(i,1))*1440;%min
end
for i= 1:len_09x
    tt09x(i,3)=(tt09x(i,2)-tt09x(i,1))*1440;%min
end
for i= 1:len_10s
    tt10s(i,3)=(tt10s(i,2)-tt10s(i,1))*1440;%min
end
for i= 1:len_10x
    tt10x(i,3)=(tt10x(i,2)-tt10x(i,1))*1440;%min
end  
xlswrite('s_runtime.xls',tt06s);
xlswrite('x_runtime.xls',tt06x);

%������첻ͬ�����Ӫʱ��
%����֮ǰ�Ĵ������Ѿ�����ʼվ�ĳ�վ������flag��Ϊ1���յ�վ��flag��Ϊ2
%���ֱ�ӽ������
%��9��6������Ϊ��
%����
[num,text,raw]=xlsread('0906s.xlsx');
data=num(:,);
len_data=length(data);
k=0;%k�����Թ켣����
for i = 1:len_data
    if flag(i,1)==1
        k=k+1;
        time(k,1)=data(i,5);
    else if flag(i,1)==2
            time(k,2)=data(i,5);
        end
    end
end
time(:,3)=(time(:,2)-time(:,1))*1440;%min ��Ӫʱ��
%��¼��time_zong�У�1~5�ֱ�Ϊ6~10�ŵ���Ӫʱ��
time_zongs(:,1)=time(:,3);

%%%�����￪ʼ
%���ڲ�ͬ�����ͬ��� ������Ӫʱ���85%��λ��
[num,text,raw]=xlsread('s_runtime.xls');
s=num;
len_s=length(s);
[num,text,raw]=xlsread('x_runtime.xls');
x=num;
len_x=length(x);
for i = 1 :len_s
    a=s(i,4:8);
    s(i,9)=prctile(a,85);
end

for i = 1 :len_x
    a=x(i,4:8);
    x(i,9)=prctile(a,85);
end

%��ͼ ��׼���� ��λ������ �۵�Ϊ������Ӫʱ��
%shang
figure;
plot(s(:,1),s(:,9),'b');
hold on;
plot(s(:,1),s(:,3),'r');
hold on;
scatter(s(:,1),s(:,4),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(s(:,1),s(:,5),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(s(:,1),s(:,6),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(s(:,1),s(:,7),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(s(:,1),s(:,8),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
set(gca,'YLim',[30 90]);
xlabel('ʱ��');
ylabel('��Ӫʱ��/min');
title('�ζ�104· ���з��� ��������Ӫʱ�����');
legend('��Ӫʱ��85%��λ��','�ƻ���Ӫʱ��','��Ӫʱ��');
set(gca,'XLim',[1/24*4 1/24*23]);
datetick('x',13);

%xia
figure;
plot(x(:,1),x(:,9),'b');
hold on;
plot(x(:,1),x(:,3),'r');
hold on;
scatter(x(:,1),x(:,4),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(x(:,1),x(:,5),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(x(:,1),x(:,6),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(x(:,1),x(:,7),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(x(:,1),x(:,8),'MarkerFaceColor','r','MarkerEdgeColor','r',...
    'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
xlabel('ʱ��');
ylabel('��Ӫʱ��/min');
set(gca,'XLim',[1/24*4 1/24*23]);
set(gca,'YLim',[30 90]);
title('�ζ�104· ���з��� ��������Ӫʱ�����');
legend('��Ӫʱ��85%��λ��','�ƻ���Ӫʱ��','��Ӫʱ��');
datetick('x',13);