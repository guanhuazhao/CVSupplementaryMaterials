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
%lujing 12��γ�� 3λ�ۻ��г̾��� 4Ϊʱ��
%�ж������޸���λ�ò����������ڲ��޸�
%ʱ���>30s��������50m
%��xiufu�����޸�������ݣ�������k����
xiufu=zeros(500,4);
xiufu(1,:)=temp(1,:);
k=1;
for i=2:temp_num
    time_cha=(temp(i,4)-temp(i-1,4))*86400;%s
    dis_cha=(temp(i,3)-temp(i-1,3))*1000;%m
    if time_cha >30%�ж�ʱ���
        k=k+1;
        xiufu(k,:)=1/2*(temp(i,:)+temp(i-1,:));
        %����ԭ������
        k=k+1;
        xiufu(k,:)=temp(i,:);
    else if dis_cha>50 %�жϾ����
            k=k+1;
            xiufu(k,:)=1/2*(temp(i,:)+temp(i-1,:));
            %����ԭ������
            k=k+1;
            xiufu(k,:)=temp(i,:);
        end
    end 
    %������Ҫ��
    if time_cha<=30 && dis_cha<=50
        k=k+1;
        xiufu(k,:)=temp(i,:);
    end
end
xlswrite('xiufu',xiufu);