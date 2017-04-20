function [result_pool,fitness_pool]=run_abc(coord_dep,coord_sat,coord_cus,fleet,demand,food_num,max_iter_num)
    %--------------------------初始化阶段---------------------------%
    W = zeros(1,food_num);%食物源无改善的次数
    W_limit = 50;
    theta = 1.3;
    result_pool = cell(1,food_num);%食物源池
%     s2s_dist 卫星之间的距离
%     s2d_dist 卫星与仓库之间的距离
%     c2s_dist 客户与卫星之间的距离
%     c2c_dist 客户与客户之间的距离

    [s2s_dist,s2d_dist,c2s_dist,c2c_dist] =compute_dist2(coord_dep,coord_sat,coord_cus);%计算距离
    %初始化食物源
    fitness_pool = zeros(1,food_num);
    for i= 1:food_num
        result_pool{i} = Initize(coord_dep,coord_sat,coord_cus,fleet,demand,c2s_dist);
       % disp(result_pool{i});
         fitness_pool(i) = fitness(result_pool{i},coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
    end
    iter_num = 0;
    
    while iter_num < max_iter_num
        
        %%--------------------------邻域操作阶段---------------------------------
        for i = 1:food_num;
            result = result_pool{i};
            fitness_old = fitness_pool(i);
            %-----邻域操作------% %-----计算适应值-----%只对第二层进行了交叉变异操作和破坏与修复
           [result_new]= NeighborOperator(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
           fitness_new = fitness(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
           if (fitness_old <fitness_new)
               W(i) = W(i)+1;
           else
                result_pool{i} = result_new;
                fitness_pool(i) = fitness_new;
           end;
          %  fitness(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
        end
        %--------------雇佣蜂阶段---------------------------------------------%
        fitness_sum = sum(1./(fitness_pool+1));
        fx = double(1./(fitness_pool+1)/double(fitness_sum));
       % disp(fitness_pool);
        select =zeros(1,food_num);
        %轮盘赌
        for i = 1:food_num
            sel = rand;
            sumPs = 0;
            j =1;
            while(sumPs<sel)
                sumPs = sumPs+fx(j);
                j = j+1;
            end;
            select(i) = j-1;
        end;
        %-----------------------------------邻域操作--------------------------% 
       for i = 1:food_num
           id= select(i);
           result = result_pool{id};
            fitness_old = fitness_pool(id);
            %-----邻域操作------% %-----计算适应值-----%只对第二层进行了交叉变异操作和破坏与修复
           [result_new]= NeighborOperator(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
           fitness_new = fitness(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
           W(id) = W(id)+1;
           if (fitness_old <fitness_new)
               W(id) = W(id)+1;
           else
                result_pool{id} = result_new;
                fitness_pool(id) = fitness_new;
           end;
       end;
       %-----------------------------------对第一层和第二层车辆进行破坏与修复操作-------------------------%
      %问题1：最好的结果进行第一层操作，还是对最差的操作进行第一层操作
       for i = 1:food_num
           if(W(i)>W_limit)
             % 如何破坏，贪心修复
           %  disp('000000000000000000000000000000000000000000');
               result_new = NeighborOperatorLay1(result_pool{i},coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet,coord_dep);
               [result_new]= NeighborOperator(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
               fitness_old = fitness_pool(i);
               fitness_new = fitness(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
               if(fitness_old>fitness_new)
                   fitness_pool(i) = fitness_new;
                   result_pool{i}= result_new;
                   W(i) = 0;
               else
                   minval = min(fitness_pool);
                   cur_min =find(fitness_pool==minval);
                   if(fitness_old<=(theta*minval)&&(size(cur_min,2)<= (food_num/3)+1));
                       W(i) = (W(i)-W_limit/2);
                   else
                       result_new =Initize(coord_dep,coord_sat,coord_cus,fleet,demand,c2s_dist);
                       fitness_new = fitness(result_new,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet);
                       fitness_pool(i) = fitness_new;
                       result_pool{i} = result_new;
                   end;
               end;
           end;
        end;
        
   %   -----------------------------------对食物池中较好的两个蜜源进行求同存异操作------------------------%
      iter_num = iter_num +1;
      % disp(min(fitness_pool));   
        
    
   end;
   %disp(fitness_pool);
  % save result_pool result_pool; 
end