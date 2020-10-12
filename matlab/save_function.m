function save_function(centers,up_centers,filename)
f_id = fopen(filename, 'w');
fprintf(f_id, '{'); 

for i = 1:1 %size(centers, 1)
  cx = centers(i, 1);
  cy = centers(i, 2);
  fprintf(f_id, '-exp(-((x-(%f))*(x-(%f))+(y-(%f))*(y-(%f)))/0.5)', cx, cx, cy, cy)
end

for i = 1:1 %size(up_centers, 1)
  cx = up_centers(i, 1);
  cy = up_centers(i, 2);
  fprintf(f_id, '+exp(-((x-(%f))*(x-(%f))+(y-(%f))*(y-(%f)))/2)', cx, cx, cy, cy)
end

fprintf(f_id, '}\n');
fclose(f_id);
end

