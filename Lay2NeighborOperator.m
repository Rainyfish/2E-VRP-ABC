function result_new = Lay2NeighborOperator(result)
   %出现了重复数字的情况！！！长度与初始不同
   %原因随机数出现重复时就会产生问题！！！！(已解决)
    len = size(result,2);
    %rand_vector = randi([2,len-1],1,4);
    %更改随机数生成的方法
    if(len-2<4)
        result_new = result;
    else
        rand_vector = randperm(len-2,4)+1;
        rand_vector = sort(rand_vector);
        
        % disp(rand_vector);
        %%拆分
        ser1 = result(1,rand_vector(1):rand_vector(2));
        ser1 = fliplr(ser1);
        ser2 = result(1,rand_vector(3):rand_vector(4));
        ser2 = fliplr(ser2);
        %%拼接
        result_new = result(1,1:rand_vector(1)-1);
        result_new = [result_new,ser2];
        result_new = [result_new,result(1,rand_vector(2)+1:rand_vector(3)-1)];
        result_new = [result_new,ser1];
        result_new = [result_new,result(1,rand_vector(4)+1:len)];
    end;
   % size(result_new)==size(result);
end