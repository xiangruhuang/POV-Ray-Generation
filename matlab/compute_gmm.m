x = -10:0.1:10;
y = -10:0.1:10;
xs = -10:3:10;
ys = -10:3:10;

[x, y] = meshgrid(x, y);
[xs, ys] = meshgrid(xs, ys);

xs = xs + randn(size(xs))*0.2;
ys = ys + randn(size(ys))*0.2;
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

for i = 1: ns
  for j = 1:ns 
     zs(i, j) = gmm(centers, up_centers, xs((i-1)*ns+j), ys((i-1)*ns+j));
  end
end

x = x * 3;
y = y * 3;
z = z * 8;
xs = xs * 3;
ys = ys * 3;
zs = zs * 8;

for i = 1:n-1
    for j = 1:n-1
        faces = [faces; [(i-1)*n+j, (i)*n+j, (i)*n+j+1]];
        faces = [faces; [(i-1)*n+j, (i)*n+j+1, (i-1)*n+j+1]];
    end
end