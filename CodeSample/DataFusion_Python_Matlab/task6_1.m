[num,text,raw]= xlsread('task6.xlsx','Sheet1');
len=length(num);
time=[30.52,29.99,31.86,31.25,31.13,0];
time=time/3600;
lda=[507,687,490,600,267,417]/1000;
ldk=[103,87,73,95,69,253]/1000;
ldqt=lda-ldk;
new_xianquan=zeros(len,6);
new_xianquan(:,6)=num(:,8);
real=zeros(len,6);
real=num(:,16:21);
bili=linspace(1.1,4,30);
cha=zeros(30,1);
for x=1:30
    for i=1:len
      for j=1:5
        new_xianquan(i,j)=lda(1,j)/(ldqt(1,j)/num(i,j+2)+time(1,j)/bili(1,x));
      end
    end
    a=new_xianquan(:,1)-real(:,1);
    cha(x,1)=std(a,0);
end
plot(bili,cha);
for i=1:len
    for j=1:5
        new_xianquan(i,j)=lda(1,j)/(ldqt(1,j)/num(i,j+2)+time(1,j)/2)
    end
end
plot(1:len,real(:,1));
hold on
plot(1:len,new_xianquan(:,1));
hold on
plot(1:len,num(:,3));
legend('真实行程速度','新线圈速度','原始线圈速度');
xlabel('时间');
ylabel('速度 km/h');
title('与交叉口信控延误融合后路段一平均行程速度示例');
xlswrite('new_xianquan',new_xianquan);