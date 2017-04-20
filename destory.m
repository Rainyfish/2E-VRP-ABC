function [cur_pool,result_des] = destory(result,q)
    %1.随机取出q个客户进行移除，如1，0,11；（0也可以移除）,移除时按照从小标大到小的顺序移除，因为可能会找不到目标，但是确保不能移除最后一个
    %例如随机数是 14,14，可能会移除最后一个0；
    %所以正确方法是每次根据当前的解的长度生成【2，len-1】的随机数！！！！；
    %q = 3;
    len = size(result,2);
   % rand_M = randi([2,len-1],1,q);
    result_des= result;
  %  rand_M = sort(rand_M,'descend');
    cur_pool = zeros(1,q);
    for i = 1:q
        loc  = randi([2,len-1],1,1);%每次只生成【2，len-1】之间的一个值，可以保证两端的0不会被移除
        cur_pool(i) = result_des(1,loc);
        result_des(:,loc)=[];%移除
        len = len-1;%每移除一个客户解长度减一
    end;
end