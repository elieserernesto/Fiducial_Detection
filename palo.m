function palo()

%% Esto pincha en talla para cambiarle el tamano a una imagen y ponerle el mouse arriba
clc;close all;
c = checkerboard;
c = [c,c,c,c;c,c,c,c];
x=imshow(c,'InitialMagnification','fit')

set(gcf,'units','pixels');
set(gca,'units','pixels');
truesize;
movegui(x,[1 1])

x = get(gca,'Position');   % get the position of the axes
set(gca,'position',[0.5 0.5 x(3) x(4)]);% set the position of the figure to the length and width of the axes
set(gcf, 'Position', [1 1 x(3) x(4)])
set(groot,'PointerLocation',[x(3), x(4)]);


s=[];




