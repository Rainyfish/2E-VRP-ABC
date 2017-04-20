function num = roulette(fx)
    sel = rand;
    sumPs = 0;
    j =1;
    while(sumPs<sel)
         sumPs = sumPs+fx(j);
        j = j+1;
    end;
    num = j-1;
end