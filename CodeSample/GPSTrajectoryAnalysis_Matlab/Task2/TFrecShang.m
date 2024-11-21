%%读入数据
[num,text,raw]=xlsread('s.xlsx');
data=num;
%         %以6-21-0数据为例 
%         %选择原始GPS数据
%         temp=data(11386:11869,:);
%         dot_num=length(temp);
        %以6-1-0数据为例 
        %选择原始GPS数据
        temp=data(:,2:6);
        dot_num=length(temp);
%读入标准矩形区域与标准站点
[num,text,raw]=xlsread('rectangle_shang.xlsx');
recshang=num;
[num,text,raw]=xlsread('jizhun.xls');
standard=num(:,1:4);
rec_num=length(recshang);
%判断GPS点是否被多个矩形框选
%需要判断的点是p%%%%%%%%%%%%%%改,一共有dot_num个点
    p=temp(:,1:2);
    x=p(:,1);
    y=p(:,2);
    %对每个矩形(rec_num=110个)进行款选判断，并累积,用table记录 横为矩形 竖为点  
    table=zeros(dot_num,rec_num);
    for j = 1: rec_num
        %画矩形
        xv=[recshang(j,1) recshang(j,3) recshang(j,5) recshang(j,7) recshang(j,1)];
        yv=[recshang(j,2) recshang(j,4) recshang(j,6) recshang(j,8) recshang(j,2)];
        in=inpolygon(x,y,xv,yv);%in=0-在外部 in=1-在内部或边缘
        table(:,j)=in;
    end
    %计算每个点对应的矩形个数，并使用rec_flag记录点在哪个矩形之中
    times=zeros(dot_num,1);
    rec_flag=zeros(dot_num,4);
    for i = 1:dot_num
        k=0;
       for j = 1: rec_num
           if table(i,j)==1
               times(i,1)=times(i,1)+1;
               k=k+1;
               rec_flag(i,k)=j;          
           end
       end
    end
    
    standard_num=length(standard);
    r = 6367000; %地球的半径
    %经度（东西方向）1"=30.887m：
    %纬度（南北方向）1"=30.887m*cos((31.2428378+31.2739215)/2)=30.504m
    cos=0.85483599;
    lon=30.887;
    lat=26.395;
    %用times矩阵继续记录数据点a的新坐标,用road记录对应路段的起始点，当road=0时，说明该路段应该被删除
    road=zeros(dot_num,1);
    
    h=waitbar(0,'计算中，请稍后!');
    for i=1:dot_num
       a=temp(i,1:2);%%%a是数据点的经纬度坐标
        %0
        if times(i,1)==0
            %计算与standard点的距离，distance为距离的平方
            distance=zeros(standard_num,1);
            for j =1:standard_num
                %数据点a是temp，标准点b是standard
                b=standard(j,1:2);
                distance(j,1)=((b(1,2)-a(1,2))*3600*lat)^2 + ((b(1,1)-a(1,1))*3600*lon)^2;
                if distance(j,1) <= 2500
                    times(i,2:3)=standard(j,1:2);
                    road(i,1)=j;
                else
                    road(i,1)=999;
                end                 
            end
            %当times(:,1:3)=(0 0 0)/road(i,1)=999时说明该数据应当删除
        end
        
        %1
        if times(i,1)==1
            %找到数据点对应矩形
            t=rec_flag(i,1);
            %获得对应路段的端点(x1,y1)(x2,y2),数据点(x3,y3)
            x1=standard(t,1);
            y1=standard(t,2);
            x2=standard(t+1,1);
            y2=standard(t+1,2);
            x3=a(1,1);
            y3=a(1,2);
            %求点在路段上的投影位置
            p = get_footpoint(x1,y1,x2,y2,x3,y3);
            times(i,2:3)=p(1,1:2);
            road(i,1)=t;
        end
        %n
       if times(i,1)>1
            %找到数据点对应矩形
            l=times(i,1);
            %对每个路段进行投影，先计算所有并储存
            shadow=zeros(l,3);
            for j=1:l
                t=rec_flag(i,j);
                %获得对应路段的端点(x1,y1)(x2,y2),数据点(x3,y3)
                x1=standard(t,1);
                y1=standard(t,2);
                x2=standard(t+1,1);
                y2=standard(t+1,2);
                x3=a(1,1);
                y3=a(1,2);
                p = get_footpoint(x1,y1,x2,y2,x3,y3);
                shadow(j,:)=p;
                %shadow(j,3)储存对应矩形起始点标号
                shadow(j,3)=t;
            end
            %选择投影最短的路段:假设第一个最小，不断比较
            min=1;
            if j == 2
               if shadow(1,3)>shadow(2,3)
                   min=2;
               end
            else for j=2:l
                    if shadow(min,3)>shadow(j,3)
                        min=j;
                    end
                end
            end
            %此时min确实为最小，赋值
            times(i,2:3)=shadow(min,1:2);     
            road(i,1)=shadow(j,3);
       end  
       waitbar(i/dot_num);
    end

    close(h);



for i=1:dot_num           
     temp(i,6:7)=times(i,2:3);  
end


plot(temp(:,1),temp(:,2),'r');
hold on;
plot(standard(:,1),standard(:,2),'g');
hold on
plot(temp(:,6),temp(:,7),'b');
xlabel('lon');
ylabel('lat');
legend('Bus Trajectory','Bus Route','Bus Tra-New');
title("嘉定104路公交9月6日1-0次轨迹图");

%将最终选择的矩形路段起始点位置road储存为表格road
xlswrite('0907s.xlsx',temp);
xlswrite('road_s.xlsx',road);
xlswrite('0907srecflag.xlsx',rec_flag);