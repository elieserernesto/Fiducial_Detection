function [PA_D,PA_I] = eeg_G_PA_points(head_surface,anguloP)
clc;close all;
set(0,'units','pixels');
vistas_derecha   = []; vistas_izquierda = []; biggerbox = [];
detector_I    = vision.CascadeObjectDetector('training_model_detector_I_HOG_2300pos_1323neg_11x0.3.xml');% This is the detector, Obviously, need to be trained previosly ...!!!
detector_D    = vision.CascadeObjectDetector('training_model_detector_D_HOG_2308pos_1323neg_8x0.3.xml');
shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0 255 0]); 
%% **********************************************************************************************************************************
%% Seeking the right ear...!!!
x = ft_plot_mesh(head_surface);
view(180,90);
rotate(x,[0 1 0],anguloP-87);%Rotation for right ear (-87) 
% saveas(gcf,'D.jpg');% It works...!!!
% D = imread('D.jpg');
D = getframe; % It doesn't (The Detector works better when reading a file than when getting the actual frame)
D = D.cdata;
bbox = step(detector_D,D);
[a b] = size(bbox);
if isempty(bbox)% Error msg ...!!!
    detector_D    = vision.CascadeObjectDetector('training_model_detector_D_HOG_2308pos_1323neg_12x0.4.xml');
    bbox = step(detector_D,D);
    if isempty(bbox)
        detector_D    = vision.CascadeObjectDetector('training_model_detector_D_HOG_2308pos_1323neg_14x0.5.xml');
        bbox = step(detector_D,D);
        if isempty(bbox)
            detector_D    = vision.CascadeObjectDetector('training_model_detector_D_HOG_2308pos_1323neg_15x0.6.xml');
            bbox = step(detector_D,D);
                    if isempty(bbox)
                        detector_D    = vision.CascadeObjectDetector('training_model_detector_D_HOG_2308pos_1323neg_19x0.7.xml');
                        bbox = step(detector_D,D);
                        
                        if isempty(bbox)%%
                            detector_D    = vision.CascadeObjectDetector('training_model_detector_D_HOG_2308pos_1323neg_21x0.8.xml');
                            bbox = step(detector_D,D);
                           if isempty(bbox)%%
                               detector_D    = vision.CascadeObjectDetector('training_model_detector_D_HOG_2308pos_1323neg_24x0.85.xml');
                               bbox = step(detector_D,D); 
                               if isempty(bbox)
                                   detector_D    = vision.CascadeObjectDetector('training_model_detector_D_HOG_2308pos_1323neg_25x0.9.xml');
                                   bbox = step(detector_D,D); 
                                   if isempty(bbox)% ultima condicion--> nunca se detecto nada---no hay orejas
                                       error('We did not find any ear... Sorry');
                                   else 
                                       [a b] = size(bbox);
                                       if (a==1)
                                           PA_D = [(bbox(1,1)+8*bbox(1,3)/10) , (bbox(1,2)+0.36*bbox(1,4))];%Encontre una sola oreja, defino el CP
                                       end
                                   end 
                               end 
                           else
                               [a b] = size(bbox);
                               if (a==1)
                                   PA_D = [(bbox(1,1)+8*bbox(1,3)/10) , (bbox(1,2)+0.36*bbox(1,4))];%Encontre una sola oreja, defino el CP
                               end
                           end
                        else
                            [a b] = size(bbox);
                            if (a==1)
                                PA_D = [(bbox(1,1)+8*bbox(1,3)/10) , (bbox(1,2)+0.36*bbox(1,4))];%Encontre una sola oreja, defino el CP
                            end
                        end 
                    else
                        [a b] = size(bbox);
                        if (a==1)
                            PA_D = [(bbox(1,1)+8*bbox(1,3)/10) , (bbox(1,2)+0.36*bbox(1,4))];%Encontre una sola oreja, defino el CP
                        end
                    end
        else
            [a b] = size(bbox);
            if (a==1)
                PA_D = [(bbox(1,1)+8*bbox(1,3)/10) , (bbox(1,2)+0.36*bbox(1,4))];%Encontre una sola oreja, defino el CP
            end
        end
    else
        [a b] = size(bbox);
        if (a==1)
            PA_D = [(bbox(1,1)+8*bbox(1,3)/10) , (bbox(1,2)+0.36*bbox(1,4))];%Encontre una sola oreja, defino el CP
        end
    end
else
    [a b] = size(bbox);
    if (a==1)
        PA_D = [(bbox(1,1)+8*bbox(1,3)/10) , (bbox(1,2)+0.36*bbox(1,4))];%Encontre una sola oreja, defino el CP
    end
end             
%% Ahora corrijo el pre-auricular derecho segun ecuacion 4 del paper...!!!
PA_D = [(bbox(1,1)+8*bbox(1,3)/10) , (bbox(1,2)+0.36*bbox(1,4))];
PA_D = round(PA_D);
box_insert = int32(bbox)';
fotoconoreja = step(shapeInserter, D, box_insert(:,:));
fotoconoreja(PA_D(2),PA_D(1),:)=255;
fotoconoreja(PA_D(2)+1,PA_D(1)+1,:)=255;
close all;
figure('units','normalized','outerposition',[0 0 1 1]);%Maximize...!!!
imshow(fotoconoreja);
pause(1)
%%
%% Seeking the left ear...!!!/************************************************************************************************************
close all;
x = ft_plot_mesh(head_surface);
view(180,90);
rotate(x,[0 1 0],anguloP+87);%Rotation for left ear (+87) 
%set(gcf,'units','normalized','outerposition',[0 0 1 1])   
% saveas(gcf,'I.jpg');% It works...!!!
% I = imread('I.jpg');
I = getframe;
I = I.cdata;
bbox = step(detector_I,I);
[a b] = size(bbox);
if isempty(bbox)% cambio el detector... 
        detector_D    = vision.CascadeObjectDetector('training_model_detector_I_HOG_2300pos_1323neg_14x0.4.xml');
    bbox = step(detector_D,D);
    if isempty(bbox)
        detector_D    = vision.CascadeObjectDetector('training_model_detector_I_HOG_2300pos_1323neg_17x0.5.xml');
        bbox = step(detector_D,D);
        if isempty(bbox)
            detector_D    = vision.CascadeObjectDetector('training_model_detector_I_HOG_2300pos_1323neg_19x0.6.xml');
            bbox = step(detector_D,D);
                    if isempty(bbox)
                        detector_D    = vision.CascadeObjectDetector('training_model_detector_I_HOG_2300pos_1323neg_25x0.7.xml');
                        bbox = step(detector_D,D);
                        if isempty(bbox)%%
                            detector_D    = vision.CascadeObjectDetector('training_model_detector_I_HOG_2300pos_1323neg_33x0.8.xml');
                            bbox = step(detector_D,D);
                           if isempty(bbox)%%
                               detector_D    = vision.CascadeObjectDetector('training_model_detector_I_HOG_2300pos_1323neg_35x0.85.xml');
                               bbox = step(detector_D,D); 
                               if isempty(bbox)
                                   detector_D    = vision.CascadeObjectDetector('training_model_detector_I_HOG_2300pos_1323neg_41x0.9.xml');
                                   bbox = step(detector_D,D); 
                                   if isempty(bbox)% ultima condicion--> nunca se detecto nada---no hay orejas
                                       error('We did not find any ear... Sorry');
                                   else 
                                       [a b] = size(bbox);
                                       if (a==1)
                                           PA_I = [ (bbox(1,1)+bbox(1,3)/5) , (bbox(1,2)+0.36*bbox(1,4)) ];%Encontre una sola oreja, defino el CP
                                       end
                                   end 
                               end 
                           else
                               [a b] = size(bbox);
                               if (a==1)
                                   PA_I = [ (bbox(1,1)+bbox(1,3)/5) , (bbox(1,2)+0.36*bbox(1,4)) ];%Encontre una sola oreja, defino el CP
                               end
                           end
                        else
                            [a b] = size(bbox);
                            if (a==1)
                                PA_I = [ (bbox(1,1)+bbox(1,3)/5) , (bbox(1,2)+0.36*bbox(1,4)) ];%Encontre una sola oreja, defino el CP
                            end
                        end 
                    else
                        [a b] = size(bbox);
                        if (a==1)
                            PA_I = [ (bbox(1,1)+bbox(1,3)/5) , (bbox(1,2)+0.36*bbox(1,4)) ];%Encontre una sola oreja, defino el CP
                        end
                    end
        else
            [a b] = size(bbox);
            if (a==1)
                PA_I = [ (bbox(1,1)+bbox(1,3)/5) , (bbox(1,2)+0.36*bbox(1,4)) ];%Encontre una sola oreja, defino el CP
            end
        end
    else
        [a b] = size(bbox);
        if (a==1)
            PA_I = [ (bbox(1,1)+bbox(1,3)/5) , (bbox(1,2)+0.36*bbox(1,4)) ];%Encontre una sola oreja, defino el CP
        end
    end
else
    [a b] = size(bbox);
    if (a==1)
        PA_I = [ (bbox(1,1)+bbox(1,3)/5) , (bbox(1,2)+0.36*bbox(1,4)) ];%Encontre una sola oreja, defino el CP
    end
end             
%% Ahora corrijo el pre-auricular derecho segun ecuacion 4 del paper...!!!
PA_I = [ (bbox(1,1)+bbox(1,3)/5) , (bbox(1,2)+0.36*bbox(1,4)) ];
PA_I = round(PA_I);
box_insert = int32(bbox)';
fotoconoreja = step(shapeInserter, I, box_insert(:,:));
fotoconoreja(PA_I(2),PA_I(1),:)=255;
fotoconoreja(PA_I(2)+1,PA_I(1)+1,:)=255;
close all;
figure('units','normalized','outerposition',[0 0 1 1]);%Maximize...!!!
imshow(fotoconoreja);
pause(1)    
%% 
%% 