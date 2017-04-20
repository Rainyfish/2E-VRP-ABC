function result =  Lay2Initize(cluster_cur,sat_idx,fleet)
      [cur_num,a] = size(cluster_cur);
      car_num = fleet(2,2);
      result = cow(cur_num,car_num);
      i = 1;
      [a,result_num] = size(result);
      while i <=result_num
          idx = result(1,i);
          if(idx==0)
          else
              cur_idx = cluster_cur(idx,1);
              result(1,i) = cur_idx;
          end;
          i= i+1;
      end;
      %disp(result);        
%        dist_cur2sat = zeros(1,cur_num);
%        dist_cur2cur = zeros(cur_num,cur_num)
%        for i = 1:cur_num
%            idx= cluster_cur();
%            dist_cur2sat(1,i) = sqrt(sum( (coord_cus(idx,:)-sat(1,:)).*(coord_cus(idx,:)-sat(1,:))));
%        end
%        %计算客户之间的距离
%        for i = 1:cur_num
%             cur_idi =cluster_cur(i,1); 
%             for j = 1:cur_num;
%                 cur_idj = cluster_cur(j,1);
%                 dist_cur2cur(i,j)= D(cur_idi,cur_idj);
%             end
%        end
%        result = [-sat_idx];
%        v_demand = 0;
%        car_num = 0;
%        i = 1;
%        r = rand(1,cur_num);
%        cur_idx  = cluster_cur(r,1);
%        result  =[result,cur_idx];
%        while i == cur_num
%            
%            if(V_demand+demand(cur_idx)>fleet(2,1))
%                result  =[result,-sat_idx];
%                car_num = car_num+1;
%            else
%                result  =[result,cur_idx];
%                dist(:,cur_idx) = [];
%            end;
end