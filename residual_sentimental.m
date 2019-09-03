% cfg = [];
% cfg.method = 'headshape';
% xyz_NAS = eeg_ft_select_point3d(head_surface, 'nearest', false, 'multiple', true, 'marker', '*', [NAS, angulo] );%eeg_ft_select_point3d is a modification of FieldTrip ToolBox
% 
% xyz_RPA = eeg_ft_select_point3d(head_surface, 'nearest', false, 'multiple', true, 'marker', '*');
% xyz_LPA = eeg_ft_select_point3d(head_surface, 'nearest', false, 'multiple', true, 'marker', '*');
% %%
% 
% 
% %%
% 
% 
% 
% 
% C = get(0, 'PointerLocation') %Posicion del mouse donde sea...!!!
% 
% 
% 
% 
% %set(0,'DefaultAxesLooseInset',[0,0,0,0]);%Por defecto de ahora en adelante no habrán bordes en las figuras.
% %set(0,'units','pixels');
% %% 
% %% 1-Plotear el modelo 3D
% x=ft_plot_mesh(head_surface);
% view(180,90);
% rotate(x,[0 1 0],angulo);
% set(x,'PickableParts', 'visible');% Ensure Ability to capture mouse clicks
%% 
%% 2-Quitar los espacios en blanco en la figura...!!! 
%set(gca,'LooseInset',get(gca,'TightInset')),set(gca, 'LooseInset', [0,0,0,0]); % Funciona con el patch
%%
%% 3-Ajustar los pixeles del patch a los pixeles de la pantalla (%truesize(foto);)          
%truesize %OK para imagenes
%% 
%% 4-Mover la figura a una posición conocida (Southest)
%movegui(x,'southwest');                     %Mover la foto al suroeste...!!!
%% 
%% 5-Mover el puntero del mouse a donde quiero hacer click sobre la figura
%set(groot,'PointerLocation',[2*NAS(2), 2*NAS(1)]);       % default units are pixels so the domain is your screen resolution.
%% 
%% 6-Traer la Figura al frente...!!!
%figure(x)
%% 7-LLamar la funcion de FieldTrip que selecciona los fiduciales...!!!
%%
%% 8-Hacer Click sobre el punto de interes...!!!
% eeg_I_MakeMouese_Click();%OK
%  
% 
% 
% 
% 
% 
% 
% 
% 
% set(gcf,'units','normalized','outerposition',[0 0 1 1]);%Maximizar...!!!
% %Igualar la resolución de la imagen a la resolución de la pantalla
% %Para que exista coincidencia de las posiciones de los pixeles de la imagen con el pixel de la pantalla donde voy a poner el cursor del mouse...!!!
% Res = get(0,'ScreenPixelsPerInch'); % Resolucion de la pantalla...!!!
% infor_foto = imfinfo('D.jpg');
% infor_foto.Width  
% infor_foto.Height 
% 
% I = imread('D.jpg');
% imshow(I,'InitialMagnification',100)
% 
% truesize(x); % Ajusta el tamaño de la pantalla de forma que cada píxel de la imagen cubra un píxel de pantalla.
% 
% 
% %Traer la figura del objeto 3D al frente...!!!
% 
% %k = waitforbuttonpress; % En lugar de esperar, dar clic programatically...
% 
% %Tomar las coordenadas 3D del punto...
% [p v vi facev facei] = select3d(h);
% 
% 
% 
% 
% 
% 
% 
% 
% %1
%  xHomogeneous = [ [268.6; 196.3; 60.04] ; 1]; %****Esto es un punto en 3D ****
% %2
% xl = a.XLim;
% yl = a.YLim;
% zl = a.ZLim;
% xscale = 1/diff(xl);
% yscale = 1/diff(yl);
% zscale = 1/diff(zl);
% model_xfm = [xscale,       0,      0, -xl(1)*xscale; ...
%     0, yscale,      0, -yl(1)*yscale; ...
%     0,      0, zscale, -zl(1)*zscale; ...
%     0,      0,      0,             1];
% %3
% v = view;
% %4
% leftHandedToRightHanded = [ 1.0      0.0    0.0     0.0; ...
%     0.0      1.0    0.0     0.0; ...
%     0.0      0.0   -1.0     0.0; ...
%     0.0      0.0    0.0     1.0];
% view_xfm = leftHandedToRightHanded * v;
% %5
% old_units = a.Units;
% a.Units = 'pixels';
% viewport = a.Position;
% a.Units = old_units;
% ar = viewport(3)/viewport(4);
% %6
% fov = a.CameraViewAngle;
% tanfov = tand(fov/2);
% n = .1;
% f = 10;
% r = tanfov * ar * n;
% l = -r;
% t = tanfov * n;
% b = -t;
% proj_xfm = [2*n/(r-l),         0,  (r+l)/(r-l),            0; ...
%     0, 2*n/(t-b),  (t+b)/(t-b),            0; ...
%     0,         0, -(f+n)/(f-n), -2*f*n/(f-n); ...
%     0,         0,           -1,           0];
% % 7 
% yHomogeneous = proj_xfm*leftHandedToRightHanded*v*model_xfm*xHomogeneous;
% yNDC = yHomogeneous(1:3) ./ yHomogeneous(4);
% yViewport = [viewport(1) + 0.5*viewport(3)*(1 + yNDC(1)) ... %este es el punto 2D...*****
%    viewport(2) + 0.5*viewport(4)*(1 + yNDC(2))]
% 
% % ---- Revertir el proceso. Ahora de 3D a 2D...
% %x = [195 86];con getframe
% %x = [213 88];con gca
% u = 2*(195 - viewport(1))/viewport(3) - 1;
% v = 2*(86 - viewport(2))/viewport(4) - 1;
% pix1 = [u;v;0.5;1];
% pix2 = [u;v;1;1];
% p1M = (proj_xfm*view_xfm*model_xfm)\pix1;
% p2M = (proj_xfm*view_xfm*model_xfm)\pix2;
% p1M = p1M(1:3)./p1M(4);
% p2M = p2M(1:3)./p2M(4);
% dir = (p2M - p1M);
% dir = dir / norm(dir);
% l_min = (xl(1) - p1M(1,:))./dir(1);
% l_max = (xl(2) - p1M(1,:))./dir(1);
% pl1 = p1M + l_min.*dir;
% pl2 = p1M + l_max.*dir;
% plot3([pl1(1) pl2(1)],   [pl1(2) pl2(2)],   [pl1(3) pl2(3)], 'k-','linewidth',2);
% hold on, mesh(peaks);
% %Search the 3D point once we have the surface and the line 
% p3d = [1];  
% % P3D = [268.601220610791,196.349700994983,60.0448897451949] ;
