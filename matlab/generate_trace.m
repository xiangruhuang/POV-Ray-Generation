maximums = [];

for i = 2:n-1
    for j = 2:n-1
        if (z(i, j) < z(i+1, j))
            continue 
        end
        if (z(i, j) < z(i-1, j))
            continue 
        end
        if (z(i, j) < z(i, j-1))
            continue 
        end
        if (z(i, j) < z(i, j+1))
            continue 
        end
        maximums = [maximums; [i, j]];
    end
end

minimums = [];
for i = 2:n-1
    for j = 2:n-1
        if (z(i, j) > z(i+1, j) + 0.01)
            continue 
        end
        if (z(i, j) > z(i-1, j) + 0.01)
            continue 
        end
        if (z(i, j) > z(i, j-1) + 0.01)
            continue 
        end
        if (z(i, j) > z(i, j+1) + 0.01)
            continue 
        end
        z(i, j)
        minimums = [minimums; [i, j]];
    end
end

traces = [];
sx = 170;
sy = 170;
tx = 170;
ty = 110;
for r = 0:0.1:1
    mid_x = int32(sx*r + tx * (1.0-r));
    mid_y = int32(sy*r + ty * (1.0-r));
    traces = [traces, [(mid_x-1)*n + mid_y]];
end
save_trace(traces, x, y, z, '../trace1.inc');

traces = [];
sx = 100;
sy = 80;
tx = 120;
ty = 50;
for r = -0.2:0.1:0.7
    mid_x = int32(sx*r + tx * (1.0-r));
    mid_y = int32(sy*r + ty * (1.0-r));
    traces = [traces, [(mid_x-1)*n + mid_y]];
end
save_trace(traces, x, y, z, '../trace2.inc');

