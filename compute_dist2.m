function [sat2sat_dist,sat2dep_dist,cur2sat_dist,C_dist]=compute_dist2(coord_dep,coord_sat,coord_cus)
%sat_num 表示卫星的数量
%cus_num 表示客户的数量
    
    [sat_num,a] = size(coord_sat);
    [cur_num,a] = size(coord_cus);
    C_dist= zeros(cur_num,cur_num);
    for i = 1:cur_num;
        for j = 1:cur_num;
            C_dist(i,j) =sqrt(sum( (coord_cus(i,:)-coord_cus(j,:)).*(coord_cus(i,:)-coord_cus(j,:))));
        end;
    end 
    cur2sat_dist = zeros(sat_num,cur_num);
    for i = 1:sat_num;
        for j = 1:cur_num;
            cur2sat_dist(i,j) =sqrt(sum((coord_sat(i,:)-coord_cus(j,:)).*(coord_sat(i,:)-coord_cus(j,:))));
        end;
    end 
    sat2dep_dist = zeros(1,sat_num);
    for i = 1:sat_num;
        sat2dep_dist(1,i) =sqrt(sum((coord_sat(i,:)-coord_dep(1,:)).*(coord_sat(i,:)-coord_dep(1,:))));
    end;
    sat2sat_dist=zeros(sat_num,sat_num);
    for i = 1:sat_num;
        for j = 1:sat_num;
            sat2sat_dist(i,j) =sqrt(sum((coord_sat(i,:)-coord_sat(j,:)).*(coord_sat(i,:)-coord_sat(j,:))));
        end;
    end;
   % disp(sat2sat_dist);
    %disp(sat2dep_dist);
   % disp(cur2sat_dist);
   % disp(C_dist);
end