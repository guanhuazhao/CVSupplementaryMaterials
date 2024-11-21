clc;
clear all;
[num,text,raw]= xlsread('task6.xlsx','Sheet1');
len=length(num);
cunchu=zeros(6,48);
%以处理路段一的过程为例
%训练集-120个，前10小时
input_train1(1,1:120)=num(1:120,3)';
input_train1(2,1:120)=num(1:120,9)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,16)';
%测试集-48个，后4小时
input_test1(1,1:48)=num(121:168,3)';
input_test1(2,1:48)=num(121:168,9)';
input_test1(3,1:48)=num(121:168,15)';
%样本数据归一化 min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%创建网络
%隐含层神经元/节点个数，可以更改，要测试结果影响
a=5;
net=newff(inputn,outputn,a);
%设置训练参数,依次为迭代次数、设置目标值（mse）、
%lr===学习率(学习率越大，输出误差对参数的影响就越大，参数更新的越快，同时受到异常数据的影响就越大，很容易发散)
%学习率要比较得到
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%网络训练
net=train(net,inputn,outputn);

%预测数据归一化
inputn_test=mapminmax('apply',input_test1,inputps);
%网络预测输出
an=sim(net,inputn_test);
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);

%计算MAPE
real=num(121:168,16)';
mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('真实值','预测值')
xlabel('预测样本')
ylabel('路段一平均行程速度km/h')
string = {'测试集路段一平均行程速度预测结果对比';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(1,:)=BPoutput;


%%路段二
%训练集-120个，前10小时
input_train1(1,1:120)=num(1:120,4)';
input_train1(2,1:120)=num(1:120,10)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,17)';
%测试集-48个，后4小时
input_test1(1,1:48)=num(121:168,4)';
input_test1(2,1:48)=num(121:168,10)';
input_test1(3,1:48)=num(121:168,15)';
%样本数据归一化 min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%创建网络
%隐含层神经元/节点个数，可以更改，要测试结果影响
a=5;
net=newff(inputn,outputn,a);
%设置训练参数,依次为迭代次数、设置目标值（mse）、
%lr===学习率(学习率越大，输出误差对参数的影响就越大，参数更新的越快，同时受到异常数据的影响就越大，很容易发散)
%学习率要比较得到
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%网络训练
net=train(net,inputn,outputn);

%预测数据归一化
inputn_test=mapminmax('apply',input_test1,inputps);
%网络预测输出
an=sim(net,inputn_test);
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);

%计算MAPE
real=num(121:168,17)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('真实值','预测值')
xlabel('预测样本')
ylabel('路段二平均行程速度km/h')
axis([0 50,10,55]);
string = {'测试集路段二平均行程速度预测结果对比';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(2,:)=BPoutput;

%%路段三
%训练集-120个，前10小时
input_train1(1,1:120)=num(1:120,5)';
input_train1(2,1:120)=num(1:120,11)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,18)';
%测试集-48个，后4小时
input_test1(1,1:48)=num(121:168,5)';
input_test1(2,1:48)=num(121:168,11)';
input_test1(3,1:48)=num(121:168,15)';
%样本数据归一化 min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%创建网络
%隐含层神经元/节点个数，可以更改，要测试结果影响
a=5;
net=newff(inputn,outputn,a);
%设置训练参数,依次为迭代次数、设置目标值（mse）、
%lr===学习率(学习率越大，输出误差对参数的影响就越大，参数更新的越快，同时受到异常数据的影响就越大，很容易发散)
%学习率要比较得到
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%网络训练
net=train(net,inputn,outputn);

%预测数据归一化
inputn_test=mapminmax('apply',input_test1,inputps);
%网络预测输出
an=sim(net,inputn_test);
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);

%计算MAPE
real=num(121:168,18)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
figure
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('真实值','预测值')
xlabel('预测样本')
ylabel('路段三平均行程速度km/h')
axis([0 50,10,55]);
string = {'测试集路段三平均行程速度预测结果对比';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(3,:)=BPoutput;


%%路段4
%训练集-120个，前10小时
input_train1(1,1:120)=num(1:120,6)';
input_train1(2,1:120)=num(1:120,12)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,19)';
%测试集-48个，后4小时
input_test1(1,1:48)=num(121:168,6)';
input_test1(2,1:48)=num(121:168,12)';
input_test1(3,1:48)=num(121:168,15)';
%样本数据归一化 min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%创建网络
%隐含层神经元/节点个数，可以更改，要测试结果影响
a=5;
net=newff(inputn,outputn,a);
%设置训练参数,依次为迭代次数、设置目标值（mse）、
%lr===学习率(学习率越大，输出误差对参数的影响就越大，参数更新的越快，同时受到异常数据的影响就越大，很容易发散)
%学习率要比较得到
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%网络训练
net=train(net,inputn,outputn);

%预测数据归一化
inputn_test=mapminmax('apply',input_test1,inputps);
%网络预测输出
an=sim(net,inputn_test);
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);

%计算MAPE
real=num(121:168,19)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
figure
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('真实值','预测值')
xlabel('预测样本')
ylabel('路段四平均行程速度km/h')
axis([0 50,10,55]);
string = {'测试集路段四平均行程速度预测结果对比';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(4,:)=BPoutput;

%%路段5
%训练集-120个，前10小时
input_train1(1,1:120)=num(1:120,7)';
input_train1(2,1:120)=num(1:120,13)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,20)';
%测试集-48个，后4小时
input_test1(1,1:48)=num(121:168,7)';
input_test1(2,1:48)=num(121:168,13)';
input_test1(3,1:48)=num(121:168,15)';
%样本数据归一化 min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%创建网络
%隐含层神经元/节点个数，可以更改，要测试结果影响
a=5;
net=newff(inputn,outputn,a);
%设置训练参数,依次为迭代次数、设置目标值（mse）、
%lr===学习率(学习率越大，输出误差对参数的影响就越大，参数更新的越快，同时受到异常数据的影响就越大，很容易发散)
%学习率要比较得到
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%网络训练
net=train(net,inputn,outputn);

%预测数据归一化
inputn_test=mapminmax('apply',input_test1,inputps);
%网络预测输出
an=sim(net,inputn_test);
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);

%计算MAPE
real=num(121:168,20)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('真实值','预测值')
xlabel('预测样本')
ylabel('路段五平均行程速度km/h')
axis([0 50,10,55]);
string = {'测试集路段五平均行程速度预测结果对比';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(5,:)=BPoutput;

%%路段6
%训练集-120个，前10小时
input_train1(1,1:120)=num(1:120,8)';
input_train1(2,1:120)=num(1:120,14)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,21)';
%测试集-48个，后4小时
input_test1(1,1:48)=num(121:168,8)';
input_test1(2,1:48)=num(121:168,14)';
input_test1(3,1:48)=num(121:168,15)';
%样本数据归一化 min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%创建网络
%隐含层神经元/节点个数，可以更改，要测试结果影响
a=5;
net=newff(inputn,outputn,a);
%设置训练参数,依次为迭代次数、设置目标值（mse）、
%lr===学习率(学习率越大，输出误差对参数的影响就越大，参数更新的越快，同时受到异常数据的影响就越大，很容易发散)
%学习率要比较得到
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%网络训练
net=train(net,inputn,outputn);

%预测数据归一化
inputn_test=mapminmax('apply',input_test1,inputps);
%网络预测输出
an=sim(net,inputn_test);
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);

%计算MAPE
real=num(121:168,21)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('真实值','预测值')
xlabel('预测样本')
ylabel('路段六平均行程速度km/h')
axis([0 50,10,65]);
string = {'测试集路段六平均行程速度预测结果对比';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(6,:)=BPoutput;

%输出结果
xlswrite('rongheresult',cunchu);