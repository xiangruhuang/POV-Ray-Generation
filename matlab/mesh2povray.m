function [] = mesh2povray(Mesh, meshFName, keyPtsFName)
Mesh.vertexNors = vertex_normal(Mesh);
%
numV = size(Mesh.vertexPoss, 2);
numF = size(Mesh.faceVIds, 2);
f_id = fopen(meshFName, 'w');
fprintf(f_id, 'mesh2 {\n');
fprintf(f_id, '  vertex_vectors {\n');
fprintf(f_id, '    %d,\n', numV);
for vId = 1 : numV
    pos = Mesh.vertexPoss(:, vId);
    if vId < numV
        fprintf(f_id, '    <%f,%f,%f>,\n', pos(1), pos(2), pos(3));
    else
        fprintf(f_id, '    <%f,%f,%f>\n', pos(1), pos(2), pos(3));
    end
end
fprintf(f_id, '  }\n');
fprintf(f_id, '  normal_vectors {\n');
fprintf(f_id, '    %d,\n', numV);
for vId = 1 : numV
    nor = Mesh.vertexNors(:, vId);
    if vId < numV
        fprintf(f_id, '    <%f,%f,%f>,\n', nor(1), nor(2), -nor(3));
    else
        fprintf(f_id, '    <%f,%f,%f>\n', nor(1), nor(2), -nor(3));
    end
end
fprintf(f_id, '  }\n');
fprintf(f_id, '  face_indices {\n');
fprintf(f_id, '  %d,\n', numF);
for fId = 1 : numF
    ids = Mesh.faceVIds(:, fId)-1;
    if vId < numV
        fprintf(f_id, '    <%d,%d,%d>,\n', ids(1), ids(2), ids(3));
    else
        fprintf(f_id, '    <%d,%d,%d>\n', ids(1), ids(2), ids(3));
    end
end
fprintf(f_id, '  }\n');
fprintf(f_id, '  texture { front_texture }\n');
fprintf(f_id, '  interior_texture {back_texture}\n');
fprintf(f_id, '}\n');
fclose(f_id);

% if length(keyPtsFName) > 0
%     f_id = fopen(keyPtsFName, 'w');
%     vertexPoss = Mesh.vertexPoss(:, Mesh.featureVIds);
%     fprintf(f_id, 'union {\n');
%     for id = 1 : size(vertexPoss, 2)
%         pos = vertexPoss(:, id);
%         fprintf(f_id, '  sphere\n');
%         fprintf(f_id, '  {\n');
%         fprintf(f_id, '    <%f,%f,%f>, r_fea\n', pos(1), pos(2),-pos(3));
%         fprintf(f_id, '    texture{fea_texture}\n');
%         fprintf(f_id, '  }\n');
%     end
%     fprintf(f_id, '}\n');
%     fclose(f_id);
% end
%

function [vertexNors] = vertex_normal(Mesh)
%
p1 = Mesh.vertexPoss(:, Mesh.faceVIds(1,:));
p2 = Mesh.vertexPoss(:, Mesh.faceVIds(2,:));
p3 = Mesh.vertexPoss(:, Mesh.faceVIds(3,:));
%
e12 = p1 - p2;
e13 = p1 - p3;
faceNors = cross(e12, e13);
norms = sqrt(sum(faceNors.*faceNors));
ids = find(norms < 1e-16);
faceNors = faceNors./(ones(3,1)*norms);
faceNors(:, ids) = [0,0,1]'*ones(1,length(ids));
numV = size(Mesh.vertexPoss, 2);
numF = size(Mesh.faceVIds, 2);
J = sparse(Mesh.faceVIds, ones(3,1)*(1:numF), ones(3, numF), numV, numF);
vertexNors = double(faceNors)*J';
norms = sqrt(sum(vertexNors.*vertexNors));
vertexNors = vertexNors./(ones(3,1)*norms);
ids = find(norms < 1e-16);
vertexNors(:, ids) = [0,0,1]'*ones(1,length(ids));