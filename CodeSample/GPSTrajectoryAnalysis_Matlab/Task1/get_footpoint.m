function p = get_footpoint(x1,y1,x2,y2,x3,y3)
%GET_FOOTPOINT 对应路段的端点(x1,y1)(x2,y2),数据点(x3,y3) 
              % 返回垂足坐标p(1,1:2)与距离
    syms x y
    k=(y2-y1)/(x2-x1);
    [x,y]=vpasolve([k*((y3-y)/(x3-x))==-1,(y2-y)/(x2-x)==k],[x,y]);
    x=double(x);
    y=double(y);
    p(1,1)=x;
    p(1,2)=y;
    lon=30.887;
    lat=26.395;
    p(1,3)=sqrt(((y-y3)*3600*lat)^2 + ((x-x3)*3600*lon)^2);
end

