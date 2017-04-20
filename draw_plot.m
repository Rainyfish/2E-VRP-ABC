function draw_plot(result,coord_dep,coord_sat,coord_cus,name)
    figure;
    hold on;
    grid on;
    title(name);
    plot(coord_dep(1),coord_dep(2),'rp','MarkerSize',15);
    sat_num = size(coord_sat,1);
    for i = 1:sat_num
        plot(coord_sat(i,1),coord_sat(i,2),'bs','MarkerSize',12);
    end;
    cur_num = size(coord_cus,1);
    for i = 1:cur_num
        plot(coord_cus(i,1),coord_cus(i,2),'mo','MarkerSize',8);
        text(coord_cus(i,1)+1,coord_cus(i,2)-1,num2str(i));
    end;
    result_lay1 = result{1};
    len = size(result_lay1,2);
    for i = 1:len-1
        idx = result_lay1(i);
        next = result_lay1(i+1);
        if(idx ==0||next==0)
            if(idx==0&&next==0)
            end;
            if(idx~=0&&next==0)
                plot([coord_dep(1,1),coord_sat(idx,1)],[coord_dep(1,2),coord_sat(idx,2)],'r-');
            end;
            if(idx==0&&next~=0)
                plot([coord_dep(1,1),coord_sat(next,1)],[coord_dep(1,2),coord_sat(next,2)],'r-');
            end
        else
             plot([coord_sat(idx,1),coord_sat(next,1)],[coord_sat(idx,2),coord_sat(next,2)],'r-');
        end;
    end;
    for j = 2:sat_num+1
        coord_sati = coord_sat(j-1,:);
        result_lay2 = result{j};
        len = size(result_lay2,2);
        for i = 1:len-1
            idx = result_lay2(i);
            next = result_lay2(i+1);
            if(idx ==0||next==0)
                if(idx==0&&next==0)
                end;
                if(idx~=0&&next==0)
                    plot([coord_sati(1,1),coord_cus(idx,1)],[coord_sati(1,2),coord_cus(idx,2)],'-');
                end;
                if(idx==0&&next~=0)
                    plot([coord_sati(1,1),coord_cus(next,1)],[coord_sati(1,2),coord_cus(next,2)],'-');
                end
            else
                plot([coord_cus(idx,1),coord_cus(next,1)],[coord_cus(idx,2),coord_cus(next,2)],'-');
            end;
        end;
    end;
    path =['data\\',name,'.jpg'];
    saveas(gcf,path);
end