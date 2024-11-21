%读取信息
[num,text,raw]=xlsread('0906010.xlsx');
temp=num;
[num,text,raw]=xlsread('mapshang.xlsx');
standard=num;
[num,text,raw]=xlsread('090610recflag.xlsx');
rec_flag=num;
[num,text,raw]=xlsread('090610road.xlsx');
road=num;

%得到基准点个数 
jizhun=standard;
jizhun_num=length(jizhun);
%计算基准点之间距离,jizhun_num个点，jizhun_num-1个距离,
%距离储存在jizuhn(i,5)格之中
r=6371.004;
for i=1:(jizhun_num-1)
    jizhun(i,5)=distance(jizhun(i,2),jizhun(i,1),jizhun(i+1,2),jizhun(i+1,1),r);
end

%计算每个数据点的投影点距离上一个基准点之间的距离，储存在temp8列
%上一个基准点由road字段得到,当road=999，该数据点应该被删除，令距离为0
temp_num=length(temp);
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
end

%计算数据点到起始点的距离D，L为路段起点到起始点的距离，
%D储存在temp(：,9)中
for i =1 :temp_num
    if road(i,1)==999
        temp(i,9)=0
    else
        %算路段起点到起始点的距离
        L=0
        for j=1:(road(i,1)-1)
            L=L+jizhun(j,5);
        end
        D=L+temp(i,8);        
        temp(i,9)=D;
    end
end

%绘制时空图轨迹
%读取时间
[num,text,raw]=xlsread('0906_new_gps.xlsx');
time=num(1:temp_num,1);
subplot(2,1,1);
plot(time,temp(:,9));
xlabel('时间');
ylabel('行程距离');
title('9月6日嘉定104路公交第一班车上行时空轨迹图');
subplot(2,1,2);
plot(time,temp(:,9));
xlabel('时间');
ylabel('行程距离');
title('9月6日嘉定104路公交第一班车上行时空轨迹图');
hold on 
for i = 2 : temp_num
    if temp(i,9)<temp(i-1,9)
        scatter(time(i,1),temp(i,9),'r','*');
    end
end

%%用flag进行标记
%flag初始值为0
%当flag=1时，说明该点为异常数据，需要二次修正
%当flag=2时，说明该数据行需要删除
flag=zeros(temp_num,1);
time_cha=zeros(temp_num,1);
%用于储存time_cha 方便后续二次修正
%（1,1）为无用数据，（i，1）为第i个点与前一个点的时间差
for i = 2:temp_num
    %漂移距离大于50m的数据需要删除
    if temp(i,9)==0
        flag(i,1)=2;
    else
         %距离为负
        s=temp(i,9)-temp(i-1,9);
        if s<0
             flag(i,1)=1;
        end
    %车速超过80km/h
        time_cha(i,1)=(time(i,1)-time(i-1,1))*86400;
        v=s*1000/time_cha(i,1);
        if  v*3.6>80
            flag(i,1)=1;
        end
    end
end
%b=time(2,1)-time(1,1);
%a=datestr(b,'HH:MM:SS')


%%二次修正
%计算每个点的可匹配路段个数,储存在flag(:,2)之中
for i= 1:temp_num
    d=0;
    for j=1 :4
        if rec_flag(i,j)~=0
            d=d+1
        end
    end
    flag(i,2)=d;
end

%查看是否存在可选备用路段
%
for i=1:temp_num
    %对于异常点
    if( flag(i,1)==1 )&& (flag(i,2)==1)
         %不存在备用路段时，将其转化为需要删除的匹配点
        flag(i,1)=2
    end
    if ( flag(i,1)==1 )&& (flag(i,2)>1)
        %存在备用路段
        t=flag(i,2);%备用路段个数    
        %对于剩余备用路段
        if t==2     %还有一个备用路段
             a=temp(i,1:2);%%%a是数据点的经纬度坐标

             %得到新投影点
             new_rec=rec_flag(i,2);  %新路段对应矩形序号
             x1=standard(new_rec,1);
             y1=standard(new_rec,2);
             x2=standard(new_rec+1,1);
             y2=standard(new_rec+1,2);
             x3=a(1,1);
             y3=a(1,2);     
              %得到新点的投影点坐标与垂足距离
              %p（1,1:2）为坐标，p（1,3）为距离
             p = get_footpoint(x1,y1,x2,y2,x3,y3);

              %判断新的点是否是异常点位,1不异常，2异常，TF为判断函数
             dis_lastnode=temp(i-1,9);
             TF=yichang(p(1,1),p(1,2),time_cha(i,1),dis_lastnode,new_rec,jizhun);
             if TF(1,1)==1            
                %不异常则更新投影点数据,更新flag标记
                temp(i,6:7)=p(1,1:2);
                temp(i,9)=TF(1,2);
                flag(i,1)=0;
             else 
                flag(i,1)=2 %仍然异常则没有备用线路了，将该匹配点删除            
             end         
        end  
                
        if t==3     %还有两个备用路段
             a=temp(i,1:2);%%%a是数据点的经纬度坐标

             %得到新投影点
             new_rec=rec_flag(i,2);  %新路段对应矩形序号
             x1=standard(new_rec,1);
             y1=standard(new_rec,2);
             x2=standard(new_rec+1,1);
             y2=standard(new_rec+1,2);
             x3=a(1,1);
             y3=a(1,2);     
              %得到新点的投影点坐标与垂足距离
              %p（1,1:2）为坐标，p（1,3）为距离
             p = get_footpoint(x1,y1,x2,y2,x3,y3);

              %判断新的点是否是异常点位,1不异常，2异常，TF为判断函数
             dis_lastnode=temp(i-1,9);
             TF=yichang(p(1,1),p(1,2),time_cha(i,1),dis_lastnode,new_rec,jizhun);
             if TF(1,1)==1            
                %不异常则更新投影点数据
                temp(i,6:7)=p(1,1:2);
                temp(i,9)=TF(1,2);
                flag(i,1)=0;
             else 
                %仍然异常则选择第二个备用线路       
                 new_rec=rec_flag(i,3);  %新路段对应矩形序号
                 x1=standard(new_rec,1);
                 y1=standard(new_rec,2);
                 x2=standard(new_rec+1,1);
                 y2=standard(new_rec+1,2);
                 x3=a(1,1);
                 y3=a(1,2);     
                  %得到新点的投影点坐标与垂足距离
                  %p（1,1:2）为坐标，p（1,3）为距离
                 p = get_footpoint(x1,y1,x2,y2,x3,y3);

                  %判断新的点是否是异常点位,1不异常，2异常，TF为判断函数
                 dis_lastnode=temp(i-1,9);
                 TF=yichang(p(1,1),p(1,2),time_cha(i,1),dis_lastnode,new_rec,jizhun);
                 if TF(1,1)==1
                     temp(i,6:7)=p(1,1:2);
                     temp(i,9)=TF(1,2);
                     flag(i,1)=0;
                 else
                     flag(i,1)=2 %仍然异常则没有备用线路了，将该匹配点删除    
                 end
             end 
             
        end
    end
end

 
 %重新绘图,lujing储存新数据 12经纬度 3位累积行程距离 4为时间
 k=0;
 lujing=zeros(temp_num,4);
 for i=1:temp_num
     if flag(i,1)==0
         k=k+1;
         lujing(k,1:2)=temp(i,6:7);
         lujing(k,3)=temp(i,9);
         lujing(k,4)=time(i,1);
     end
 end

subplot(2,1,1);
plot(lujing(1:k,4),lujing(1:k,3));
xlabel('时间');
ylabel('行程距离');
title('二次修正后时空轨迹图');
subplot(2,1,2);
plot(time,temp(:,9));
xlabel('时间');
ylabel('行程距离');
title('地图匹配后时空轨迹图');
hold on 
for i = 2 : temp_num
    if temp(i,9)<temp(i-1,9)
        scatter(time(i,1),temp(i,9),'r','*');
    end
end

%为方便储存 令temp(:,10)为flag,temp(:,11)为时间，储存temp,
temp(:,10)=flag(:,1);
temp(:,11)=time(:,1);
xlswrite('xiuzheng2',temp);
%线性内插数据，储存lujing
xlswrite('lujing2',lujing);
%储存基准点到下一个基准点之间的距离
xlswrite('jizhun',jizhun);