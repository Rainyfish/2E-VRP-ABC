function demand_pool = lay1_path_demand(result,coord_sat,demand)
    result_lay1 = result{1};
    sat_num = size(coord_sat,1);
    demand_pool= zeros(1,sat_num);
    for i = 1:sat_num
        result_lay2 = result{i+1};
        cur_idx = find(result_lay2~=0);
        cur_demand_idx = result_lay2(cur_idx);
        demand_pool(i) = sum(demand(cur_demand_idx));
    end;
end