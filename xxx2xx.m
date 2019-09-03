
%% 3D ---> 2D : https://la.mathworks.com/matlabcentral/answers/373545-how-can-i-convert-from-the-pixel-position-in-an-image-to-3d-world-coordinates 

clc;clear all, close all;

home = cd;
disp('Select the path of FieldTrip Toolbox');%cd E:\___FieldTrip\fieldtrip-20171231 
FieldTrip_path = uigetdir 
cd(FieldTrip_path)
ft_defaults

cd(home)
disp('Select the OBJ file');OBJ_file = uigetfile('*.obj');
head_surface = ft_read_headshape(OBJ_file);
head_surface = ft_convert_units(head_surface, 'mm');
ft_plot_mesh(head_surface);

%plot3([1 2 3], [4 5 6], [7 8 9]);

a=gca;
x = [-215.6; 196.3; -73.88]; 

%-1 
%Convert the model's Cartesian coordinates to homogeneous coordinates. 
%If a point on the model is specified by the column vector 'x', you can do this as shown below:
xHomogeneous = [x;1];
%-2
%Perform a 'model transform', which scales the 'Cartesian' portion of the vector such that each component lies in the range 0 to 1. 
%The 4th element (the homogeneous part) remains untouched. This is described by the matrix below
xl = a.XLim;
yl = a.YLim;
zl = a.ZLim;
xscale = 1/diff(xl);
yscale = 1/diff(yl);
zscale = 1/diff(zl);
model_xfm = [xscale,      0,      0, -xl(1)*xscale; ...
                  0, yscale,      0, -yl(1)*yscale; ...
                  0,      0, zscale, -zl(1)*zscale; ...
                  0,      0,      0,             1];
%-3   
%Obtain the 'view matrix' for the current axes. 
%This matrix describes the coordinate transformation that takes 'model' coordinates to 'camera' coordinates. 
%These are coordinates such that the camera is positioned at the origin and looking down the negative z-axis. 
%The code below shows how to do this given an axes handle 'a'.
v = view(a);    
%-4    
%Convert the coordinates from right-handed to left handed by using the matrix below, which inverts the z-coordinate. 
%Construct the total view matrix by multiplying this by 'v':
leftHandedToRightHanded = [ 1.0      0.0    0.0     0.0; ...
                               0.0      1.0    0.0     0.0; ...
                               0.0      0.0   -1.0     0.0; ...
                               0.0      0.0    0.0     1.0];
view_xfm = leftHandedToRightHanded * v;    
%-5
%Construct the viewport that the final image will be projected onto. This is essentially just an axes with the location in pixels. 
%For example, if the model is originally plotted in the axes 'a' referenced above, a new viewport can be constructed as below:
old_units = a.Units;
a.Units = 'pixels';
viewport = a.Position;
a.Units = old_units;
ar = viewport(3)/viewport(4);
%-6
%Compute the projection transform. To do this, you need to construct an imaginary frustum that encapsulates the scene. 
%Note that the frustum is specified in 'camera' coordinates. To do this, you can use the same format that OpenGL uses for the projection matrix. 
%This is shown in the code snippet below
fov = a.CameraViewAngle;
tanfov = tand(fov/2);
n = .1;
f = 10;
r = tanfov * ar * n;
l = -r;
t = tanfov * n;
b = -t;
proj_xfm = [2*n/(r-l),         0,  (r+l)/(r-l),            0; ...
               0, 2*n/(t-b),  (t+b)/(t-b),            0; ...
               0,         0, -(f+n)/(f-n), -2*f*n/(f-n); ...
               0,         0,           -1,           0];
%-7
%Finally, after applying the projective transform, convert to 'normalized device coordinates' by dividing by the fourth element of the vector. 
%Then, convert to viewport coordinates. These steps are illustrated below. Note that the entire transformation is shown here.
yHomogeneous = proj_xfm*leftHandedToRightHanded*v*model_xfm*xHomogeneous;
yNDC = yHomogeneous(1:3) ./ yHomogeneous(4);
yViewport = [viewport(1) + 0.5*viewport(3)*(1 + yNDC(1)) ...
                viewport(2) + 0.5*viewport(4)*(1 + yNDC(2))]      
            
            
%% *****************************************************************************************************************************************
% 2D ---> 3D   u=474.4930   v=373.0487

img = getframe;
img = img.cdata;
imshow(img)
u=190;
v=342;

% saveas(gcf,'img.jpg');
% img = imread('img.jpg');
% imshow(img)
% u = 416;
% v = 179;


%% 1. Pick a pixel location '[u,v]'. Convert it from viewport coordinates to normalized device coordinates as shown below:
u = 2*(u - viewport(1))/viewport(3) - 1;
v = 2*(v - viewport(2))/viewport(4) - 1;

%% 2. Expand it to two 4D homogeneous coordinates by making two vectors, one with z = 0.5, and the other with z = 1. Both should have 1 set for the fourth element:
pix1 = [u;v;0.5;1];
pix2 = [u;v;1;1];

%% 2. Reverse the forward transformation for both points:
p1M = (proj_xfm*view_xfm*model_xfm)\pix1;
p2M = (proj_xfm*view_xfm*model_xfm)\pix2;

%% 3. Perform perspective division to get 'real world' coordinates:
p1M = p1M(1:3)./p1M(4);
p2M = p2M(1:3)./p2M(4);

%% 4. Find a direction vector connecting these two points:
dir = (p2M - p1M);
dir = dir / norm(dir);

%%5. Find the portion of the line connecting these two points that lies within the x-limits specified by the axes, and plot:
l_min = (xl(1) - p1M(1,:))./dir(1);
l_max = (xl(2) - p1M(1,:))./dir(1);
pl1 = p1M + l_min.*dir;
pl2 = p1M + l_max.*dir;

plot3([pl1(1) pl2(1)],   [pl1(2) pl2(2)],   [pl1(3) pl2(3)], 'k-','linewidth',2);
hold on, plot3([1 2 3], [4 5 6], [7 8 9]);


% x = [-219.7; 191.5; -70.88];



