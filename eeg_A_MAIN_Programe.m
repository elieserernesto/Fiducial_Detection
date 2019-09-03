%% % Requirements:
%% % Have three files that the scanner returns: OBJ, MTL and JPG.
%% % The recording should be made only on the upper part of the shoulders
%% % That facial features and ears must be visible
%% % Have Computer Vision System Toolbox & FieldTrip Toolbox! 

clear all, close all;

reqToolboxes = {'Computer Vision System Toolbox', 'Image Processing Toolbox'};%Load ComputerVIsion toolbox!!!
if( ~checkToolboxes(reqToolboxes) )
 error('The detectFaceParts function requires the tool boxes: "Computer Vision System Toolbox" and "Image Processing Toolbox". Please install those tool boxes...');
end 

home = cd; 
clc, disp('Select the path of FieldTrip Toolbox');%cd E:\___FieldTrip\fieldtrip-20171231 
FieldTrip_path = uigetdir 
cd(FieldTrip_path)
ft_defaults

%%
%% Load the scanner information...!!!
cd(home)
clc;disp('Select the OBJ file');OBJ_file = uigetfile('*.obj');
head_surface = ft_read_headshape(OBJ_file);
head_surface = ft_convert_units(head_surface, 'mm');
ft_plot_mesh(head_surface);
new_surface = [uint8(head_surface.pos); head_surface.color]; 

%%
%% Find the NAS by means of detectind the face parts ...!!!
[NAS angulo] = eeg_B_viola_jones(head_surface, home);

%%
%% Detect the ears (Rotating the object having as reference the angle "angulo")...!!!
[RPA2d,LPA2d] = eeg_G_PA_points(head_surface,angulo);


%%
%% Project the NAS and the preauricular points (R_PA_point and L_PA_point) onto the surface to get the fiducial corrdinates in 3D...!!!
Fiducials   = eeg_H_proyecccion_Fiducials(NAS, angulo, RPA2d, LPA2d, head_surface);% NAS-RPP-LPP
close all;
%% 
%% Generate the coordinates system (FielTrip done)...!!!
load fiducials_cfg;
Fiducials.cfg = cfg;
eeg_Gen_Cord_Sys(head_surface, Fiducials);

%% 
%% Grabar la informacion del scanner con el sistema de coordenadas...!!!


%%
%% Find the electrodes coordinates using another detector (still missing)...!!!


%% 
%% Project and visualize the electrodes (OPTIONAL)...!!! 


%% Save the electrodes coordinates to a file...!!!
%% 