%�������վ��Ϣ 
%stan_s ��stan_x�ĵ����д����վ��Ϣ �����д����վ��Ϣ
%stan_s��stan_x�����е�һ��Ϊ0�������еڶ���Ϊ0

%�����������ݻ���
[num,text,raw]=xlsread('jizhun.xls');
stan_s=num;
stan_s_num=length(stan_s);
%�����վ�㵽��ʼ��ľ��룬������stan_s������
%stan_s����4��=1Ϊվ�� 2Ϊ����� 3Ϊ�м��
%�鿴�ж��ٸ�վ�㣬������ʼվ���յ�վ
% k=0
% for i= 1:stan_s_num
%     if stan_s(i,4)==1
%         k=k+1;
%     end
% end
%����24��վ�㣬kΪվ�����
%ȷ��ÿ�����ݵ������ʼվ���ۼ��г̾���,������stan_s�����У���һվΪ0
stan_s(1,6)=0;
L=0;
for i=2:stan_s_num
    L=L+stan_s(i-1,5);
    stan_s(i,6)=L;
end
%ȡ�����е�վ�����ݣ�������zhan��
%zhan 12Ϊ��γ�� 3Ϊ������� 4Ϊ������ʼ�����
%
k=0
zhan_s=zeros(24,4);
for i=1:stan_s_num
    if stan_s(i,4)==1
        k=k+1;
        zhan_s(k,1:2)=stan_s(i,1:2);
        zhan_s(k,3)=stan_s(i,4);
        zhan_s(k,4)=stan_s(i,6);
    end
end
xlswrite('zhan_s',zhan_s);

%%��09060100Ϊ�����������Ϣ
%12��γ�� 3λ�ۻ��г̾��� 4Ϊʱ��
[num,text,raw]=xlsread('xiufu.xls');
temp=num;
temp_num=length(temp);
%Ѱ�ҽ�վ��2-24������վ���GPS�켣�����ݼ�¼��zhan56��֮��9��¼��i
%��һ��վ��56��Ϊ0,��temp��5���н��б�ǣ�5Ϊ0��ʾΪ�м�㣬1Ϊ��վ�� 2Ϊ��վ��
zhan_s(1,5)=0;
zhan_s(1,6)=0;
x=2;
for i =1:temp_num
    s=(zhan_s(x,4)-temp(i,3))*1000;
    if s<=25 
        zhan_s(x,5:6)=temp(i,1:2);%�ҵ���վ��
        temp(i,5)=1;
        zhan_s(x,9)=i;
        x=x+1;%��x���и��£�Ѱ����һ��վ�Ľ�վ��
    end
    %�����վ�����޸�
end

%Ѱ�ҳ�վ��1-23��78�о���10��10��¼��i
y=2;
zhan_s(24,7)=0;
zhan_s(24,8)=0;
for i =1:temp_num-1
    s=(temp(i,3)-zhan_s(y,4))*1000;%�õ�
    s1=(temp(i+1,3)-zhan_s(y,4))*1000 %��һ����  
    if s<=25 && s1>25%���õ�<25����һ����>25ʱ���õ�Ϊ�����վʻ����ֵ��Χ����Զ�ĵ�
        zhan_s(y,7:8)=temp(i,1:2);%�ҵ���վ��
        zhan_s(y,10)=i;
        temp(i,5)=2;
        y=y+1;%��y���и��£�Ѱ����һ��վ�ĳ�վ��
    end
    %�����վ�����޸�
end

k1=0;
k2=0;
%��ͼ����վΪ��* ��վΪ����
plot(temp(:,4),temp(:,3));
hold on
for i= 1:temp_num
    if temp(i,5)==1
        k1=k1+1;
        scatter(temp(i,4),temp(i,3),'r','*');
    else if temp(i,5)==2
            k2=k2+1;
            scatter(temp(i,4),temp(i,3),'b','*');
        end
    end
end
hold on
for i = 1:24
    y=zhan_s(i,4);
    line([0.3800 0.4323],[y y],'Color','yellow','LineStyle','--');
    hold on;
end
xlabel('ʱ��');
ylabel('�г̾���');
title('�������ݻ�����ʱ�չ켣ͼ');



%�����������ݻ���
[num,text,raw]=xlsread('mapxia.xlsx');
stan_x=num;
