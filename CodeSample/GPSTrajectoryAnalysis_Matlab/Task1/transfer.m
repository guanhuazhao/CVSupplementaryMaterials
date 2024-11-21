%��ȡ��Ϣ
[num,text,raw]=xlsread('0906010.xlsx');
temp=num;
[num,text,raw]=xlsread('mapshang.xlsx');
standard=num;
[num,text,raw]=xlsread('090610recflag.xlsx');
rec_flag=num;
[num,text,raw]=xlsread('090610road.xlsx');
road=num;

%�õ���׼����� 
jizhun=standard;
jizhun_num=length(jizhun);
%�����׼��֮�����,jizhun_num���㣬jizhun_num-1������,
%���봢����jizuhn(i,5)��֮��
r=6371.004;
for i=1:(jizhun_num-1)
    jizhun(i,5)=distance(jizhun(i,2),jizhun(i,1),jizhun(i+1,2),jizhun(i+1,1),r);
end

%����ÿ�����ݵ��ͶӰ�������һ����׼��֮��ľ��룬������temp8��
%��һ����׼����road�ֶεõ�,��road=999�������ݵ�Ӧ�ñ�ɾ���������Ϊ0
temp_num=length(temp);
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
end

%�������ݵ㵽��ʼ��ľ���D��LΪ·����㵽��ʼ��ľ��룬
%D������temp(��,9)��
for i =1 :temp_num
    if road(i,1)==999
        temp(i,9)=0
    else
        %��·����㵽��ʼ��ľ���
        L=0
        for j=1:(road(i,1)-1)
            L=L+jizhun(j,5);
        end
        D=L+temp(i,8);        
        temp(i,9)=D;
    end
end

%����ʱ��ͼ�켣
%��ȡʱ��
[num,text,raw]=xlsread('0906_new_gps.xlsx');
time=num(1:temp_num,1);
subplot(2,1,1);
plot(time,temp(:,9));
xlabel('ʱ��');
ylabel('�г̾���');
title('9��6�ռζ�104·������һ�೵����ʱ�չ켣ͼ');
subplot(2,1,2);
plot(time,temp(:,9));
xlabel('ʱ��');
ylabel('�г̾���');
title('9��6�ռζ�104·������һ�೵����ʱ�չ켣ͼ');
hold on 
for i = 2 : temp_num
    if temp(i,9)<temp(i-1,9)
        scatter(time(i,1),temp(i,9),'r','*');
    end
end

%%��flag���б��
%flag��ʼֵΪ0
%��flag=1ʱ��˵���õ�Ϊ�쳣���ݣ���Ҫ��������
%��flag=2ʱ��˵������������Ҫɾ��
flag=zeros(temp_num,1);
time_cha=zeros(temp_num,1);
%���ڴ���time_cha ���������������
%��1,1��Ϊ�������ݣ���i��1��Ϊ��i������ǰһ�����ʱ���
for i = 2:temp_num
    %Ư�ƾ������50m��������Ҫɾ��
    if temp(i,9)==0
        flag(i,1)=2;
    else
         %����Ϊ��
        s=temp(i,9)-temp(i-1,9);
        if s<0
             flag(i,1)=1;
        end
    %���ٳ���80km/h
        time_cha(i,1)=(time(i,1)-time(i-1,1))*86400;
        v=s*1000/time_cha(i,1);
        if  v*3.6>80
            flag(i,1)=1;
        end
    end
end
%b=time(2,1)-time(1,1);
%a=datestr(b,'HH:MM:SS')


%%��������
%����ÿ����Ŀ�ƥ��·�θ���,������flag(:,2)֮��
for i= 1:temp_num
    d=0;
    for j=1 :4
        if rec_flag(i,j)~=0
            d=d+1
        end
    end
    flag(i,2)=d;
end

%�鿴�Ƿ���ڿ�ѡ����·��
%
for i=1:temp_num
    %�����쳣��
    if( flag(i,1)==1 )&& (flag(i,2)==1)
         %�����ڱ���·��ʱ������ת��Ϊ��Ҫɾ����ƥ���
        flag(i,1)=2
    end
    if ( flag(i,1)==1 )&& (flag(i,2)>1)
        %���ڱ���·��
        t=flag(i,2);%����·�θ���    
        %����ʣ�౸��·��
        if t==2     %����һ������·��
             a=temp(i,1:2);%%%a�����ݵ�ľ�γ������

             %�õ���ͶӰ��
             new_rec=rec_flag(i,2);  %��·�ζ�Ӧ�������
             x1=standard(new_rec,1);
             y1=standard(new_rec,2);
             x2=standard(new_rec+1,1);
             y2=standard(new_rec+1,2);
             x3=a(1,1);
             y3=a(1,2);     
              %�õ��µ��ͶӰ�������봹�����
              %p��1,1:2��Ϊ���꣬p��1,3��Ϊ����
             p = get_footpoint(x1,y1,x2,y2,x3,y3);

              %�ж��µĵ��Ƿ����쳣��λ,1���쳣��2�쳣��TFΪ�жϺ���
             dis_lastnode=temp(i-1,9);
             TF=yichang(p(1,1),p(1,2),time_cha(i,1),dis_lastnode,new_rec,jizhun);
             if TF(1,1)==1            
                %���쳣�����ͶӰ������,����flag���
                temp(i,6:7)=p(1,1:2);
                temp(i,9)=TF(1,2);
                flag(i,1)=0;
             else 
                flag(i,1)=2 %��Ȼ�쳣��û�б�����·�ˣ�����ƥ���ɾ��            
             end         
        end  
                
        if t==3     %������������·��
             a=temp(i,1:2);%%%a�����ݵ�ľ�γ������

             %�õ���ͶӰ��
             new_rec=rec_flag(i,2);  %��·�ζ�Ӧ�������
             x1=standard(new_rec,1);
             y1=standard(new_rec,2);
             x2=standard(new_rec+1,1);
             y2=standard(new_rec+1,2);
             x3=a(1,1);
             y3=a(1,2);     
              %�õ��µ��ͶӰ�������봹�����
              %p��1,1:2��Ϊ���꣬p��1,3��Ϊ����
             p = get_footpoint(x1,y1,x2,y2,x3,y3);

              %�ж��µĵ��Ƿ����쳣��λ,1���쳣��2�쳣��TFΪ�жϺ���
             dis_lastnode=temp(i-1,9);
             TF=yichang(p(1,1),p(1,2),time_cha(i,1),dis_lastnode,new_rec,jizhun);
             if TF(1,1)==1            
                %���쳣�����ͶӰ������
                temp(i,6:7)=p(1,1:2);
                temp(i,9)=TF(1,2);
                flag(i,1)=0;
             else 
                %��Ȼ�쳣��ѡ��ڶ���������·       
                 new_rec=rec_flag(i,3);  %��·�ζ�Ӧ�������
                 x1=standard(new_rec,1);
                 y1=standard(new_rec,2);
                 x2=standard(new_rec+1,1);
                 y2=standard(new_rec+1,2);
                 x3=a(1,1);
                 y3=a(1,2);     
                  %�õ��µ��ͶӰ�������봹�����
                  %p��1,1:2��Ϊ���꣬p��1,3��Ϊ����
                 p = get_footpoint(x1,y1,x2,y2,x3,y3);

                  %�ж��µĵ��Ƿ����쳣��λ,1���쳣��2�쳣��TFΪ�жϺ���
                 dis_lastnode=temp(i-1,9);
                 TF=yichang(p(1,1),p(1,2),time_cha(i,1),dis_lastnode,new_rec,jizhun);
                 if TF(1,1)==1
                     temp(i,6:7)=p(1,1:2);
                     temp(i,9)=TF(1,2);
                     flag(i,1)=0;
                 else
                     flag(i,1)=2 %��Ȼ�쳣��û�б�����·�ˣ�����ƥ���ɾ��    
                 end
             end 
             
        end
    end
end

 
 %���»�ͼ,lujing���������� 12��γ�� 3λ�ۻ��г̾��� 4Ϊʱ��
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
xlabel('ʱ��');
ylabel('�г̾���');
title('����������ʱ�չ켣ͼ');
subplot(2,1,2);
plot(time,temp(:,9));
xlabel('ʱ��');
ylabel('�г̾���');
title('��ͼƥ���ʱ�չ켣ͼ');
hold on 
for i = 2 : temp_num
    if temp(i,9)<temp(i-1,9)
        scatter(time(i,1),temp(i,9),'r','*');
    end
end

%Ϊ���㴢�� ��temp(:,10)Ϊflag,temp(:,11)Ϊʱ�䣬����temp,
temp(:,10)=flag(:,1);
temp(:,11)=time(:,1);
xlswrite('xiuzheng2',temp);
%�����ڲ����ݣ�����lujing
xlswrite('lujing2',lujing);
%�����׼�㵽��һ����׼��֮��ľ���
xlswrite('jizhun',jizhun);