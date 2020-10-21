function [] = save_povray2(pointcloud, filename, colors)
%
f_id = fopen(filename, 'w');
fprintf(f_id, 'union {\n');
size(pointcloud)
colors(30, 2) = 69.0/255;
colors(30, 1) = 1.0;
colors(30, 3) = 0.0;

colors(10, 2) = 1.0;
colors(10, 1) = 1.0;
colors(10, 3) = 0.0;
for id = 1 : size(pointcloud, 1)
    pos = pointcloud(id, :);
    fprintf(f_id, '  sphere\n');
    fprintf(f_id, '  {\n');
    fprintf(f_id, '    <%f,%f,%f>, 0.9\n', pos(1)+rand()*5, min(pos(2)+rand()*7, 10), pos(3)+rand()*5);
    fprintf(f_id, '    texture{ pigment{ rgb<%f,%f,%f> } }\n', colors(id, 1), colors(id, 2), colors(id, 3));
    fprintf(f_id, '  }\n');
end
fprintf(f_id, '}\n');
fclose(f_id);