h=waitbar(0,'计算中，请稍后!');
len= 循环次数
 for i
    str=['计算中…',num2str(100*i/len),'%'];
    waitbar(i/len,h,str);
end
close(h);