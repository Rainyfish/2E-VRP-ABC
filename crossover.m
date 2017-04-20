function [result_new1,result_new2] = crossover(result1,result2)
    %%将客户点抽取出来，进行交叉操作，然后将交叉后的客户点放到原来的位置：与crossover的区别！！
    non1 = find(result1~=0);
    non1_V = result1(non1);
    non2 = find(result2~=0);
    non2_V = result2(non2);
    len = size(non1_V,2);
    if(len<=2)
        result_new1= result1;
        result_new2 = result2;
        return;
    end;
    loc = randi([2,len-1],1,1);
    result_non_new1 =[non1_V(1,1:loc),non2_V(1,loc+1:end)];
    result_non_new2= [non2_V(1,1:loc),non1_V(1,loc+1:end)];
    idx1 = [];
    for i = 1:loc
        if(sum(result_non_new1==result_non_new1(i))>1)
            idx1=[idx1,i];
        end;
    end;
    j =1;
    idx2 = [];
    for i = 1:loc
        if(sum(result_non_new2==result_non_new2(i))>1)
            temp = result_non_new2(i);
            result_non_new2(i) = result_non_new1(idx1(j));
            result_non_new1(idx1(j)) = temp;
            j = j+1;
        end;
    end;
    
    
    result1(non1) = result_non_new1;
    result2(non2) = result_non_new2;
    result_new1 = result1;
    result_new2 = result2;
end