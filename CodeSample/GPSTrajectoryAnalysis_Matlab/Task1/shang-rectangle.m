
%%标准上行轨迹线路数据
standard=xlsread('mapshang.xlsx','sheet1');
standot_num=111;
%%以50m为界限划分矩形范围,将米转化为经纬度
%standard5-6是线上矩形点,7-8是线下矩形点，分别为lon/lat
len=50;
r = 6367000; %地球的半径
%经度（东西方向）1"=30.887m：
%纬度（南北方向）1"=30.887m*cos((31.2428378+31.2739215)/2)=30.504m
cos=0.85483599;
lon=30.887;
lat=26.395;

for i = 1: (standot_num-1)
    a=standard(i,1:2);
    b=standard(i+1,1:2);

    k=(b(1,2)-a(1,2))/(b(1,1)-a(1,1));%路段斜率
    %%多方程分解式
    %%原理
    %%[x,y]=solve([k*((y-a(1,2))/(x-a(1,1)))==-1,sqrt((r*dy)^2 + (r*dx*cos(average))^2)==len,dx==(x-a(1,1))*pi/180,dy==(y-a(1,2))*pi/180,average==(y+a(1,2))/2*pi/180],[x,y]);
    %%简单解法
    syms x y 
    [x,y]=vpasolve([k*((y-a(1,2))/(x-a(1,1)))==-1,((y-a(1,2))*3600*lat)^2 + ((x-a(1,1))*3600*lon)^2==len*len],[x,y]);
    x=double(x);
    y=double(y);
    standard(i,5)=x(1,1);
    standard(i,6)=y(1,1);
    standard(i,7)=x(2,1);
    standard(i,8)=y(2,1);   
end
%第一个点
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

%最后一个点
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

%中间点的补充
for i = 2: (standot_num-1)
    a=standard(i,1:2);
    b=standard(i-1,1:2);

    k=(b(1,2)-a(1,2))/(b(1,1)-a(1,1));%路段斜率
    %%多方程分解式
    %%原理
    %%[x,y]=solve([k*((y-a(1,2))/(x-a(1,1)))==-1,sqrt((r*dy)^2 + (r*dx*cos(average))^2)==len,dx==(x-a(1,1))*pi/180,dy==(y-a(1,2))*pi/180,average==(y+a(1,2))/2*pi/180],[x,y]);
    %%简单解法
    syms x y 
    [x,y]=vpasolve([k*((y-a(1,2))/(x-a(1,1)))==-1,((y-a(1,2))*3600*lat)^2 + ((x-a(1,1))*3600*lon)^2==len*len],[x,y]);
    x=double(x);
    y=double(y);
    standard(i,9)=x(1,1);
    standard(i,10)=y(1,1);
    standard(i,11)=x(2,1);
    standard(i,12)=y(2,1);   
end

%多边形内外侧判断
%做多边形
pic=standard(:,1:2);
%为连线方便，把第一个点添加到最后一个点后面
picn=standot_num+1;
pic(picn,:)=pic(1,:);
plot(pic(:,1),pic(:,2),'g');
%需要判断的点
p=standard(:,5:6);
o=0;
%判断第一个点在外部还是内部，如果第一个点在内部，则第二个点在外部；如果非，则转换位置
for i=1:standot_num
    flag=0;
    for j=2:picn
        x1=pic(j-1,1);         %多边形前后两个点
        y1=pic(j-1,2);
        x2=pic(j,1);
        y2=pic(j,2);
       
        k=(y1-y2)/(x1-x2);      %多边形一条边直线
        b=y1-k*x1;
        x=p(i,1);               %过当前点直线和多边形交点
        y=k*x+b;          
               
        if min([x1 x2])<=x && x<=max([x1 x2]) && ...        %点同时在射线和多边形边上
           min([y1 y2])<=y && y<=max([y1 y2]) &&  y>=p(i,2)
               flag=flag+1;
        end
    end
   
    if mod(flag,2)==1               %奇数则在内部 如果在内部 颠倒位置 将（56）与（78）颠倒位置
        temp1=standard(i,5);
        temp2=standard(i,6);
        standard(i,5)=standard(i,7);
        standard(i,6)=standard(i,8);
        standard(i,7)=temp1;
        standard(i,8)=temp2;
        o=o+1;
    end
end
%需要判断的点附加-中间点
p=standard(:,9:10);
o=0;
%判断第一个点在外部还是内部
for i=1:standot_num-2
    flag=0;
    for j=2:picn
        x1=pic(j-1,1);         %多边形前后两个点
        y1=pic(j-1,2);
        x2=pic(j,1);
        y2=pic(j,2);
       
        k=(y1-y2)/(x1-x2);      %多边形一条边直线
        b=y1-k*x1;
        x=p(i,1);               %过当前点直线和多边形交点
        y=k*x+b;          
               
        if min([x1 x2])<=x && x<=max([x1 x2]) && ...        %点同时在射线和多边形边上
           min([y1 y2])<=y && y<=max([y1 y2]) &&  y>=p(i,2)
               flag=flag+1;
        end
    end
   
    if mod(flag,2)==1               %奇数则在内部 如果在内部 颠倒位置 将（56）与（78）颠倒位置
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

%对矩形四个点进行再排序，保证可以画出一个矩形，并储存该顺序
recshang=zeros(standot_num-1,8);
%矩形区域绘制共绘制点数-1个矩形
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
    %3 4再排序
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
title("嘉定104路公交上行矩形范围");

%standard输出
xlswrite('rectangle_shang.xlsx',recshang);
xlswrite('standard_shang.xlsx',standard);
