clc;
clear all;
[num,text,raw]= xlsread('1.xlsx','XQ');
len=length(num);

%%�޳���·��1��3 9 15��2��4 10 16��3��5 11 17�� �ֱ�Ϊ�ٶ� ���� ռ����
%%4��6 12 18��  5��7 13 19�� 6��8 14 20��
% a�������ڴ洢��������
a=zeros(len,20);
% b�������ڱ��ԭ���� 
b1=zeros(len,18);
b2=zeros(len,18);
b=zeros(len,18);
%
c=zeros(1,24);
%sum1-�����ж�  sum2������׼�� sum4-��
sum1=0;
sum2=0;
sum4=0;
sum=0;
 %%�����ж� �÷����жϳ����ܸ���Ϊsum1 b1�����ԭ���ݽ��б�� ���ϵ���Ϊ�������ٶȡ�ռ���ʵ��ж�
   for i=1:len
       for j=9:14
        if isnan(num(i,j))==1
            b1(i,j-2)=1;
            sum4=sum4+1;
        elseif num(i,j)<0
           sum1=sum1+1;
           a(sum1,1:2)=num(i,1:2);
           a(sum1,j)=num(i,j);
           b1(i,j-2)=1;
           num(i,j)=9999;
        elseif num(i,j)>255
           sum1=sum1+1;
           a(sum1,1:2)=num(i,1:2);
           a(sum1,j)=num(i,j);
           b1(i,j-2)=1;
            num(i,j)=9999;
         end
            end
        end

   for i=1:len
        for j=3:8
        if isnan(num(i,j))==1
            b1(i,j-2)=1;
            sum4=sum4+1;
        elseif num(i,j)<0
           sum1=sum1+1;
           a(sum1,1:2)=num(i,1:2);
           a(sum1,j)=num(i,j);
           b1(i,j-2)=1;
           num(i,j)=9999;
        elseif num(i,j)>1.5*60
           sum1=sum1+1;
           a(sum1,1:2)=num(i,1:2);
           a(sum1,j)=num(i,j);
           b1(i,j-2)=1;
            num(i,j)=9999;
                end
            end
        end

   for i=1:len
       for j=15:20
        if isnan(num(i,j))==1
            b1(i,j-2)=1;
            sum4=sum4+1;
        elseif num(i,j)<0
           sum1=sum1+1;
           a(sum1,1:2)=num(i,1:2);
           a(sum1,j)=num(i,j);
           b1(i,j-2)=1;
           num(i,j)=9999;
        elseif num(i,j)>0.8
           sum1=sum1+1;
           a(sum1,1:2)=num(i,1:2);
           a(sum1,j)=num(i,j);
           b1(i,j-2)=1;
            num(i,j)=9999;
                end
            end
   end
%%������׼�
threemean=[43.8 50.5 44.5 38.4 40.6 56.9 118.7 113.4 115.4 110.3 109.5 113.8];
threestd=[6.25 3.65 7.91 4.46 8.01 1.06 23.69 25.35 25.49 25.36 25.15 26.89];
sum2=0;
for i=1:len
    for j=3:8
    if num(i,j)<(threemean(1,j-2)-3*threestd(1,j-2))
        b2(i,j-2)=1;
        num(i,j)=9999;
        sum2=sum2+1;
    elseif num(i,j)>(threemean(1,j-2)+3*threestd(1,j-2))
        b2(i,j-2)=1;
        sum2=sum2+1;
          num(i,j)=9999;
    end
    if num(i,j+6)<(threemean(1,j+6-2)-3*threestd(1,j+6-2))
        b2(i,j-2+6)=1;
          num(i,j)=9999;
        sum2=sum2+1;
    elseif num(i,j+6)>(threemean(1,j+6-2)+3*threestd(1,j+6-2))
        b2(i,j-2+6)=1;
          num(i,j)=9999;
        sum2=sum2+1;
    end
    end
end
xlswrite('tichu',num);

%%%%��ȱ
for i=1:5
    for j=3:20
        if isnan(num(i,j)==1)
             num(i,j)=(num(i-1,j)+num(i+1,j))/2
        end
    end
end
for i=6:len
    for j=3:20
    if isnan(num(i,j))==1
        num(i,j)=1/15*(5*num(i-1,j)+4*num(i-2,j)+3*num(i-3,j)+2*num(i-4,j)+num(i-5,j));
    end
    if num(i,j)==9999
        num(i,j)=1/15*(5*num(i-1,j)+4*num(i-2,j)+3*num(i-3,j)+2*num(i-4,j)+num(i-5,j));
    end
    end
end
xlswrite('buque',num);
