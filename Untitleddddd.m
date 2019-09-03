

% con point cloud

%
ptCloud = pcread('teapot.ply');
pcshow(ptCloud); 
pcwrite(ptCloud,'teapotOut','PLYFormat','binary');


readObj('Model.obj')
% equivalente
clc
obj = readObj('Model.obj');   %use appropriate file
patch('vertices', obj.v, 'faces', obj.f.v);
shading interp
colormap(gray(256));
lighting phong
camproj('perspective');
axis square
axis off
axis equal
axis tight
cameramenu








