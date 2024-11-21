[num,text,raw]=xlsread('lujing2');
temp=num;
len=length(temp);
t=0;
for i = 1:len
    if temp(i,1)~=0
        t=t+1;
    end
end
temp_num=t;
%lujing 12经纬度 3位累积行程距离 4为时间
%判断数据修复的位置并利用线性内插修复
%时间差>30s或距离大于50m
%用xiufu储存修复后的数据，并利用k计数
xiufu=zeros(500,4);
xiufu(1,:)=temp(1,:);
k=1;
for i=2:temp_num
    time_cha=(temp(i,4)-temp(i-1,4))*86400;%s
    dis_cha=(temp(i,3)-temp(i-1,3))*1000;%m
    if time_cha >30%判断时间差
        k=k+1;
        xiufu(k,:)=1/2*(temp(i,:)+temp(i-1,:));
        %插入原来数据
        k=k+1;
        xiufu(k,:)=temp(i,:);
    else if dis_cha>50 %判断距离差
            k=k+1;
            xiufu(k,:)=1/2*(temp(i,:)+temp(i-1,:));
            %插入原来数据
            k=k+1;
            xiufu(k,:)=temp(i,:);
        end
    end 
    %均满足要求
    if time_cha<=30 && dis_cha<=50
        k=k+1;
        xiufu(k,:)=temp(i,:);
    end
end
xlswrite('xiufu',xiufu);