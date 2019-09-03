function [X Y] = proyection_2D_3D(head_surface , punto)
% Input:
%      x2d: vector FILA con las coordenadas X y Y del punto q se quiere proyectar en 3D
%           Esta entrada es en coordenadas intrinsecas, hay que convertirlas a world cordinates !!!
% Output:
%       X Y Z: Coordenadas en 3D como vector fila...!!!

% x = ft_plot_mesh(head_surface);
% view(180,90);
% rotate(x,[0 1 0],angulo); 
% imagen = getframe;
% close all;
% imshow(imagen.cdata)

% Problema directo...!!!
% x3d = [79.87 -89.5 106.3 1]';
% A = viewmtx(180,90);
% % x2d = -(A*x3d);   % Da esto:  % [ -79.87 89.5 106.3 1 ]; 
% % x2d = x2d'
% 
% % Problema inverso 2D a 3D ... 
% clc, close all;
% t=-[x2d(1,1) x2d(1,2) 1,1]';
% x3d = inv(A)*t; % Da esto: [79.87 ; -89.5 ; -1 -1]   Da ok la X y la Y...!!!  Pero no tengo la tercera componente de x2d (y hay que poner signo opuesto de x2d)
% 


% Buscar la Z comun para esta X y esta Y... !!! A esto se resume la proyecion!!!!!!!!!!!!!!!!!!!!!!!
% Buscar la X

% Primero: Convertir x2d a world axes   
% x = ft_plot_mesh(head_surface);
% view(180,90);
% rotate(x,[0 1 0],angulo); 
% imagen = getframe;
% close all;
% imshow(imagen.cdata)


centro = [398/2 313/2];

y3 = NAS(1,2) - centro; 





% Buscar la Y

X = x3;
Y = y3;





