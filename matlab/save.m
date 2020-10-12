xx = reshape(x, [n*n, 1]);
yy = reshape(y, [n*n, 1]);
zz = reshape(z, [n*n, 1]);
xxs = reshape(xs, [ns*ns, 1]);
yys = reshape(ys, [ns*ns, 1]);
zzs = reshape(zs, [ns*ns, 1]);
pcs = [xxs, zzs*1.2, yys];
pc = [xx, zz, yy];
colors = zeros(size(pcs, 1), 3);
colors(:, 3) = 1.0;
colors(:, 2) = 0.5;

save_povray2(pcs, '../pc.inc', colors);
% mesh.vertexPoss = pc';
% mesh.faceVIds = faces';
% mesh2povray(mesh, '../mesh.inc');