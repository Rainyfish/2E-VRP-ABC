function [result1,result2]=crossover2(result1,result2)
  %%直接进行交叉操作
    len = size(result1,2);
    car_num =sum(find(result1 ==0));
    if(len<=2)
        result_new1= result1;
        result_new2 = result2;
        return;
    end;
    loc = randi([2,len-1],1,1);
    result_non_new1 =[result1(1,1:loc),result2(1,loc+1:end)];
    result_non_new2= [result2(1,1:loc),result1(1,loc+1:end)];
    idx1 = [];
    for i = 1:loc
        if(result_non_new1(i)~=0)
            if(sum(result_non_new1==result_non_new1(i))>1)
                idx1=[idx1,i];
            end;
        else
            if(sum(result_non_new1==result_non_new1(i))~=car_num)
                idx1=[idx1,i];
            end
        end;
    end;
    j =1;
    idx2 = [];
    for i = 1:loc
        if(result_non_new2(i)~=0)
            if(sum(result_non_new2==result_non_new2(i))>1)
                temp = result_non_new2(i);
                result_non_new2(i) = result_non_new1(idx1(j));
                result_non_new1(idx1(j)) = temp;
                j = j+1;
            end;
        else
            %调错调了半天，写成>car_num,当一个解的0多于car_num，另一个解会小于car_num,所以找多余位置时应该是不等于
            if(sum(result_non_new2==result_non_new2(i))~=car_num)
                temp = result_non_new2(i);
                result_non_new2(i) = result_non_new1(idx1(j));
                result_non_new1(idx1(j)) = temp;
                j = j+1;
            end
        end;
        
    end;
    
    
    result1 = result_non_new1;
    result2 = result_non_new2;
    result_new1 = result1;
    result_new2 = result2;
end