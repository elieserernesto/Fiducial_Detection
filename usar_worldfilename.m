
function R = usar_worldfilename(nombre_fichero)
clc
filename = 'concord_ortho_w.tif';
[X, cmap] = imread(filename);
worldFileName = getworldfilename(filename);
R = worldfileread(worldFileName, 'planar', size(X)); % Type of referencing object: 'geographic' o 'planar'. En este caso es: planar


% filename = 'boston_ovr.jpg';
% RGB = imread(filename);
% worldFileName = getworldfilename(filename);
% R = worldfileread(worldFileName, 'geographic', size(RGB)) ;

