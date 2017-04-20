function lay_out(result,name,demand,c2c_dist,c2s_dist,s2d_dist,s2s_dist,fitness,fleet)
    path = ['data\\',name,'.txt'];
    fid = fopen(path,'wt');
    
    disp(name);
    fprintf(fid,[name,'\n']);
    fitness_str = num2str(fitness);
    
    disp(['total cost =',fitness_str]);
    fprintf(fid,['total cost =',fitness_str,'\n']);
    disp('------------------lay1--------------');
    fprintf(fid,'------------------lay1--------------\n');
   
    result_lay1 = result{1};
    len = size(result_lay1,2);
    i =1;
    j=2;
    lay_1_pool = {};
    param.id = 0;
    param.cost=0;
    param.Weight=0;
    param.cust=[];
    param.vechicles=0;
    demand_path = result{end};
    k = 1;
    while(j<=len)
        if(result_lay1(i)==0)
            while(result_lay1(j)~=0)
                j = j+1;
            end;
            result_j = result_lay1(1,i:j);
            demand_j = demand_path(1,i:j);
            no=result_j(find(result_j~=0));
            if(size(no,2)==0)
            else
                param.cost = fitnesslay1(result_j,fleet(1,1),demand_j,s2d_dist,s2s_dist);
                param.cust = no;
                param.demand = sum(demand_j);
                lay_1_pool{k} =param;
                k= k+1;
            end
            i = j;
            j = j+1;
        end;
    end;
    sat_num =size(result,2)-1;
    lay_2_pool={};
    for m=2:sat_num
        lay_2.vehicles = 0;
        lay_2.pool={};
        
        i =1;
        j =2;
        result_lay2 =result{m};
        len = size(result_lay2,2);
        lay_2.cost = fitnesslay2(result_lay2,fleet(2,1),demand,c2s_dist(m-1,:),c2c_dist);
        k=1;
        while(j<=len)
            if(result_lay2(i)==0)
                while(result_lay2(j)~=0)
                    j = j+1;
                end;
                result_j = result_lay2(1,i:j);
                %demand_j = demand_path(1,i:j);
                no=result_j(find(result_j~=0));
                demand_j = demand(no);
                if(size(no,2)==0)
                else
                    param.cost = fitnesslay2(result_j,fleet(2,1),demand,c2s_dist(m-1,:),c2c_dist);
                    param.cust = no;
                    param.demand = sum(demand_j);
                    lay_2.pool{k} =param;
                    k= k+1;
                    lay_2.vehicles=lay_2.vehicles+1;
                    lay_2_pool{m-1} = lay_2;
                end
                i = j;
                j = j+1;
            end;
        end;
    end;
    %%输出或写入记事本的过程
    %%第一层
    %%写入记事本
    
    for i = 1:size(lay_1_pool,2)
        param = lay_1_pool{i};
        str = ['Cost(',num2str(param.cost),'),Weight(',num2str(param.demand),'),Cust(',num2str(size(param.cust,2)),') ', num2str(param.cust)];
        fprintf(fid,[str,'\n']);
        disp(str);
    end
    disp('------------------lay2--------------');
    fprintf(fid,'------------------lay2--------------\n');
    %%第二层
    len2 = size(lay_2_pool,2);
    for i = 1:len2;
        lay_2 = lay_2_pool{i};
        if(size(lay_2,2)==0)
           str1 = ['Cost = ',num2str(0),' Vehicles = ',num2str(0)]; 
           fprintf(fid,[str1,'\n']);
           disp(str1);
           fprintf('\n'); 
           fprintf(fid,'\n');  
           continue;
        end;
        str1 = ['Cost = ',num2str(lay_2.cost),' Vehicles = ',num2str(lay_2.vehicles)];
        fprintf(fid,[str1,'\n']);
        disp(str1);
        for j = 1:size(lay_2.pool,2)
            param = lay_2.pool{j};
            str = ['Cost(',num2str(param.cost),'),Weight(',num2str(param.demand),'),Cust(',num2str(size(param.cust,2)),') ', num2str(param.cust)];
            fprintf(fid,[str,'\n']);
            disp(str);
        end;
        fprintf('\n'); 
        fprintf(fid,'\n');  
    end;
end
