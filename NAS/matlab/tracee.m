x = -10:0.1:10;
y = -10:0.1:10;
xs = -10:0.7:10;
ys = -10:0.7:10;

[x, y] = meshgrid(x, y);
[xs, ys] = meshgrid(xs, ys);

xs = xs + randn(size(xs))*0.1;
ys = ys + randn(size(ys))*0.1;
n = size(x, 2);
z = zeros(n, n);
ns = size(xs, 2);
zs = zeros(ns, ns);
x1 = zeros(n, n);
y1 = zeros(n, n);
faces = [];
for i = 1: n
  for j = 1:n 
     z(i, j) = gmm(centers, up_centers, x((i-1)*n+j), y((i-1)*n+j));
  end
end

trace = [170, 170];

traces = [];

for i = 120:170
   traces = [traces; [170, i]]; 
end
% f = 1;
% while f == 1
%    traces = [traces; trace];
%    if z(trace(1)+1, trace(2)) < z(trace(1), trace(2))
%       trace(1) = trace(1) + 1; 
%       continue;
%    end
%    if z(trace(1)-1, trace(2)) < z(trace(1), trace(2))
%       trace(1) = trace(1) - 1;
%       continue;
%    end
%    
%    if z(trace(1), trace(2)+1) < z(trace(1), trace(2))
%       trace(2) = trace(2) + 1;
%       continue;
%    end
%    if z(trace(1), trace(2)-1) < z(trace(1), trace(2))
%       trace(2) = trace(2) - 1;
%       continue;
%    end
%    f = 0;
% end

indices = [];
for i = 1:size(traces, 1)
   tx = traces(i, 1);
   ty = traces(i, 2);
   indices = [indices, (tx - 1) * n + ty];
end

for i = 1: ns
  for j = 1:ns 
     zs(i, j) = gmm(centers, up_centers, xs((i-1)*ns+j), ys((i-1)*ns+j));
  end
end

for i = 1:n-1
    for j = 1:n-1
        faces = [faces; [(i-1)*n+j, (i)*n+j, (i)*n+j+1]];
        faces = [faces; [(i-1)*n+j, (i)*n+j+1, (i-1)*n+j+1]];
    end
end



sigma2=0.5;
s = 1;
z1 = z;
% for itr = 1:10
%   for i = 1:n
%     for j = 1:n
%       z(i, j) = 0.0;
%       w = 0.0;
%       for dx = -s:s
%         for dy = -s:s
%           if (i+dx <= 0)
%             continue
%           end
%           if (j+dy <= 0)
%             continue
%           end          
%           if (i+dx > n)
%             continue
%           end
%           if (j+dy > n)
%             continue
%           end
%           w1 = exp(-(dx^2+dy^2)/2.0/sigma2);
%           z(i, j) = z(i, j) + z1(i+dx, j+dy)*w1;
%           w = w + w1;
%         end
%       end
%       z(i, j) = z(i, j) / w;
%     end
%   end
% end

x = reshape(x, [n*n, 1])*3;
y = reshape(y, [n*n, 1])*3;
z = reshape(z, [n*n, 1])*8;
xs = reshape(xs, [ns*ns, 1])*3;
ys = reshape(ys, [ns*ns, 1])*3;
zs = reshape(zs, [ns*ns, 1])*8;
x1 = reshape(x1, [n*n, 1]);
y1 = reshape(y1, [n*n, 1]);
index = (x1 - 1) * n  + y1;
pcs = [xs, zs, ys];
pc = [x, z, y];
pc_trace = pc(indices, :);
colors = zeros(size(pc_trace, 1), 3);
colors(:, 1) = 1.0;
save_povray2(pc_trace, 'trace.pov', colors);

colors = zeros(size(pcs, 1), 3);
colors(:, 3) = 1.0;
colors(:, 2) = 0.5;

% perm = randperm(size(pc, 1));
% perm = perm(1, 1:200);
save_povray2(pcs, 'hey.pov', colors);
mesh.vertexPoss = pc';
mesh.faceVIds = faces';
mesh2povray(mesh, 'hey_m.pov');