function [] = save_povray(pointcloud, filename, colors)
%
f_id = fopen(filename, 'w');
fprintf(f_id, 'union {\n');
for i = 1 : 40
    for j = 1 : 4 
        id = (i-1)*4 + j;
        pos = pointcloud(:, id);
        fprintf(f_id, '  sphere\n');
        fprintf(f_id, '  {\n');
        fprintf(f_id, '    <%f,%f,%f>, r_fea\n', pos(1), pos(2),-pos(3));
        fprintf(f_id, '    texture{fea_texture2}\n');
        fprintf(f_id, '  }\n');
    end
end
fprintf(f_id, '}\n');
fclose(f_id);