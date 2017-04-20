function [result_new] = destory_recover_lay1(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet)
    result_lay1 = result{1};
    %%-----------随机去除第二层中的一些客户点-----------
    %1、去除客户点可不可以选择每个卫星中距离卫星位置最远的位置（保存以后再做）
    result_new = cell(size(result));
    result_new{1} = result_lay1;
    sat_num = size(coord_sat,1);
    q = 2;
    cur_pool_all=[];
    for i = 1:sat_num
        result_lay2 = result{i+1};
        [cur_pool,result_des] = destory(result_lay2,q);
       
        cur_0=[];
        %如果随机去除的是0，则把0元素放入新的客户池中，进行恢复
        j = q;
        while(j>0)
            if(cur_pool(j)==0)
                cur_0=[cur_0,0];
                %去除客户池中的0
                cur_pool(j) =[];
            end
            j = j-1;
        end;
        %恢复去除的0节点
        if(size(cur_0,2)==0)
            result_rec = result_des;
        else
            [result_rec]=recovery(result_des,cur_0,fleet,demand,c2s_dist(i,:),c2c_dist);
        end
        %把该客户池放入总客户池中
        cur_pool_all = [cur_pool_all,cur_pool];
        %更新解
        result_new{i+1} = result_rec;
    end;
    %总的客户池中的客户数量
    %2、通过去除的客户点到卫星之间的距离，轮盘赌插入某一卫星中，查入的位置还是让该卫星适应值最小的位置
    left_cur_num = size(cur_pool_all,2);
    insert2sat_pool = zeros(1,left_cur_num);%每个客户应该分配那个卫星
    %轮盘赌
    if(numel(cur_pool_all)==0)
           
    else
        for i = 1:left_cur_num
            cur = cur_pool_all(i);
            dist = c2s_dist(:,cur);%列是卫星，行是客户
            dist_sum =double(sum(1./(dist+1)));
            fx = double((1./(dist+1))/dist_sum);
            insert2sat_pool(i) = roulette(fx);
        end
        for i = 1:sat_num
            anss = find(insert2sat_pool==i);%这里竟然写错了，把i写成sat_num了，真是蠢啊
            result_lay2 = result_new{i+1};
            if(isempty(anss))
            else
                cur_pool_rec =cur_pool_all(anss);
                result_lay2 = recovery(result_lay2,cur_pool_rec,fleet,demand,c2s_dist(i,:),c2c_dist);
            end
            result_new{i+1} = result_lay2;
        end;
    end;
    
end