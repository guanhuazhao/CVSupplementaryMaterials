%����ʱ�չ켣
%��ȡ��Ϣ
[num,text,raw]=xlsread('0907s.xlsx');
temp=num;%1ʱ�� 23��γ��
[num,text,raw]=xlsread('jizhun.xls'); %12��γ�� 3�� 4��Χ 5��׼��֮�����
jizhun=num;
[num,text,raw]=xlsread('rectangle_shang.xlsx'); 
rec_tangle=num;

[num,text,raw]=xlsread('road_s.xlsx');
road=num;
temp_num=length(temp);
%����ÿ�����ݵ��ͶӰ�������һ����׼��֮��ľ��룬������temp8��
%��һ����׼����road�ֶεõ�,��road=999�������ݵ�Ӧ�ñ�ɾ���������Ϊ0

r=6371.004;
h=waitbar(0,'�����У����Ժ�!');
len=temp_num
for i= 1:temp_num
    t=road(i,1);%��Ӧ·�����
    if t~=999
        lat=temp(i,7);
        lon=temp(i,6);%ͶӰ��
        x=jizhun(t,1);
        y=jizhun(t,2);%���
        temp(i,8)=distance(y,x,lat,lon,r);
    else
        temp(i,8)=0
    end
    str=['�����С�',num2str(100*i/len),'%'];
    waitbar(i/len,h,str);
end
  close(h);
xlswrite('s_dis_GPS2JZ',temp(:,8));  




%�������ݵ㵽��ʼ��ľ���D��LΪ·����㵽��ʼ��ľ��룬
%D������temp(��,9)��
[num,text,raw]=xlsread('0907s.xlsx');
temp=num;%1ʱ�� 23��γ��
[num,text,raw]=xlsread('jizhun.xls'); %12��γ�� 3�� 4��Χ 5��׼��֮�����
jizhun=num;
[num,text,raw]=xlsread('rectangle_shang.xlsx'); 
rec_tangle=num;
[num,text,raw]=xlsread('road_s.xlsx');
road=num;
temp_num=length(temp);
[num,text,raw]=xlsread('s_dis_GPS2JZ.xls');
temp(:,8)=num;


%��ÿ���㵽��ʼ����ۼƾ��룬������jizhun(:,6)֮��
jizhun(1,6)=0;
for i=2:length(jizhun)
    jizhun(i,6)=jizhun(i-1,6)+jizhun(i-1,5);
end
xlswrite('jizhun_s',jizhun);

xlswrite('temp_1-8',temp);

%%%^^^^^^^^�����￪ʼ��
[num,text,raw]=xlsread('road_s.xlsx');
road=num;
[num,text,raw]=xlsread('temp_1-8.xls');
temp=num;
temp_num=length(temp);%8Ϊ����һ����׼��ľ���
[num,text,raw]=xlsread('jizhun_s.xls'); %12��γ�� 3�� 4��Χ 5��׼��֮����� 6����ʼ�����
jizhun=num;

h=waitbar(0,'�����У����Ժ�!');
len=temp_num;
%��һ�������Ϊ0
temp(1,9)=0;
for i =2 :temp_num
    if road(i,1)==999   %%999������ɾ�� �����Ϊ0
        temp(i,9)=0
    else
        %����=dot�������׼�����+�û�׼�㵽��ʼ�����
        k=road(i,1);
        D=jizhun(k,6)+temp(i,8);        
        temp(i,9)=D;
    end
    str=['�����С�',num2str(100*i/len),'%'];
    waitbar(i/len,h,str);
end
  close(h);
  xlswrite('temp_1-9',temp);
 
  %��ȡʱ��
[num,text,raw]=xlsread('07st.xlsx');
time=num(:,1);
h=waitbar(0,'�����У����Ժ�!');
color=['b';'g';'r';'c';'m';'y';'k'];
color_num(:,1)=color(mod(temp(:,5),7)+1,1);

figure;
h=waitbar(0,'�����У����Ժ�!');
for i = 1:temp_num
    if temp(i,9)~=0
        scatter(time(i,1),temp(i,9),color_num(i,1),'.');
        hold on
    end
    str=['�����С�',num2str(100*i/len),'%'];
    waitbar(i/len,h,str);
end
 close(h);

xlabel('ʱ��');
ylabel('����ʼ��վ�ľ���/km');
title('9��7��104·������������ʱ��ͼ');
set(gca,'XLim',[4*1/24 23/24]);
datetick('x',13);
