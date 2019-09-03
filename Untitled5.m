clc
obj = readObj('FileName.obj');   %use appropriate file
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