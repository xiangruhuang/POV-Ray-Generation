function save_trace(indices, x, y, z, filename)
n = size(x, 1);
xx = reshape(x, [n*n, 1]);
yy = reshape(y, [n*n, 1]);
zz = reshape(z, [n*n, 1]);
pointcloud = [xx, zz, yy];
pointcloud = pointcloud(indices, :);
f_id = fopen(filename, 'w');
fprintf(f_id, 'union {\n');
c1 = 1;
c2 = 0;
c3 = 0;
for id = 1 : size(pointcloud, 1)
    pos = pointcloud(id, :);
    fprintf(f_id, '  sphere\n');
    fprintf(f_id, '  {\n');
    fprintf(f_id, '    <%f,%f,%f>, 0.6\n', pos(1), pos(2), pos(3));
    fprintf(f_id, '    texture{ pigment{ rgb<%f,%f,%f> } }\n', c1, c2, c3);
    fprintf(f_id, '  }\n');
    if id < size(pointcloud, 1)
        pos2 = pointcloud(id+1, :);
        fprintf(f_id, '  cylinder\n');
        fprintf(f_id, '  {\n');
        fprintf(f_id, '    <%f,%f,%f>, \n', pos(1), pos(2), pos(3));
        fprintf(f_id, '    <%f,%f,%f>, 0.3\n', pos2(1), pos2(2), pos2(3));
        fprintf(f_id, '    texture{ pigment{ rgb<%f,%f,%f> } }\n', c1, 1, c3);
        fprintf(f_id, '  }\n');
    end
end
fprintf(f_id, '}\n');
fclose(f_id);

end

