function fitness_lay2= fitnesslay2(result,cap_lay2,demand,c2s_dist,c2c_dist)
    fitness_lay2 =0;
    M1 = 10000;%超载惩罚系数
    M2 = 0;
    demand_path =0;
    len = size(result,2);
    flag = 0;
    for i =1:len-1
        idx = result(i);
        next = result(i+1);
         %超载情况判断
        if(idx ==0)
            demand_path =0;
        else
            demand_path = demand_path+demand(idx);
        end;
        if(demand_path>cap_lay2)
            fitness_lay2 = fitness_lay2+M1;
        end;
        if(idx==0||next==0)
            %01的情况
            if(idx ==0&&next~=0)
               
                fitness_lay2 = fitness_lay2+c2s_dist(1,next);
            end
            %10的情况
            if(idx~=0&&next==0)
                
                fitness_lay2 = fitness_lay2+c2s_dist(1,idx);
            end
            %00的情况，说明该路径没有用，则给予奖励
            if(idx==0&&next==0)
                flag = flag+1;
               % fitness_lay2 = fitness_lay2-M2;
            end
        else
            %wtf,这里多写一行，让我的路径容量缩小一倍，难怪跟最优解差那么多，想死啊。。。。，害我多设计了2个算子，
            %demand_path = demand_path+demand(idx);
            fitness_lay2 = fitness_lay2+c2c_dist(idx,next);
        end
    end
    num_zeros =sum(find(result==0));
    car_num = num_zeros-1;
    used_car = car_num-flag;
    fitness_lay2 = fitness_lay2+used_car*M2;
   % disp('-----lay2--------')
%     disp(fitness_lay2);
end