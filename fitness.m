function fitness_all = fitness(result,coord_sat,demand,s2d_dist,c2s_dist,c2c_dist,s2s_dist,fleet)
    M2 = 0;
    resultlay1 = result{1};
    sat_num = size(coord_sat,1);
    demand_sat = zeros(1,sat_num);
    fitness_all = 0;
    %---------------第二层处理---------------%
    cap_lay2 = fleet(2,1);
    for i =2:sat_num+1
        result_sat = result{i};
        fitness_lay2= fitnesslay2(result_sat,cap_lay2,demand,c2s_dist(i-1,:),c2c_dist);
        fitness_all = fitness_all+fitness_lay2;
    end
    %-------------第一层求解-----------------%
    cap_lay1 = fleet(1,1);
    demand_sat = result{sat_num+2};
    % demand_sat = lay1_path_demand(result,coord_sat,demand);%计算每一层的需求
    fitness_lay1= fitnesslay1(resultlay1,cap_lay1,demand_sat,s2d_dist,s2s_dist);
    fitness_all = fitness_all+fitness_lay1;
  %  disp(demand_sat);
    %disp(fitness_all);
end