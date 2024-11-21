clc;
clear all;
[num,text,raw]= xlsread('task6.xlsx','Sheet1');
len=length(num);
cunchu=zeros(6,48);
%�Դ���·��һ�Ĺ���Ϊ��
%ѵ����-120����ǰ10Сʱ
input_train1(1,1:120)=num(1:120,3)';
input_train1(2,1:120)=num(1:120,9)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,16)';
%���Լ�-48������4Сʱ
input_test1(1,1:48)=num(121:168,3)';
input_test1(2,1:48)=num(121:168,9)';
input_test1(3,1:48)=num(121:168,15)';
%�������ݹ�һ�� min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%��������
%��������Ԫ/�ڵ���������Ը��ģ�Ҫ���Խ��Ӱ��
a=5;
net=newff(inputn,outputn,a);
%����ѵ������,����Ϊ��������������Ŀ��ֵ��mse����
%lr===ѧϰ��(ѧϰ��Խ��������Բ�����Ӱ���Խ�󣬲������µ�Խ�죬ͬʱ�ܵ��쳣���ݵ�Ӱ���Խ�󣬺����׷�ɢ)
%ѧϰ��Ҫ�Ƚϵõ�
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%����ѵ��
net=train(net,inputn,outputn);

%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test1,inputps);
%����Ԥ�����
an=sim(net,inputn_test);
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);

%����MAPE
real=num(121:168,16)';
mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('·��һƽ���г��ٶ�km/h')
string = {'���Լ�·��һƽ���г��ٶ�Ԥ�����Ա�';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(1,:)=BPoutput;


%%·�ζ�
%ѵ����-120����ǰ10Сʱ
input_train1(1,1:120)=num(1:120,4)';
input_train1(2,1:120)=num(1:120,10)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,17)';
%���Լ�-48������4Сʱ
input_test1(1,1:48)=num(121:168,4)';
input_test1(2,1:48)=num(121:168,10)';
input_test1(3,1:48)=num(121:168,15)';
%�������ݹ�һ�� min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%��������
%��������Ԫ/�ڵ���������Ը��ģ�Ҫ���Խ��Ӱ��
a=5;
net=newff(inputn,outputn,a);
%����ѵ������,����Ϊ��������������Ŀ��ֵ��mse����
%lr===ѧϰ��(ѧϰ��Խ��������Բ�����Ӱ���Խ�󣬲������µ�Խ�죬ͬʱ�ܵ��쳣���ݵ�Ӱ���Խ�󣬺����׷�ɢ)
%ѧϰ��Ҫ�Ƚϵõ�
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%����ѵ��
net=train(net,inputn,outputn);

%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test1,inputps);
%����Ԥ�����
an=sim(net,inputn_test);
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);

%����MAPE
real=num(121:168,17)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('·�ζ�ƽ���г��ٶ�km/h')
axis([0 50,10,55]);
string = {'���Լ�·�ζ�ƽ���г��ٶ�Ԥ�����Ա�';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(2,:)=BPoutput;

%%·����
%ѵ����-120����ǰ10Сʱ
input_train1(1,1:120)=num(1:120,5)';
input_train1(2,1:120)=num(1:120,11)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,18)';
%���Լ�-48������4Сʱ
input_test1(1,1:48)=num(121:168,5)';
input_test1(2,1:48)=num(121:168,11)';
input_test1(3,1:48)=num(121:168,15)';
%�������ݹ�һ�� min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%��������
%��������Ԫ/�ڵ���������Ը��ģ�Ҫ���Խ��Ӱ��
a=5;
net=newff(inputn,outputn,a);
%����ѵ������,����Ϊ��������������Ŀ��ֵ��mse����
%lr===ѧϰ��(ѧϰ��Խ��������Բ�����Ӱ���Խ�󣬲������µ�Խ�죬ͬʱ�ܵ��쳣���ݵ�Ӱ���Խ�󣬺����׷�ɢ)
%ѧϰ��Ҫ�Ƚϵõ�
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%����ѵ��
net=train(net,inputn,outputn);

%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test1,inputps);
%����Ԥ�����
an=sim(net,inputn_test);
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);

%����MAPE
real=num(121:168,18)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
figure
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('·����ƽ���г��ٶ�km/h')
axis([0 50,10,55]);
string = {'���Լ�·����ƽ���г��ٶ�Ԥ�����Ա�';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(3,:)=BPoutput;


%%·��4
%ѵ����-120����ǰ10Сʱ
input_train1(1,1:120)=num(1:120,6)';
input_train1(2,1:120)=num(1:120,12)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,19)';
%���Լ�-48������4Сʱ
input_test1(1,1:48)=num(121:168,6)';
input_test1(2,1:48)=num(121:168,12)';
input_test1(3,1:48)=num(121:168,15)';
%�������ݹ�һ�� min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%��������
%��������Ԫ/�ڵ���������Ը��ģ�Ҫ���Խ��Ӱ��
a=5;
net=newff(inputn,outputn,a);
%����ѵ������,����Ϊ��������������Ŀ��ֵ��mse����
%lr===ѧϰ��(ѧϰ��Խ��������Բ�����Ӱ���Խ�󣬲������µ�Խ�죬ͬʱ�ܵ��쳣���ݵ�Ӱ���Խ�󣬺����׷�ɢ)
%ѧϰ��Ҫ�Ƚϵõ�
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%����ѵ��
net=train(net,inputn,outputn);

%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test1,inputps);
%����Ԥ�����
an=sim(net,inputn_test);
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);

%����MAPE
real=num(121:168,19)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
figure
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('·����ƽ���г��ٶ�km/h')
axis([0 50,10,55]);
string = {'���Լ�·����ƽ���г��ٶ�Ԥ�����Ա�';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(4,:)=BPoutput;

%%·��5
%ѵ����-120����ǰ10Сʱ
input_train1(1,1:120)=num(1:120,7)';
input_train1(2,1:120)=num(1:120,13)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,20)';
%���Լ�-48������4Сʱ
input_test1(1,1:48)=num(121:168,7)';
input_test1(2,1:48)=num(121:168,13)';
input_test1(3,1:48)=num(121:168,15)';
%�������ݹ�һ�� min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%��������
%��������Ԫ/�ڵ���������Ը��ģ�Ҫ���Խ��Ӱ��
a=5;
net=newff(inputn,outputn,a);
%����ѵ������,����Ϊ��������������Ŀ��ֵ��mse����
%lr===ѧϰ��(ѧϰ��Խ��������Բ�����Ӱ���Խ�󣬲������µ�Խ�죬ͬʱ�ܵ��쳣���ݵ�Ӱ���Խ�󣬺����׷�ɢ)
%ѧϰ��Ҫ�Ƚϵõ�
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%����ѵ��
net=train(net,inputn,outputn);

%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test1,inputps);
%����Ԥ�����
an=sim(net,inputn_test);
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);

%����MAPE
real=num(121:168,20)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('·����ƽ���г��ٶ�km/h')
axis([0 50,10,55]);
string = {'���Լ�·����ƽ���г��ٶ�Ԥ�����Ա�';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(5,:)=BPoutput;

%%·��6
%ѵ����-120����ǰ10Сʱ
input_train1(1,1:120)=num(1:120,8)';
input_train1(2,1:120)=num(1:120,14)';
input_train1(3,1:120)=num(1:120,15)';
output_train1(1,1:120)=num(1:120,21)';
%���Լ�-48������4Сʱ
input_test1(1,1:48)=num(121:168,8)';
input_test1(2,1:48)=num(121:168,14)';
input_test1(3,1:48)=num(121:168,15)';
%�������ݹ�һ�� min=0 max=1 [0,1]
[inputn,inputps]=mapminmax(input_train1,0,1);
[outputn,outputps]=mapminmax(output_train1,0,1);
%��������
%��������Ԫ/�ڵ���������Ը��ģ�Ҫ���Խ��Ӱ��
a=5;
net=newff(inputn,outputn,a);
%����ѵ������,����Ϊ��������������Ŀ��ֵ��mse����
%lr===ѧϰ��(ѧϰ��Խ��������Բ�����Ӱ���Խ�󣬲������µ�Խ�죬ͬʱ�ܵ��쳣���ݵ�Ӱ���Խ�󣬺����׷�ɢ)
%ѧϰ��Ҫ�Ƚϵõ�
net.trainParam.epochs=1000; 
net.trainParam.goal=1e-3;
net.trainParam.lr=0.1;

%����ѵ��
net=train(net,inputn,outputn);

%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test1,inputps);
%����Ԥ�����
an=sim(net,inputn_test);
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);

%����MAPE
real=num(121:168,21)';

mape=mean(abs((real - BPoutput)./real))*100;
smape=mean(abs((real - BPoutput)./((real+BPoutput)/2)))*100;
plot(1:48,real,'b:*',1:48,BPoutput,'r-o');
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('·����ƽ���г��ٶ�km/h')
axis([0 50,10,65]);
string = {'���Լ�·����ƽ���г��ٶ�Ԥ�����Ա�';['MAPE(%)=' num2str(mape)];['SMAPE(%)=' num2str(smape)]};
title(string);
cunchu(6,:)=BPoutput;

%������
xlswrite('rongheresult',cunchu);