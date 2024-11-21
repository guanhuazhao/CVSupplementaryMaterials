% %����
% [num,text,raw]=xlsread('timetable_s.xlsx');
% timetable_s=num;
% %��timetable���棬��һ��Ϊ���ƺţ���45Ϊ���������ʱ�̱�ʱ�䣬67Ϊ������һ�����Ӧʱ��,89Ϊ������һ����Ķ�Ӧʱ��
% len_time=length(timetable_s);
% %timetable��һ��Ϊ������ţ�����Ϊ��������ʱ�̱�
%     for i = 1: len_time
%        chufa=timetable_s(i,4);
%        daoda=timetable_s(i,5);
%        %0~1=0~86400s
%        %1min=1/1440
%        %��1
%        timetable_s(i,6)=chufa-1/1440;
%        timetable_s(i,8)=daoda-1/1440;
%        %��2
%        timetable_s(i,7)=chufa+2/1440;
%        timetable_s(i,9)=daoda+2/1440;
%     end

%����
[num,text,raw]=xlsread('timetable_s.xlsx');
timetable_s=num;
len_time=length(timetable_s);
%������Ҫ�жϵ�������
[num,text,raw]=xlsread('0906S.xlsx');
data=num;
len_data=length(data);
%�յ�վ����
sz_x0=121.297079;
sz_y0=31.27175;
%���վ����
sq_x0=121.354537;
sq_y0=31.264483;
r=6371.004;
%��ÿ����������վ���յ�վ����ľ��룬
%���վ�����¼��data7 �յ�վ�����¼��data8
for i=1:len_data
    x1=data(i,2);
    y1=data(i,3);
    data(i,7)=distance(y1,x1,sq_y0,sq_x0,r)*1000;   %���վ
    data(i,8)=distance(y1,x1,sz_y0,sz_x0,r)*1000;   %�յ�վ 
end
%Ѱ��ÿ���켣�У������³�վ��վʱ�� Ѱ�ҷ������վ��վʱ��
%9��6��������75���켣���ʸ���75����
%��ʼվ��վʱ������chu���У��յ�վ��վʱ������dao����

 n=0;%�����յ�Ľ�վ��.
 dao=zeros(75,8);
% %�յ�վ��վ�� �ҵ����յ�վ��������ĵ�
%%%��¼�¸������ݣ�
area_d=178;
for i=3:len_data-2
    s=data(i,8);   %�ø�
    s1=data(i-1,8); %��һ��
    s2=data(i-2,8); %������
    s3=data(i+1,8);%��һ��
    if s1>s && s2>s && s<s3  &&s<area_d
        n=n+1;
        dao(n,:)=data(i,:);
    end
end
m=0;%������ʼ��ĳ�վ��
chu=zeros(75,8);
area_c=220;
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
    if  v(i)>=15 && s<area_c && s3>area_c && s1<area_c
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
        time_c_abs(i,j)=abs((chu(i,1)-timetable_s(j,4))*1440);%min
        time_c(i,j)=(chu(i,1)-timetable_s(j,4))*1440;
    end
end
%����
time_d=zeros(n,len_time);
time_d_abs=zeros(n,len_time);
for i = 1:n
     for j= 1:len_time
        time_d(i,j)=(chu(i,1)-timetable_s(j,5))*1440;%min  
        time_d_abs(i,j)=abs((chu(i,1)-timetable_s(j,5))*1440);%min  
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
    chu(i,10)=1440*(chu(i,1)-timetable_s(hao_c(1,i),4));
end
%����
for i = 1:n
%     dao(i,10)=1440*(dao(i,1)-timetable_s(hao_d(1,i),5));
    dao(i,10)=time_d(hao_d(1,i),i);
end
xlswrite('s_dao.xls',dao(1:63,:));
xlswrite('s_chu.xls',chu(1:63,:));

subplot(1,2,1)
stem(chu(:,1),chu(:,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
% set(gca,'YLim',[-50 20]);
xlabel('ʱ��');
ylabel('��ʱ�̱�ƫ��/min');
title('���� ���� ��ʱ�̱�ƫ��');
subplot(1,2,2)
stem(dao(1:63,1),dao(1:63,10));
datetick('x',13);
set(gca,'XLim',[4*1/24 23/24]);
set(gca,'YLim',[-50 50]);
xlabel('ʱ��');
ylabel('��ʱ�̱�ƫ��/min');
title('���� ���� ��ʱ�̱�ƫ��');




