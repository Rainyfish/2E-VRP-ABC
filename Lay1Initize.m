function result = Lay1Initize(coord_sat, coord_dep,fleet)
    [sat_num,a] = size(coord_sat);
    car_num = fleet(1,2);
    result = cow(sat_num,car_num);
end