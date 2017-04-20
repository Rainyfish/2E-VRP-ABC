function result_rec =destory_recover_lay2(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet)
    %%----------------------破坏与修复----------------
%     %1.随机取出q个客户进行移除，如1，0,11；（0也可以移除）,移除时按照从小标大到小的顺序移除，因为可能会找不到目标，但是确保不能移除最后一个
%     %例如随机数是 14,14，可能会移除最后一个0；
%     %所以正确方法是每次根据当前的解的长度生成【2，len-1】的随机数！！！！；
%     %2.将客户试着去插入到【1~len】的位置上，不包括两端，求fitness值最小的位置，进行插入
      q = 4;
     % len = size(result,2);
%    % rand_M = randi([2,len-1],1,q);
%     result_des= result;
%   %  rand_M = sort(rand_M,'descend');
%     cur_pool = zeros(1,q);
%     for i = 1:q
%         loc  = randi([2,len-1],1,1);%每次只生成【2，len-1】之间的一个值，可以保证两端的0不会被移除
%         cur_pool(i) = result_des(1,loc)
%         result_des(:,loc)=[];%移除
%         len = len-1;%每移除一个客户解长度减一
%     end;
    [cur_pool,result_des] = destory(result,q);
    result_rec=recovery(result_des,cur_pool,fleet,demand,c2s_dist,c2c_dist);
    
%     %------------------贪心恢复阶段------------------%
%     for i = 1:q
%        cur_idx = cur_pool(i);
%        fitness_pool =zeros(1,len_new-1); %尝试每个位置插入后的适应值
%        for j = 1:len_new-1
%            result_j = [result_des(1,1:j),cur_idx,result_des(1,j+1:end)];
%            fitness_pool(j) = fitnesslay2(result_j,fleet(2,1),demand,c2s_dist,c2c_dist);
%        end
%        minval = min(fitness_pool);
%        %%idj有可能是一个矩阵；
%        idj = find(fitness_pool == minval);
%        if(size(idj,2)>1)
%            idj = idj(1);
%        end
%        result_des(1,1:idj);
%        result_des =[result_des(1,1:idj),cur_idx,result_des(1,idj+1:end)];
%        len_new = len_new+1;
%     end;
    %size(result_des)==size(result)
end