%上行时空轨迹
%读取信息
[num,text,raw]=xlsread('0907s.xlsx');
temp=num;%1时间 23经纬度
[num,text,raw]=xlsread('jizhun.xls'); %12经纬度 3空 4范围 5基准点之间距离
jizhun=num;
[num,text,raw]=xlsread('rectangle_shang.xlsx'); 
rec_tangle=num;

[num,text,raw]=xlsread('road_s.xlsx');
road=num;
temp_num=length(temp);
%计算每个数据点的投影点距离上一个基准点之间的距离，储存在temp8列
%上一个基准点由road字段得到,当road=999，该数据点应该被删除，令距离为0

r=6371.004;
h=waitbar(0,'计算中，请稍后!');
len=temp_num
for i= 1:temp_num
    t=road(i,1);%对应路段起点
    if t~=999
        lat=temp(i,7);
        lon=temp(i,6);%投影点
        x=jizhun(t,1);
        y=jizhun(t,2);%起点
        temp(i,8)=distance(y,x,lat,lon,r);
    else
        temp(i,8)=0
    end
    str=['计算中…',num2str(100*i/len),'%'];
    waitbar(i/len,h,str);
end
  close(h);
xlswrite('s_dis_GPS2JZ',temp(:,8));  




%计算数据点到起始点的距离D，L为路段起点到起始点的距离，
%D储存在temp(：,9)中
[num,text,raw]=xlsread('0907s.xlsx');
temp=num;%1时间 23经纬度
[num,text,raw]=xlsread('jizhun.xls'); %12经纬度 3空 4范围 5基准点之间距离
jizhun=num;
[num,text,raw]=xlsread('rectangle_shang.xlsx'); 
rec_tangle=num;
[num,text,raw]=xlsread('road_s.xlsx');
road=num;
temp_num=length(temp);
[num,text,raw]=xlsread('s_dis_GPS2JZ.xls');
temp(:,8)=num;


%算每个点到起始点的累计距离，储存在jizhun(:,6)之中
jizhun(1,6)=0;
for i=2:length(jizhun)
    jizhun(i,6)=jizhun(i-1,6)+jizhun(i-1,5);
end
xlswrite('jizhun_s',jizhun);

xlswrite('temp_1-8',temp);

%%%^^^^^^^^从这里开始做
[num,text,raw]=xlsread('road_s.xlsx');
road=num;
[num,text,raw]=xlsread('temp_1-8.xls');
temp=num;
temp_num=length(temp);%8为到上一个基准点的距离
[num,text,raw]=xlsread('jizhun_s.xls'); %12经纬度 3空 4范围 5基准点之间距离 6到起始点距离
jizhun=num;

h=waitbar(0,'计算中，请稍后!');
len=temp_num;
%第一个点距离为0
temp(1,9)=0;
for i =2 :temp_num
    if road(i,1)==999   %%999数据行删除 令距离为0
        temp(i,9)=0
    else
        %距离=dot到最近基准点距离+该基准点到起始点距离
        k=road(i,1);
        D=jizhun(k,6)+temp(i,8);        
        temp(i,9)=D;
    end
    str=['计算中…',num2str(100*i/len),'%'];
    waitbar(i/len,h,str);
end
  close(h);
  xlswrite('temp_1-9',temp);
 
  %读取时间
[num,text,raw]=xlsread('07st.xlsx');
time=num(:,1);
h=waitbar(0,'计算中，请稍后!');
color=['b';'g';'r';'c';'m';'y';'k'];
color_num(:,1)=color(mod(temp(:,5),7)+1,1);

figure;
h=waitbar(0,'计算中，请稍后!');
for i = 1:temp_num
    if temp(i,9)~=0
        scatter(time(i,1),temp(i,9),color_num(i,1),'.');
        hold on
    end
    str=['计算中…',num2str(100*i/len),'%'];
    waitbar(i/len,h,str);
end
 close(h);

xlabel('时间');
ylabel('距离始发站的距离/km');
title('9月7日104路公交运行上行时空图');
set(gca,'XLim',[4*1/24 23/24]);
datetick('x',13);
