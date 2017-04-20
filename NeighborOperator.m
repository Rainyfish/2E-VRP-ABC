function [result] = NeighborOperator(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet)
     result_lay1 = result{1};
   % fitness_lay1= fitnesslay1(resultlay1,fleet(1,1),demand,s2d_dist,s2s_dist);
  
    M2 = 1000; 
    limit_lay2 = 300;
    len = size(result,2);

    iter_num = 50;
    %邻域操作有一个池，保存Iter_num数量的解
    %并取出最小的代价值作为    
    demand_path = result{end};
    fitness_lay1 = fitnesslay1(result_lay1,fleet(1,1),demand_path,s2d_dist,s2s_dist);
    if(fitness_lay1>10000)
        [result_res,demand_res] = lay1_demand_div(result_lay1,demand_path,fleet,s2d_dist,s2s_dist);
        % result_new = result;
        %%第一层路径的交叉变化
        %%第一路径可拆分问题
        %result_new = result;
        fitness_lay1_res = fitnesslay1(result_res,fleet(1,1),demand_res,s2d_dist,s2s_dist);
        if(fitness_lay1_res<fitness_lay1)
            result{1} = result_res;
            result{end} = demand_res;
        end;
    end;
    
    for i = 2:len-1
        fitness_pool = zeros(1,iter_num);
        result_lay2 = result{i}; 
        fitness_pool(1) = fitnesslay2(result_lay2,fleet(2,1),demand,c2s_dist(i-1,:),c2c_dist);
        result_lay2_pool = cell(1,iter_num);
        result_lay2_pool{1} = result_lay2;
        
        for j = 2:iter_num
            result_new = Lay2NeighborOperator(result_lay2);%序列倒转交换 
            fitness_N = fitnesslay2(result_new,fleet(2,1),demand,c2s_dist(i-1,:),c2c_dist); 
            result_lay2_pool{j} = result_new;
            fitness_pool(j)= fitness_N;
        end
        minval = min(fitness_pool);
        idx =find(fitness_pool==minval);
        result_new = result_lay2_pool{idx(1)};
        result{i} = result_new; 
        %%交叉操作
        fitness_pool_cross = zeros(1,2*iter_num-1);
        result_pool_cross = cell(1,2*iter_num-1);
        fitness_pool_cross(1) = minval;
        result_pool_cross{1} = result_new;
        
        k =1;
        j = 2;
        for k =2:iter_num
            [result_new1,result_new2] = crossover(result_lay2_pool{k},result{i});%交叉操作
           % [result_new1,result_new2] = crossover2(result_lay2_pool{k},result{i});%交叉操作
            fitness_cross_new1 = fitnesslay2(result_new1,fleet(2,1),demand,c2s_dist(i-1,:),c2c_dist);
            fitness_cross_new2 = fitnesslay2(result_new2,fleet(2,1),demand,c2s_dist(i-1,:),c2c_dist);
            result_pool_cross{j} = result_new1;
            result_pool_cross{j+1} = result_new2;
            fitness_pool_cross(j)= fitness_cross_new1;
            fitness_pool_cross(j+1)=fitness_cross_new1; 
            j = j+2;
            k= k+1;
        end;
        minval = min(fitness_pool_cross);
        idx =find(fitness_pool_cross==minval);
        result_new = result_pool_cross{idx(1)};
        result{i} = result_new;
        % 如果第二层车辆路径代价超过limit_lay2，则进行破坏与修复操作
        if(minval>limit_lay2)
            result_des =destory_recover_lay2(result_new,coord_sat,demand,s2d_dist,c2s_dist(i-1,:),c2c_dist,s2s_dist,fleet);
            fitness_des = fitnesslay2(result_des,fleet(2,1),demand,c2s_dist(i-1,:),c2c_dist);
            if(minval>fitness_des)
               result{i} = result_des; 
            end;
        end;
    end
  % disp(fitness_all);
end