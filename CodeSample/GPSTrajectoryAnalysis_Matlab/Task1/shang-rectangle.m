
%%��׼���й켣��·����
standard=xlsread('mapshang.xlsx','sheet1');
standot_num=111;
%%��50mΪ���޻��־��η�Χ,����ת��Ϊ��γ��
%standard5-6�����Ͼ��ε�,7-8�����¾��ε㣬�ֱ�Ϊlon/lat
len=50;
r = 6367000; %����İ뾶
%���ȣ���������1"=30.887m��
%γ�ȣ��ϱ�����1"=30.887m*cos((31.2428378+31.2739215)/2)=30.504m
cos=0.85483599;
lon=30.887;
lat=26.395;

for i = 1: (standot_num-1)
    a=standard(i,1:2);
    b=standard(i+1,1:2);

    k=(b(1,2)-a(1,2))/(b(1,1)-a(1,1));%·��б��
    %%�෽�̷ֽ�ʽ
    %%ԭ��
    %%[x,y]=solve([k*((y-a(1,2))/(x-a(1,1)))==-1,sqrt((r*dy)^2 + (r*dx*cos(average))^2)==len,dx==(x-a(1,1))*pi/180,dy==(y-a(1,2))*pi/180,average==(y+a(1,2))/2*pi/180],[x,y]);
    %%�򵥽ⷨ
    syms x y 
    [x,y]=vpasolve([k*((y-a(1,2))/(x-a(1,1)))==-1,((y-a(1,2))*3600*lat)^2 + ((x-a(1,1))*3600*lon)^2==len*len],[x,y]);
    x=double(x);
    y=double(y);
    standard(i,5)=x(1,1);
    standard(i,6)=y(1,1);
    standard(i,7)=x(2,1);
    standard(i,8)=y(2,1);   
end
%��һ����
a=standard(1,1:2);
b=standard(2,1:2);
k=(b(1,2)-a(1,2))/(b(1,1)-a(1,1));
syms x y
   [x,y]=vpasolve([k*((y-a(1,2))/(x-a(1,1)))==-1,((y-a(1,2))*3600*lat)^2 + ((x-a(1,1))*3600*lon)^2==len*len],[x,y]);
   x=double(x);
   y=double(y);
standard(standot_num,5)=x(1,1);
standard(standot_num,6)=y(1,1);
standard(standot_num,7)=x(2,1);
standard(standot_num,8)=y(2,1); 

%���һ����
a=standard(standot_num,1:2);
b=standard(standot_num-1,1:2);
k=(b(1,2)-a(1,2))/(b(1,1)-a(1,1));
syms x y
   [x,y]=vpasolve([k*((y-a(1,2))/(x-a(1,1)))==-1,((y-a(1,2))*3600*lat)^2 + ((x-a(1,1))*3600*lon)^2==len*len],[x,y]);
   x=double(x);
   y=double(y);
standard(standot_num,5)=x(1,1);
standard(standot_num,6)=y(1,1);
standard(standot_num,7)=x(2,1);
standard(standot_num,8)=y(2,1); 

%�м��Ĳ���
for i = 2: (standot_num-1)
    a=standard(i,1:2);
    b=standard(i-1,1:2);

    k=(b(1,2)-a(1,2))/(b(1,1)-a(1,1));%·��б��
    %%�෽�̷ֽ�ʽ
    %%ԭ��
    %%[x,y]=solve([k*((y-a(1,2))/(x-a(1,1)))==-1,sqrt((r*dy)^2 + (r*dx*cos(average))^2)==len,dx==(x-a(1,1))*pi/180,dy==(y-a(1,2))*pi/180,average==(y+a(1,2))/2*pi/180],[x,y]);
    %%�򵥽ⷨ
    syms x y 
    [x,y]=vpasolve([k*((y-a(1,2))/(x-a(1,1)))==-1,((y-a(1,2))*3600*lat)^2 + ((x-a(1,1))*3600*lon)^2==len*len],[x,y]);
    x=double(x);
    y=double(y);
    standard(i,9)=x(1,1);
    standard(i,10)=y(1,1);
    standard(i,11)=x(2,1);
    standard(i,12)=y(2,1);   
end

%�����������ж�
%�������
pic=standard(:,1:2);
%Ϊ���߷��㣬�ѵ�һ������ӵ����һ�������
picn=standot_num+1;
pic(picn,:)=pic(1,:);
plot(pic(:,1),pic(:,2),'g');
%��Ҫ�жϵĵ�
p=standard(:,5:6);
o=0;
%�жϵ�һ�������ⲿ�����ڲ��������һ�������ڲ�����ڶ��������ⲿ������ǣ���ת��λ��
for i=1:standot_num
    flag=0;
    for j=2:picn
        x1=pic(j-1,1);         %�����ǰ��������
        y1=pic(j-1,2);
        x2=pic(j,1);
        y2=pic(j,2);
       
        k=(y1-y2)/(x1-x2);      %�����һ����ֱ��
        b=y1-k*x1;
        x=p(i,1);               %����ǰ��ֱ�ߺͶ���ν���
        y=k*x+b;          
               
        if min([x1 x2])<=x && x<=max([x1 x2]) && ...        %��ͬʱ�����ߺͶ���α���
           min([y1 y2])<=y && y<=max([y1 y2]) &&  y>=p(i,2)
               flag=flag+1;
        end
    end
   
    if mod(flag,2)==1               %���������ڲ� ������ڲ� �ߵ�λ�� ����56���루78���ߵ�λ��
        temp1=standard(i,5);
        temp2=standard(i,6);
        standard(i,5)=standard(i,7);
        standard(i,6)=standard(i,8);
        standard(i,7)=temp1;
        standard(i,8)=temp2;
        o=o+1;
    end
end
%��Ҫ�жϵĵ㸽��-�м��
p=standard(:,9:10);
o=0;
%�жϵ�һ�������ⲿ�����ڲ�
for i=1:standot_num-2
    flag=0;
    for j=2:picn
        x1=pic(j-1,1);         %�����ǰ��������
        y1=pic(j-1,2);
        x2=pic(j,1);
        y2=pic(j,2);
       
        k=(y1-y2)/(x1-x2);      %�����һ����ֱ��
        b=y1-k*x1;
        x=p(i,1);               %����ǰ��ֱ�ߺͶ���ν���
        y=k*x+b;          
               
        if min([x1 x2])<=x && x<=max([x1 x2]) && ...        %��ͬʱ�����ߺͶ���α���
           min([y1 y2])<=y && y<=max([y1 y2]) &&  y>=p(i,2)
               flag=flag+1;
        end
    end
   
    if mod(flag,2)==1               %���������ڲ� ������ڲ� �ߵ�λ�� ����56���루78���ߵ�λ��
        temp1=standard(i,9);
        temp2=standard(i,10);
        standard(i,9)=standard(i,11);
        standard(i,10)=standard(i,12);
        standard(i,11)=temp1;
        standard(i,12)=temp2;
        o=o+1;
    end
end
standard(standot_num,9:12)=standard(standot_num,5:8);
standard(standot_num,5:8)=standard(1,9:12);

%�Ծ����ĸ�����������򣬱�֤���Ի���һ�����Σ��������˳��
recshang=zeros(standot_num-1,8);
%����������ƹ����Ƶ���-1������
plot(standard(1:110,1),standard(1:110,2),'r');
hold on 
for i =1 : standot_num-1
    rec=zeros(5,2);
    rec(1,1)=standard(i,5);
    rec(1,2)=standard(i,6);
    rec(2,1)=standard(i,7);
    rec(2,2)=standard(i,8);
    rec(3,1)=standard(i+1,11);
    rec(3,2)=standard(i+1,12);
    rec(4,1)=standard(i+1,9);
    rec(4,2)=standard(i+1,10);
    %3 4������
    temp=zeros(1,2);
    dis23=(rec(2,1)-rec(3,1))*(rec(2,1)-rec(3,1))+(rec(2,2)-rec(3,2))*(rec(2,2)-rec(3,2));
    dis24=(rec(2,1)-rec(4,1))*(rec(2,1)-rec(4,1))+(rec(2,2)-rec(4,2))*(rec(2,2)-rec(4,2));
    if dis23 > dis24
        temp=rec(3,:)
        rec(3,:)=rec(4,:);
        rec(4,:)=temp;
    end
    rec(5,:)=rec(1,:);
    recshang(i,1:2)=rec(1,1:2);
    recshang(i,3:4)=rec(2,1:2);
    recshang(i,5:6)=rec(3,1:2);
    recshang(i,7:8)=rec(4,1:2);
    plot(rec(:,1),rec(:,2),'g');
    
end
    
xlabel('lon');
ylabel('lat');
legend('Bus Route');
title("�ζ�104·�������о��η�Χ");

%standard���
xlswrite('rectangle_shang.xlsx',recshang);
xlswrite('standard_shang.xlsx',standard);
