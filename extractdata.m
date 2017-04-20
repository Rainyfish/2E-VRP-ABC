%% --------------------------提取源文件中的数据---------------------
function [depot,satellites,customers,fleet,demand,name] = extractdata(num_folder,seq)
    %----Name of Set2-Set4----
    %----total of Set2 is 21----
    Set2 = {'22-k4-s06-17','22-k4-s08-14','22-k4-s09-19','22-k4-s10-14','22-k4-s11-12','22-k4-s12-16','33-k4-s01-09','33-k4-s02-13','33-k4-s03-17','33-k4-s04-05','33-k4-s07-25','33-k4-s14-22','51-k5-s02-04-17-46','51-k5-s02-17','51-k5-s04-46','51-k5-s06-12','51-k5-s06-12-32-37','51-k5-s11-19','51-k5-s11-19-27-47','51-k5-s27-47','51-k5-s32-37'};
    %----total of Set3 is 18----
    Set3 = {'22-k4-s13-14','22-k4-s13-16','22-k4-s13-17','22-k4-s14-19','22-k4-s17-19','22-k4-s19-21','33-k4-s16-22','33-k4-s16-24','33-k4-s19-26','33-k4-s22-26','33-k4-s24-28','33-k4-s25-28','51-k5-s12-18','51-k5-s12-41','51-k5-s12-43','51-k5-s39-41','51-k5-s40-41','51-k5-s40-43'};
    %----total of Set4 is 54  % Set4 = [2,18;3,36;5,54];----
    %----Set4中的文件名具有规律性，不需要手动输入！----
    %----total of Set5 is 18----
    Set5 = {'100-5-1','100-5-1b','100-5-2','100-5-2b','100-5-3','100-5-3b','100-10-1','100-10-1b','100-10-2','100-10-2b','100-10-3','100-10-3b','200-10-1','200-10-1b','200-10-2','200-10-2b','200-10-3','200-10-3b'};
    %----路径提取----
    switch num_folder
        case 1
            name_data     = char(strcat('dataset/Set2/E-n',Set2(seq),'.dat'));
            name = char(strcat('Set2/E-n',Set2(seq)));
            disp(char(strcat('Set2/E-n',Set2(seq))));
        case 2
            name_data     = char(strcat('dataset/Set3/E-n',Set3(seq),'.dat'));
            name = char(strcat('Set3/E-n',Set3(seq)));
            disp(char(strcat('Set3/E-n',Set3(seq))));
        case 3
            if seq<10
                name_data = strcat('dataset/Set4/Instance50-s2-0',num2str(seq),'.dat');
                name = char(strcat('Set4/Instance50-s2-0',num2str(seq)));
                disp(char(strcat('Set4/Instance50-s2-0',num2str(seq))));
            elseif seq<19
                name_data = strcat('dataset/Set4/Instance50-s2-',num2str(seq),'.dat');
                name = char(strcat('Set4/Instance50-s2-',num2str(seq)));
                disp(char(strcat('Set4/Instance50-s2-',num2str(seq))));
            elseif seq<37
                name_data = strcat('dataset/Set4/Instance50-s3-',num2str(seq),'.dat');
                name = char(strcat('Set4/Instance50-s3-',num2str(seq)));
                disp(char(strcat('Set4/Instance50-s3-',num2str(seq))));
            else
                name_data = strcat('dataset/Set4/Instance50-s5-',num2str(seq),'.dat');
                name = strcat('Set4/Instance50-s5-',num2str(seq));
                disp(strcat('Set4/Instance50-s5-',num2str(seq)));
            end
        case 4
            name_data     = char(strcat('dataset/Set5/2eVRP_',Set5(seq)));
            name = char(strcat('Set5/2eVRP_',Set5(seq)));
            disp(char(strcat('Set5/2eVRP_',Set5(seq))));
        otherwise
            name_data     = char(strcat('dataset/Set2/E-n',Set2(seq),'.dat'));
    end
    %----读数据----
    source     = importdata(name_data,'',99999);
    data_cell  = regexpi(source, '\w*(\_*)(\w*)', 'match');
    row_data   = size(data_cell,1);
    %----提取数据到矩阵  %提取后将删除序号列（即第一列）----
    fleet      = zeros(2,2);   %每行对应第i层的车辆容量和车辆总数
    demand     = [];           %每行对应第i个客户的序号和需求（2列）
    depot      = zeros(1,3);   %卫星总站的序号、坐标
    satellites = [];           %每行对应第i个卫星的序号、位置坐标（3列）
    customers  = [];           %每行对应第i个客户的序号、位置坐标（3列）
    i          = 1;
    while i <= row_data
        if  size(data_cell{i},1)<=3 && size(data_cell{i},1)>=1
            index = char(data_cell{i}(1));
            switch index
                case 'SATELLITES' 
                    ns         = str2num(char(data_cell{i}(2)));
                    satellites = zeros(ns,3);
                    i          =i+1;
                case 'CUSTOMERS' 
                    nc         = str2num(char(data_cell{i}(2)));
                    customers  = zeros(nc,3);
                    demand     = zeros(nc,2);
                    i=i+1;
%                 case 'EDGE_WEIGHT_TYPE'
%                     type = char(data_cell{i}(2));
%                     i=i+1;
                case 'L1CAPACITY' 
                    fleet(1,1) = str2num(char(data_cell{i}(2)));
                    i=i+1;
                case 'L2CAPACITY' 
                    fleet(2,1) = str2num(char(data_cell{i}(2)));
                    i=i+1;
                case 'L1FLEET' 
                    fleet(1,2) = str2num(char(data_cell{i}(2)));
                    i=i+1;
                case 'L2FLEET' 
                    fleet(2,2) = str2num(char(data_cell{i}(2)));
                    i=i+1;
                case 'NODE_COORD_SECTION' 
                    i          = i+1;
                    depot      = str2num(source{i});
                    for j = 1:nc
                        customers(j,:) = str2num(source{i+j});
                    end
                    i = i+nc+1;
                case 'SATELLITE_SECTION'
                    for j = 1:ns
                        satellites(j,:) = str2num(source{i+j});
                    end
                    i = i+ns+1;
                case 'DEMAND_SECTION'
                    i = i+1;
                    for j = 1:nc
                        demand(j,:) = str2num(source{i+j});
                    end
                    i = i+nc+1;
                otherwise
%                     fprintf('line %d is not match!\n',i);
                    i = i+1;
            end
        else
            i = i+1;
        end     
    end
    %----将矩阵中的序号列删除----
    depot(1)        = [];
    satellites(:,1) = [];
    customers(:,1)  = [];
    demand(:,1)     = [];
end