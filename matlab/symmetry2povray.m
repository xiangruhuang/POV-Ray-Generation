function [] = symmetry2povray(sourceShape, sourceSample, PERM, corres, foldername, name)
%
targetShape = sourceShape;
targetSample = sourceSample;
targetShape.featureVIds = targetShape.featureVIds(PERM);
targetSample.distMat = targetSample.distMat(PERM,:);
%targetShape.vertexPoss = targetShape.vertexPoss*1.1;
%sourceShape.vertexPoss(1,:) = sourceShape.vertexPoss(1,:) +0.4;
%sourceShape.vertexPoss(3,:) = sourceShape.vertexPoss(3,:) +0.25;
%targetShape.vertexPoss(1,:) = targetShape.vertexPoss(1,:) -0.4;
%targetShape.vertexPoss(3,:) = targetShape.vertexPoss(3,:) -0.25;
%
map_name = [foldername, name];
f_id = fopen(map_name, 'w');
fprintf(f_id, 'union{\n');
if max(sourceShape.featureVIds) <= size(corres, 2)
    svids = corres(1,sourceShape.featureVIds);
    tvids = corres(2,sourceShape.featureVIds);
    for i = 1 : length(tvids);
        dis(i) = targetSample.distMat(i, tvids(i));
    end
    fprintf('%f\n', sum(dis));
    dis = dis/max(max(targetSample.distMat));
    disbin = max(min(64,floor(192*dis)),1);
    colors = colormap('jet');
    featureColors = colors(disbin,:);

    for i = 1:length(tvids)
        sPos = sourceShape.vertexPoss(:, svids(i))+rand(3,1)*1e-4;
        tPos = targetShape.vertexPoss(:, tvids(i))+rand(3,1)*1e-4;
        c = featureColors(i,:);
        fprintf(f_id, '  cylinder\n');
        fprintf(f_id, '  {\n');
        fprintf(f_id, '    <%f, %f, %f>,<%f,%f,%f>, r_fea\n', sPos(1), sPos(2),-sPos(3),tPos(1),tPos(2),-tPos(3));
        fprintf(f_id, '    texture{pigment { color rgb<%f, %f, %f>}\n',c(1),c(2),c(3));
        fprintf(f_id, '           finish{ambient 0.1 diffuse 0.4 specular 0.2}\n');
        fprintf(f_id, '    }\n');
        fprintf(f_id, '  }\n');
        fprintf(f_id, '  sphere\n');
        fprintf(f_id, '  {\n');
        fprintf(f_id, '    <%f,%f,%f>, r_fea*2\n', sPos(1), sPos(2),-sPos(3));
        fprintf(f_id, '    texture{pigment { color rgb<%f, %f, %f>}\n',c(1),c(2),c(3));
        fprintf(f_id, '           finish{ambient 0.1 diffuse 0.4 specular 0.2}\n');
        fprintf(f_id, '    }\n');
        fprintf(f_id, '  }\n');
        fprintf(f_id, '  sphere\n');
        fprintf(f_id, '  {\n');
        fprintf(f_id, '    <%f,%f,%f>, r_fea*2\n', tPos(1),tPos(2),-tPos(3));
        fprintf(f_id, '    texture{pigment { color rgb<%f, %f, %f>}\n',c(1),c(2),c(3));
        fprintf(f_id, '           finish{ambient 0.1 diffuse 0.4 specular 0.2}\n');
        fprintf(f_id, '    }\n');
        fprintf(f_id, '  }\n');
    end
end
for i = 1:floor(size(corres,2)/256):size(corres,2)
    sPos = sourceShape.vertexPoss(:, corres(1,i))+rand(3,1)*1e-4;
    tPos = targetShape.vertexPoss(:, corres(2,i))+rand(3,1)*1e-4;
    fprintf(f_id, '  cylinder\n');
    fprintf(f_id, '  {\n');
    fprintf(f_id, '    <%f, %f, %f>,<%f,%f,%f>, r_corr\n', sPos(1), sPos(2),-sPos(3),tPos(1),tPos(2),-tPos(3));
    fprintf(f_id, '    texture{sample_texture}\n');
    fprintf(f_id, '  }\n');
    fprintf(f_id, '  sphere\n');
    fprintf(f_id, '  {\n');
    fprintf(f_id, '    <%f,%f,%f>, r_corr\n', sPos(1), sPos(2),-sPos(3));
    fprintf(f_id, '    texture{sample_texture}\n');
    fprintf(f_id, '  }\n');
    fprintf(f_id, '  sphere\n');
    fprintf(f_id, '  {\n');
    fprintf(f_id, '    <%f,%f,%f>, r_corr\n', tPos(1),tPos(2),-tPos(3));
    fprintf(f_id, '    texture{sample_texture}\n');
    fprintf(f_id, '  }\n');
end
fprintf(f_id, '}\n');
fclose(f_id);

%
mesh2povray(sourceShape, [foldername, 'source.inc']);
mesh2povray(targetShape, [foldername, 'target.inc']);
%
