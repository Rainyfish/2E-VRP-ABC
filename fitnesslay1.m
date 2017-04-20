function fitness_lay1= fitnesslay1(result,cap_lay1,demand,s2d_dist,s2s_dist)
    fitness_lay1 =0;
    M1 = 10000;%超载惩罚系数
    M2 = 0;
    demand_path =0;
    len = size(result,2);
    for i =1:len-1
        idx = result(i);
        next = result(i+1);
        %超载情况判断
        if(idx ==0)
            demand_path =0;
        else
            demand_path = demand_path+demand(i);
        end;
        if(demand_path>cap_lay1)
            fitness_lay1 = fitness_lay1+M1;
        end;
        %路径代价判断
        if(idx==0||next==0)
            %01的情况
            if(idx ==0&&next~=0)
                fitness_lay1 = fitness_lay1+s2d_dist(1,next);
            end
            %10的情况
            if(idx~=0&&next==0)
                fitness_lay1 = fitness_lay1+s2d_dist(1,idx);
            end
            %00的情况，说明该路径没有用，则给予奖励
            if(idx==0&&next==0)
                fitness_lay1 = fitness_lay1-M2;
            end
        else
            fitness_lay1 = fitness_lay1+s2s_dist(idx,next);
        end
    end
%      disp('-----lay1--------')
%      disp(fitness_lay1);
end