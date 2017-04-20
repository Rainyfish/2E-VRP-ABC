function demand_sat = computeSatDemand(result,demand)
%计算每条二层路径上的总需求量
%这个功能的函数我竟然写了两遍，果然写昏了头了
len = size(result,2);
demand_sat = 0;
for i =1:len-1
    idx = result(i);
    if(idx==0)
    else
        demand_sat = demand_sat+demand(idx);
    end
end
end