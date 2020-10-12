function save_points(pc, faces, filename)
mesh = {}
mesh.
f_id = fopen(filename, 'w');

for id = 1: size(pc, 1)
  fprintf(f_id, 'v %f %f %f\n', pc(id, 1), pc(id, 3), pc(id, 2));
end
for id = 1: size(faces, 1)
  fprintf(f_id, 'f %d %d %d\n', faces(id, 1), faces(id, 2), faces(id, 3)); 
end
fclose(f_id);
end

