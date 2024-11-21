function s = zhundian(datebelong,sx,bus,time)
%ZHUNDIAN 此处显示有关此函数的摘要
%   datebelong:输入数据所属于的天数 只会有6 7 8 9 10 五个值
%   sx:表明是上行还是下行 上行值为0 下行值为1
%   bus：表明是哪一辆公交车，取值为1~13的整数，共十三个值可取
%   time 为需要判断的数值
%   注意：早一晚二阈值由于之前计算过了，因此直接从timetable中读入
%   timetable第一列为车牌号，第45为出发到达的时刻表时间，67为出发早一晚二对应时间,89为到达早一晚二的对应时间
%   s为返回值，值为1时说明是准点，2说明早点或者晚点
    %读取timetable，读取到timetable中
    if sx==0
       switch datebelong
           case 6
               [num,text,raw]=xlsread('tt06s.xlsx');
               timetable=num;
           case 7
               [num,text,raw]=xlsread('tt07s.xlsx');
               timetable=num;
           case 8
               [num,text,raw]=xlsread('tt08s.xlsx');
               timetable=num;
           case 9 
               [num,text,raw]=xlsread('tt09s.xlsx');
               timetable=num;
           otherwise
               [num,text,raw]=xlsread('tt10s.xlsx');
               timetable=num;
       end;
    else
        switch datebelong
           case 6
               [num,text,raw]=xlsread('tt06x.xlsx');
               timetable=num;
           case 7
               [num,text,raw]=xlsread('tt07x.xlsx');
               timetable=num;
           case 8
               [num,text,raw]=xlsread('tt08x.xlsx');
               timetable=num;
           case 9 
               [num,text,raw]=xlsread('tt09x.xlsx');
               timetable=num;
           otherwise
               [num,text,raw]=xlsread('tt10x.xlsx');
               timetable=num;
        end;   
    end
    %得到该辆车在该天该顺序下的时刻表，一般为4~6趟安排,这里冗余8趟
    %用bus_time储存
    %第一列为车牌号，第45为出发到达的时刻表时间，67为出发早一晚二对应时间,89为到达早一晚二的对应时间
    len=length(timetable);
    bus_time=zeros(8,9);
    bus_time(:,1)=bus;
    k=0;%对bus_time计数
    for i = 1: len
        if timetable(i,1)==bus
            k=k+1;
            bus_time(k,:)=timetable(i,:);           
        end
    end
    
    %对数据进行判断，并返回值s，s初值为0，返回值为1时说明是准点，2说明早点或者晚点 
    s=0;
    for i=1:k
        if time < bus_time(i,7) && time > bus_time(i,6)
            s=1;
        end
    end
    %对时刻表判断后没有符合的对应时刻，则该班早点或者晚点了
    if s==0
        s=2
    end
end

