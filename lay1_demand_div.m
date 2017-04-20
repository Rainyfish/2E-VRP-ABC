function [result_res,demand_res] = lay1_demand_div(result,demand_lay1,fleet,s2d_dist,s2s_dist)
    %需求可拆分问题
    cap_lay1 = fleet(1,1);
    %demand_lay1= demand_lay;
    result_lay1 = result;
    len = size(demand_lay1,2);
    %%第一层的破坏与修复，主要解决货物可拆分问题
    cur_pool = {};
    cur.idx =0;
    cur.demand = 0;
    result_res = result_lay1;
    i = len-1;
    j =1;
    demand_res = demand_lay1;
    while(i>1)
       if(demand_res(i)>cap_lay1)
           rate = rand;
           %按照随机概率分配货物
           demand_1 =round(demand_res(i)*rate);
           demand_2 = demand_res(i)-demand_1;
           cur.idx = result_res(i);
           cur.demand = demand_1;
           cur_pool{j} =cur; 
           j = j+1;
           cur.idx = result_res(i);
           cur.demand = demand_2;
           cur_pool{j} =cur; 
           result_res(i) = [];
           demand_res(i) = [];  
       end;
       i = i-1;
    end;
    %%修复过程
    cur_num = size(cur_pool,2);
    len_new = size(result_res,2);
    for i = 1:cur_num
        cur = cur_pool{i};
        fitness_pool=zeros(1,len_new-1);
        for j = 1:len_new-1
           result_j = [result_res(1,1:j),cur.idx,result_res(1,j+1:end)];
           demand_j = [demand_res(1,1:j),cur.demand,demand_res(1,j+1:end)];
           fitness_pool(j) = fitnesslay1(result_j,fleet(1,1),demand_j,s2d_dist,s2s_dist);
        end
        minval = min(fitness_pool);
       
       %%idj有可能是一个矩阵；
       idj = find(fitness_pool == minval);
       if(size(idj,2)>1)
           idj = idj(1);
       end
       %result_des(1,1:idj);
       result_res =[result_res(1,1:idj),cur.idx,result_res(1,idj+1:end)];
       demand_res = [demand_res(1,1:idj),cur.demand,demand_res(1,idj+1:end)];
       len_new = len_new+1;
    end;
    result_res;
    demand_res;
end