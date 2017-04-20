function [result_rec]=recovery(result_des,cur_pool,fleet,demand,c2s_dist,c2c_dist)
    len_new = size(result_des,2);
    q = size(cur_pool,2);
    %------------------贪心恢复阶段------------------%
    for i = 1:q
       cur_idx = cur_pool(i);
       fitness_pool =zeros(1,len_new-1); %尝试每个位置插入后的适应值
       for j = 1:len_new-1
           result_j = [result_des(1,1:j),cur_idx,result_des(1,j+1:end)];
           fitness_pool(j) = fitnesslay2(result_j,fleet(2,1),demand,c2s_dist,c2c_dist);
       end
       minval = min(fitness_pool);
       %%idj有可能是一个矩阵；
       idj = find(fitness_pool == minval);
       if(size(idj,2)>1)
           idj = idj(1);
       end
       %result_des(1,1:idj);
       result_des =[result_des(1,1:idj),cur_idx,result_des(1,idj+1:end)];
       len_new = len_new+1;
    end;
    result_rec = result_des;
end