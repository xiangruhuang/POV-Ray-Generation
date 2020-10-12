function [z] = gmm(centers, up_centers, x, y)

z = 0.0;

for i = 1: size(centers, 1)
    cx = centers(i, 1);
    cy = centers(i, 2);
    z = z-exp(-((cx - x)^2 + (cy-y)^2)/2.0);
end

for i = 1: size(up_centers, 1)
    cx = up_centers(i, 1);
    cy = up_centers(i, 2);
    z = z +exp(-((cx - x)^2 + (cy-y)^2)/2.0);
end

end

