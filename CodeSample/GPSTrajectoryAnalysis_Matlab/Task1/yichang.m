function TF=yichang(x,y,time_cha,dis_last,new_rec,jizhun)
    %YICHANG 判断新的投影点是否异常
    %   输入参数，(x,y)为新的投影点，i为数据点编号，
    %             time_cha为该点与上一点的时间差值，单位为s
    %             dis_last是上一点的累积行程距离差 
    %             new_rec是新投影点所在的路段矩形范围起点    
    %             jinzhun为路段起点数据
    %   输出值TF1*2
    %       TF（1,1）1不异常，2异常
    %       TF（1,2）现在的累计行程距离
            TF(1,1)=1;%赋初值；
            %计算新的累积行程距离差
            %新路段起点到起始点距离
            r=6371.004;
            L=0;
            for j=1:(new_rec-1)
                L=L+jizhun(j,5);
            end
            %新投影点到新路段起点距离
            lat=jizhun(new_rec,2);
            lon=jizhun(new_rec,1);%路段起点
            l=distance(lat,lon,y,x,r);
            %新累积行程距离
            D=L+l;        
            dis_now=D;
             %距离为负
            s=dis_now-dis_last;
            if s<0
                 TF(1,1)=2;
            end
        %车速超过80km/h
            v=s*1000/time_cha;
            if  v*3.6>80
                 TF(1,1)=2;
            end
            TF(1,2)=dis_now;
end

