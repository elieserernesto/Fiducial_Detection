
% Trucos y Marañas...!!!

 % truesize;                           % Ajustar la foto a la resolucion de la pantalla pixel a pixel...!!!
 % Position dentro de la figura [left bottom width height]
 % movegui(x,'southwest');             % Mover la foto al suroeste...!!!
 % movegui(x,[1 1])                    % mover a una posicion especifica
 % puntero = get(0, 'PointerLocation') % Posicion del mouse donde sea...!!!
 % set(0,'units','pixels');            % Hacer que todo sea pixeles
 % set(groot,'PointerLocation',[alto_frama-NAS(1), NAS(2)]);% MOver el puntero del mouse  (x, y)
 % eeg_I_MakeMouese_Click();%OK hacer click con el mouse 
 % figure('WindowState', 'fullscreen', 'MenuBar', 'none', 'ToolBar', 'none'); % Maximizar sin bordes ni nada
 % datacursormode on;                  % Activar el data tip automaticamente

% Resolucion real de la pantalla 
% jScreenSize = java.awt.Toolkit.getDefaultToolkit.getScreenSize
% width = jScreenSize.getWidth
% height = jScreenSize.getHeight
 
% iptgetpref('ImshowInitialMagnification',100); % 1x1 los pixeles de las imagenes con respecto a los pixeles de la pantalla
% iptsetpref('ImshowInitialMagnification',100); % 'fit' o 100 de esta manera se rellena la figura

% % Ajustar las dimensiones de la figura para una
% set(0,'units','pixels');
% tempo = groot;
% screen_resolution_dpi = tempo.ScreenPixelsPerInch;% dpi de la pantalla
% image_resolution_dpi  = ******************************************************
% tempo = gcf;
% tempo = tempo.Position;
% image_heigth_pixel = tempo(4);
% real_heigth_of_the_image_mm = image_heigth_pixel / image_resolution_dpi; 
% calibration_factor = real_heigth_of_the_image_mm / image_heigth_pixel;
% NAS_correction = NAS * calibration_factor;% Correccion de las corrdenadas del NAS



