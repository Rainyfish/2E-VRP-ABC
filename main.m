%% -----------------------------信息提取程序-----------------------------
clear all; close all; clc; rand('state', sum(100*clock)); format bank;
%----4个文件下的测试样本数目----
seq_dataset = [21,18,54,18]; %dataset文件下的4个文件Set2-Set5中测试样例数目

%----参数设置----
runs        = 20;                 %重复实验次数
max_iter    = 500000;             %每次实验最多迭代次数500k

%各文件夹内数据总量分别为：21,18,54,18; %文件夹的序号：1-4->Set2-Set5;
%----Start----
tic
for num_folder = 1:4%1:4                    %文件夹的序号：1-4分别对应文件夹Set2-Set5;
    seq_data = seq_dataset(num_folder);      %第num_folder个文件夹的测试样本总数
    nn = seq_data;                                  %set2中的第2个问题
    result.name=0;
    result.val=0;
    all_result_pool=cell(1,nn);
    for seq = 1:seq_data  %1:seq_data
       %----提取文件的仓库、卫星、客户坐标、车辆信息和客户需求----
        %coord_dep：仓库的坐标
        %coord_sat：卫星（中转站）坐标
        %coord_cus：客户的坐标
        %fleet：车辆信息，fleet(1,1)为第一层车辆的最大载重量  fleet(1,2)为第一层可使用的车辆数目  fleet(2,1)为第二层车辆的最大载重量  fleet(2,2)为第二层可使用的车辆数目
        %demand：客户需求
        [coord_dep,coord_sat,coord_cus,fleet,demand,name] = extractdata(num_folder,seq);
        [result_pool,fitness_pool]=run_abc(coord_dep,coord_sat,coord_cus,fleet,demand,50,100);
        minval = min(fitness_pool);
        id = find(minval==fitness_pool);
        result_best = result_pool{id(1)};
        %画图工具
        draw_plot(result_best,coord_dep,coord_sat,coord_cus,name);
        [s2s_dist,s2d_dist,c2s_dist,c2c_dist] =compute_dist2(coord_dep,coord_sat,coord_cus);
        result.name = name;
        result.val = minval;
        result.path = result_best;
        all_result_pool{seq} = result;
        %%输出格式要求
        lay_out(result_best,name,demand,c2c_dist,c2s_dist,s2d_dist,s2s_dist,minval,fleet);
    end
    save all_result_pool all_result_pool;
end
toc