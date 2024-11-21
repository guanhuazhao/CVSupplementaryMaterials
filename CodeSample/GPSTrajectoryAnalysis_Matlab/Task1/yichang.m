function TF=yichang(x,y,time_cha,dis_last,new_rec,jizhun)
    %YICHANG �ж��µ�ͶӰ���Ƿ��쳣
    %   ���������(x,y)Ϊ�µ�ͶӰ�㣬iΪ���ݵ��ţ�
    %             time_chaΪ�õ�����һ���ʱ���ֵ����λΪs
    %             dis_last����һ����ۻ��г̾���� 
    %             new_rec����ͶӰ�����ڵ�·�ξ��η�Χ���    
    %             jinzhunΪ·���������
    %   ���ֵTF1*2
    %       TF��1,1��1���쳣��2�쳣
    %       TF��1,2�����ڵ��ۼ��г̾���
            TF(1,1)=1;%����ֵ��
            %�����µ��ۻ��г̾����
            %��·����㵽��ʼ�����
            r=6371.004;
            L=0;
            for j=1:(new_rec-1)
                L=L+jizhun(j,5);
            end
            %��ͶӰ�㵽��·��������
            lat=jizhun(new_rec,2);
            lon=jizhun(new_rec,1);%·�����
            l=distance(lat,lon,y,x,r);
            %���ۻ��г̾���
            D=L+l;        
            dis_now=D;
             %����Ϊ��
            s=dis_now-dis_last;
            if s<0
                 TF(1,1)=2;
            end
        %���ٳ���80km/h
            v=s*1000/time_cha;
            if  v*3.6>80
                 TF(1,1)=2;
            end
            TF(1,2)=dis_now;
end

