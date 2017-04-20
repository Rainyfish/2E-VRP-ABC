function result = Initize(coord_dep,coord_sat,coord_cus,fleet,demand,c2s_dist)
%----提取文件的仓库、卫星、客户坐标、车辆信息和客户需求----
        %coord_dep：仓库的坐标
        %coord_sat：卫星（中转站）坐标
        %coord_cus：客户的坐标
        %fleet：车辆信息，fleet(1,1)为第一层车辆的最大载重量  fleet(1,2)为第一层可使用的车辆数目  fleet(2,1)为第二层车辆的最大载重量  fleet(2,2)为第二层可使用的车辆数目
        %demand：客户需求
        %dist 第一层车辆与卫星之间的距离
        %cluster 贪心过后的分类
        %demand 分类后的每个类的需求
        
        %C_dist=compute_dist2(coord_dep,coord_sat,coord_cus);
       [cluster,sat_demand]=compute_dist(demand,c2s_dist);
       [sat_num,a] = size(coord_sat);
       [cur_num,b] = size(coord_cus);
       result{1} = Lay1Initize(coord_sat,coord_dep,fleet);
       for i = 1:sat_num
           cluster_sat{i} = find(cluster(:,2)==i);
           cluster_cur= cluster_sat{i} ;
           result{i+1} = Lay2Initize(cluster_cur,i,fleet);
       end
      demand_pool= lay1_path_demand(result,coord_sat,demand);
      %最后添加每一个非0的位置添加对应的demand
      demand_path =zeros(size(result{1}));
      %路径中非0的位置
      result_lay1 = result{1};
      cur_1 = find(result_lay1~=0);
      %cur_idx 表示非0位置cur_1在result_lay1所代表的客户的位置
      cur_idx = result_lay1(cur_1);
      demand_path(cur_1) = demand_pool(cur_idx);
      result{sat_num+2} = demand_path;
      demand_path ;
end