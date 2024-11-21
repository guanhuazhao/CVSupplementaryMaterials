%%��������
[num,text,raw]=xlsread('s.xlsx');
data=num;
%         %��6-21-0����Ϊ�� 
%         %ѡ��ԭʼGPS����
%         temp=data(11386:11869,:);
%         dot_num=length(temp);
        %��6-1-0����Ϊ�� 
        %ѡ��ԭʼGPS����
        temp=data(:,2:6);
        dot_num=length(temp);
%�����׼�����������׼վ��
[num,text,raw]=xlsread('rectangle_shang.xlsx');
recshang=num;
[num,text,raw]=xlsread('jizhun.xls');
standard=num(:,1:4);
rec_num=length(recshang);
%�ж�GPS���Ƿ񱻶�����ο�ѡ
%��Ҫ�жϵĵ���p%%%%%%%%%%%%%%��,һ����dot_num����
    p=temp(:,1:2);
    x=p(:,1);
    y=p(:,2);
    %��ÿ������(rec_num=110��)���п�ѡ�жϣ����ۻ�,��table��¼ ��Ϊ���� ��Ϊ��  
    table=zeros(dot_num,rec_num);
    for j = 1: rec_num
        %������
        xv=[recshang(j,1) recshang(j,3) recshang(j,5) recshang(j,7) recshang(j,1)];
        yv=[recshang(j,2) recshang(j,4) recshang(j,6) recshang(j,8) recshang(j,2)];
        in=inpolygon(x,y,xv,yv);%in=0-���ⲿ in=1-���ڲ����Ե
        table(:,j)=in;
    end
    %����ÿ�����Ӧ�ľ��θ�������ʹ��rec_flag��¼�����ĸ�����֮��
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
    r = 6367000; %����İ뾶
    %���ȣ���������1"=30.887m��
    %γ�ȣ��ϱ�����1"=30.887m*cos((31.2428378+31.2739215)/2)=30.504m
    cos=0.85483599;
    lon=30.887;
    lat=26.395;
    %��times���������¼���ݵ�a��������,��road��¼��Ӧ·�ε���ʼ�㣬��road=0ʱ��˵����·��Ӧ�ñ�ɾ��
    road=zeros(dot_num,1);
    
    h=waitbar(0,'�����У����Ժ�!');
    for i=1:dot_num
       a=temp(i,1:2);%%%a�����ݵ�ľ�γ������
        %0
        if times(i,1)==0
            %������standard��ľ��룬distanceΪ�����ƽ��
            distance=zeros(standard_num,1);
            for j =1:standard_num
                %���ݵ�a��temp����׼��b��standard
                b=standard(j,1:2);
                distance(j,1)=((b(1,2)-a(1,2))*3600*lat)^2 + ((b(1,1)-a(1,1))*3600*lon)^2;
                if distance(j,1) <= 2500
                    times(i,2:3)=standard(j,1:2);
                    road(i,1)=j;
                else
                    road(i,1)=999;
                end                 
            end
            %��times(:,1:3)=(0 0 0)/road(i,1)=999ʱ˵��������Ӧ��ɾ��
        end
        
        %1
        if times(i,1)==1
            %�ҵ����ݵ��Ӧ����
            t=rec_flag(i,1);
            %��ö�Ӧ·�εĶ˵�(x1,y1)(x2,y2),���ݵ�(x3,y3)
            x1=standard(t,1);
            y1=standard(t,2);
            x2=standard(t+1,1);
            y2=standard(t+1,2);
            x3=a(1,1);
            y3=a(1,2);
            %�����·���ϵ�ͶӰλ��
            p = get_footpoint(x1,y1,x2,y2,x3,y3);
            times(i,2:3)=p(1,1:2);
            road(i,1)=t;
        end
        %n
       if times(i,1)>1
            %�ҵ����ݵ��Ӧ����
            l=times(i,1);
            %��ÿ��·�ν���ͶӰ���ȼ������в�����
            shadow=zeros(l,3);
            for j=1:l
                t=rec_flag(i,j);
                %��ö�Ӧ·�εĶ˵�(x1,y1)(x2,y2),���ݵ�(x3,y3)
                x1=standard(t,1);
                y1=standard(t,2);
                x2=standard(t+1,1);
                y2=standard(t+1,2);
                x3=a(1,1);
                y3=a(1,2);
                p = get_footpoint(x1,y1,x2,y2,x3,y3);
                shadow(j,:)=p;
                %shadow(j,3)�����Ӧ������ʼ����
                shadow(j,3)=t;
            end
            %ѡ��ͶӰ��̵�·��:�����һ����С�����ϱȽ�
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
            %��ʱminȷʵΪ��С����ֵ
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
title("�ζ�104·����9��6��1-0�ι켣ͼ");

%������ѡ��ľ���·����ʼ��λ��road����Ϊ���road
xlswrite('0907s.xlsx',temp);
xlswrite('road_s.xlsx',road);
xlswrite('0907srecflag.xlsx',rec_flag);