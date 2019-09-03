
clc
ptCloud=readObj('Model.obj')
ptCloudV = ptCloud.v;
filename='fichero_point_cloud';
pcwrite(ptCloudV,filename);


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


