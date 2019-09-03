function [NAS, angulo] = eeg_B_viola_jones(head_surface, home) 
%set(0,'units','pixels');
detector = eeg_C_buildDetector();
NAS = [];vistas=[];

%% Rotate the 3D image to find the best angle of recognition
for i=1:1:360
    close all
    x = ft_plot_mesh(head_surface);
    view(180,90); 
    rotate(x,[0 1 0],i);
    imagen = getframe;
    img = imagen.cdata;    
    [bbox bbimg faces bbfaces ] = eeg_D_detectFaceParts(detector,img,2);% Recognize the face parts...!!!
    %imshow(bbimg);
    [cuantasencontro,kk] = size(bbox);
    tam = [];
    if isempty(bbox)
        kk = [];
    elseif (cuantasencontro == 1)
        vistas = [vistas ; [bbox(:,5:12), i]]; 
    else
        tam = sum(bbox')';
        [kk,cual] = max(tam);
        vistas = [vistas ; [bbox(cual,5:12), i]]; 
    end    
end

angulo = eeg_E_mejor_vista(vistas);%Find the best angle ...!!!

%% 
%% Find the intrinsecs coordinates of the "NAS"...!!!
close all
%figure('WindowState', 'fullscreen', 'MenuBar', 'none', 'ToolBar', 'none'); 

x = ft_plot_mesh(head_surface);
view(180,90);
rotate(x,[0 1 0],angulo);
imagen = getframe;
img = imagen.cdata;
[bbox bbimg faces bbfaces ] = eeg_D_detectFaceParts(detector,img,1);% Reconocer las partes del rostro !!!
I = bbox(:,5:8);
D = bbox(:,9:12);
N = bbox(:,17:20); 
NAS = [((I(2)+D(2))/2+(I(4)+D(4))/4) , ((N(1)+N(3)/2)+(D(1)+I(1)+I(3))/2)/2 ];
NAS=round(NAS);
bbimg(NAS(1),NAS(2),:)=255;
close all;
imshow(bbimg);

%%
%%