function [a] = cow(n,k) %随机生成染色体
a = zeros(1,n+k+1);
a(1,:) = [0,randperm(n+k+1-2),0];%保证是以0开头和结尾的
for i = 1:k-1
    b = find(a(1,:)==n+i);
    a(1,b) = 0;
end
end