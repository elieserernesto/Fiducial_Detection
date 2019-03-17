
%% Crear video de rotacion de las cabezas ...!!!
clc

for i=1:1:360
    x = ft_plot_mesh(head_surface);
    view(180,90);
    rotate(x,[0 1 0],i);
    FF(i)=getframe(gcf);    
    close all;
end

for k = 1:length(FF)
     mov(k) = getframe(gcf);
end
v=VideoWriter('rotando_Franco.avi');
open(v);
writeVideo(v,FF)
close(v)