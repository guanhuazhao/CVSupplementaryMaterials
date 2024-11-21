[num,text,raw]=xlsread('timetable_x.xlsx');
timetable_x=num;
len_time=length(timetable_x);
%������Ҫ�жϵ�������
[num,text,raw]=xlsread('0906X.xlsx');
data=num;
len_data=length(data);
%�յ�վ����
xz_x0=121.354654;
xz_y0=31.264317;
%���վ����
xq_x0=121.297109;
xq_y0=31.27167;
r=6371.004;
%��ÿ����������վ���յ�վ����ľ��룬
%���վ�����¼��data7 �յ�վ�����¼��data8
for i=1:len_data
    x1=data(i,2);
    y1=data(i,3);
    data(i,7)=distance(y1,x1,xq_y0,xq_x0,r)*1000;   %���վ
    data(i,8)=distance(y1,x1,xz_y0,xz_x0,r)*1000;   %�յ�վ 
end
%Ѱ��ÿ���켣�У������³�վ��վʱ�� Ѱ�ҷ������վ��վʱ��
%9��6��������74���켣���ʸ���74����
%��ʼվ��վʱ������chu���У��յ�վ��վʱ������dao����

 n=0;%�����յ�Ľ�վ��.
 dao=zeros(74,8);
% %�յ�վ��վ�� �ҵ����յ�վ��������ĵ�
%%%��¼�¸������ݣ�
area_d=250;
for i=3:len_data-1
    s=data(i,8);   %�ø�
    s1=data(i-1,8); %��һ��
    s2=data(i-2,8); %������
    s3=data(i+1,8);%��һ��
    if s1>s && s2>s && s<s3  &&s<area_d
%     if s1>s &&  s<s3  &&s<area_d
        n=n+1;
        dao(n,:)=data(i,:);
    end
end

m=0;%������ʼ��ĳ�վ��
chu=zeros(74,8);
area_c=250;
for i=2:len_data-2
    s=data(i,7);   %�ø�
    s1=data(i-1,7); %��һ��
    s3=data(i+1,7);%��һ��
    t=(data(i,1)-data(i-1,1))*86400;%s
    delta_s=s-s1;%m
    v(i)=(delta_s/t)*3.6;%km/h
    if v(i)<0
        v(i)=-v(i);
    end
    %�����ٶ�
    if  v(i)>=5 && s<area_c && s3>area_c && s1<area_c
        m=m+1;
        chu(m,:)=data(i,:);
    end
end

%%ƥ���Ӧʱ�̱�
%��timetable�е�ÿ��ʱ������ �ҵ���С��ʱ�� ��Ϊ��Ӧʱ�� 
%��Ӧʱ�̴�����9����
%timetable----��һ��Ϊ���ƺţ���45Ϊ���������ʱ�̱�ʱ�䣬67Ϊ������һ�����Ӧʱ��,89Ϊ������һ����Ķ�Ӧʱ��
%����
time_c_abs=zeros(m,len_time);
time_c=zeros(m,len_time);
for i =1:m
    for j= 1:len_time
        time_c_abs(i,j)=abs((chu(i,1)-timetable_x(j,1))*1440);%min
        time_c(i,j)=(chu(i,1)-timetable_x(j,1))*1440;
    end
end
%����
time_d=zeros(n,len_time);
time_d_abs=zeros(n,len_time);
for i = 1:n
     for j= 1:len_time
        time_d(i,j)=(chu(i,1)-timetable_x(j,2))*1440;%min  
        time_d_abs(i,j)=abs((chu(i,1)-timetable_x(j,2))*1440);%min  
    end
end
time_c_abs=time_c_abs';
time_d_abs=time_d_abs';
time_c=time_c';
time_d=time_d';
%�ҵ���Сֵ���Ӧ��� 
[zhi_c,hao_c]=min(time_c_abs);
[zhi_d,hao_d]=min(time_d_abs);
%����������chu dao֮�еĵ�10��
%����
for i =1:m
    chu(i,10)=1440*(chu(i,1)-timetable_x(hao_c(1,i),1));
end
%����
for i = 1:n
%     dao(i,10)=1440*(dao(i,1)-timetable_s(hao_d(1,i),5));
    dao(i,10)=time_d(hao_d(1,i),i);
end
xlswrite('x_dao.xls',dao(1:63,:));
xlswrite('x_chu.xls',chu(1:63,:));
%n����  m����
subplot(1,2,1)
stem(chu(1:m,1),chu(1:m,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
% set(gca,'YLim',[-50 20]);
xlabel('ʱ��');
ylabel('��ʱ�̱�ƫ��/min');
title('���� ���� ��ʱ�̱�ƫ��');
subplot(1,2,2)
stem(dao(1:n,1),dao(1:n,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[-50 50]);
xlabel('ʱ��');
ylabel('��ʱ�̱�ƫ��/min');
title('���� ���� ��ʱ�̱�ƫ��');



%%��������
%��sΪ����
[num,text,raw]=xlsread('x_chu+dao.xls');
data=num(1:65,:);
chu(:,1)=data(:,1);
chu(:,2)=data(:,3);
chu(:,10)=(chu(:,1)-chu(:,2))*1440;
dao(:,1)=data(:,2);
dao(:,2)=data(:,4);
dao(:,10)=(dao(:,1)-dao(:,2))*1440;
subplot(1,2,1)
stem(chu(:,2),chu(:,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
% set(gca,'YLim',[-50 20]);
xlabel('ʱ��');
ylabel('��ʱ�̱�ƫ��/min');
title('���� ���� ��ʱ�̱�ƫ��');
subplot(1,2,2)
stem(dao(:,2),dao(:,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
% set(gca,'YLim',[-50 50]);
xlabel('ʱ��');
ylabel('��ʱ�̱�ƫ��/min');
title('���� ���� ��ʱ�̱�ƫ��');