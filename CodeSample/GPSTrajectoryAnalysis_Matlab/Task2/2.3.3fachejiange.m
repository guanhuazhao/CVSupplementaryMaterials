%%����ÿ�ձ�׼�������
%��������
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
%������,������ttdates/x�ĵڶ���
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
%����ÿ�����������з����ʵ�ʷ������
%��ȡ���ݣ�
%����֮ǰ�Ĵ������Ѿ�����ʼվ�ĳ�վ������flag��Ϊ1��
%�������ֻ��Ҫ��flag=1�����ݽ��м���
[num,text,raw]=xlsread('06s.xlsx');
data=num;
len_data=length(data);
k_6s=0;%�Խ�վ�����ͳ�ƣ���Ϊ�±��
data_06s=zeros(len_06s,2);
for i= 1:len_data
    if flag(i,1)==1
        k_6s=k_6s+1;
        data_06s(i,1)=data(i,1);%����ʼվ��վ��ʱ�䴢���ڱ����
    end
end
%����ʵ��ʱ���
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
%��ȡ����
%��ͼ,�涨�������ɫ��ʵ�ʼ������ɫ
%6
figure;
subplot(1,2,1);
plot(tt06s(:,1),tt06s(:,2),'b');
hold on;
plot(data_06s(:,1),data_06s(:,2),'r');
xlabel('ʱ��');
ylabel('�������/min');
title('�ζ�104· 9��6�� ���з��� �����������');
legend('�ƻ��������','�������');
datetick('x',13);
subplot(1,2,2);
plot(tt06x(:,1),tt06x(:,2),'b');
hold on;
plot(data_06x(:,1),data_06x(:,2),'r');
xlabel('ʱ��');
ylabel('��ʱ�̱�ƫ��/min');
title('�ζ�104· 9��6�� ���з��� �����������');
legend('�ƻ��������','�������');
datetick('x',13);
