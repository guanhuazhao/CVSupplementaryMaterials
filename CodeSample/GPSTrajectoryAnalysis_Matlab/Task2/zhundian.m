function s = zhundian(datebelong,sx,bus,time)
%ZHUNDIAN �˴���ʾ�йش˺�����ժҪ
%   datebelong:�������������ڵ����� ֻ����6 7 8 9 10 ���ֵ
%   sx:���������л������� ����ֵΪ0 ����ֵΪ1
%   bus����������һ����������ȡֵΪ1~13����������ʮ����ֵ��ȡ
%   time Ϊ��Ҫ�жϵ���ֵ
%   ע�⣺��һ�����ֵ����֮ǰ������ˣ����ֱ�Ӵ�timetable�ж���
%   timetable��һ��Ϊ���ƺţ���45Ϊ���������ʱ�̱�ʱ�䣬67Ϊ������һ�����Ӧʱ��,89Ϊ������һ����Ķ�Ӧʱ��
%   sΪ����ֵ��ֵΪ1ʱ˵����׼�㣬2˵�����������
    %��ȡtimetable����ȡ��timetable��
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
    %�õ��������ڸ����˳���µ�ʱ�̱�һ��Ϊ4~6�˰���,��������8��
    %��bus_time����
    %��һ��Ϊ���ƺţ���45Ϊ���������ʱ�̱�ʱ�䣬67Ϊ������һ�����Ӧʱ��,89Ϊ������һ����Ķ�Ӧʱ��
    len=length(timetable);
    bus_time=zeros(8,9);
    bus_time(:,1)=bus;
    k=0;%��bus_time����
    for i = 1: len
        if timetable(i,1)==bus
            k=k+1;
            bus_time(k,:)=timetable(i,:);           
        end
    end
    
    %�����ݽ����жϣ�������ֵs��s��ֵΪ0������ֵΪ1ʱ˵����׼�㣬2˵����������� 
    s=0;
    for i=1:k
        if time < bus_time(i,7) && time > bus_time(i,6)
            s=1;
        end
    end
    %��ʱ�̱��жϺ�û�з��ϵĶ�Ӧʱ�̣���ð������������
    if s==0
        s=2
    end
end

