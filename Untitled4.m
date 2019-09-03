


% test de proyeccion del ALEMAN 

clear all; close all; clc; 

% Caamera-Calibration-Matrix
 K = [1.017215234570303e+03, 0, 3.195000000000000e+02, 0; 
0, 1.012549014668498e+03,2.395000000000000e+02, 0; 
0, 0, 1.0000, 0; 
0, 0, 0, 0]; 

% Transforma Matrix from 3D-World-Coordinate System to 3D-Camera-Coordinate System (Origin on CCD-Chip) 
% 
% The Camera is oriented "looking" into positive X-Direction of the World-Coordinate-System. On the picture,
% positive Y-Direction will be to the left, positive Z-Direction to the top. (right hand coordinate system!)
 R_World_to_Cam = [-0.0113242625465167   -0.999822053685344   0.0151163536128891   141.173585444427; 
0.00842007509644635   -0.0152123858102325   -0.999848810645587   1611.96528372161; 
0.999900032304804   -0.0111955728474261   0.00859117128537919   847.090629282911; 
0   0   0   1]; 

% Projection- and Transforma Matrix P 
 P = K * R_World_to_Cam; 

% arbitrary Points X_World in World-Coordinate-System [mm] (homogenous Coordinates) 
% forming a square of size 10m x 4m 
 X_World_1 = [20000; 2000;  0;  1]; 
 X_World_2 = [20000; -2000; 0;  1]; 
 X_World_3 = [10000; 2000;  0;  1]; 
 X_World_4 = [10000; -2000; 0;  1]; 

% Transform and Project from 3D-World -> 2D-Picture 
 X_Pic_1 = P * X_World_1; 
 X_Pic_2 = P * X_World_2; 
 X_Pic_3 = P * X_World_3; 
 X_Pic_4 = P * X_World_4; 

% normalize homogenous Coordinates (3rd Element has to be 1!) 
 X_Pic_1 = X_Pic_1 / X_Pic_1(3); 
 X_Pic_2 = X_Pic_2 / X_Pic_2(3); 
 X_Pic_3 = X_Pic_3 / X_Pic_3(3); 
 X_Pic_4 = X_Pic_4 / X_Pic_4(3); 

% Now for reverse procedure take arbitrary points in Camera-Picture... 
% (for simplicity, take points from above and "go" 30px to the right and 40px down) 
 X_Pic_backtransform_1 = X_Pic_1(1:3) + [30; 40; 0]; 
 X_Pic_backtransform_2 = X_Pic_2(1:3) + [30; 40; 0]; 
 X_Pic_backtransform_3 = X_Pic_3(1:3) + [30; 40; 0]; 
 X_Pic_backtransform_4 = X_Pic_4(1:3) + [30; 40; 0]; 

% ... and transform back following the formula from the Master Thesis (in German):
% Ilker Savas, "Entwicklung eines Systems zur visuellen Positionsbestimmung von Interaktionspartnern" 
 M_Mat = P(1:3,1:3);                 % Matrix M is the "top-front" 3x3 part 
 p_4 = P(1:3,4);                     % Vector p_4 is the "top-rear" 1x3 part 
 C_tilde = - inv( M_Mat ) * p_4;     % calculate C_tilde 

% Invert Projection with Side-Condition ( Z = 0 ) and Transform back to 
% World-Coordinate-System 
 X_Tilde_1 = inv( M_Mat ) * X_Pic_backtransform_1; 
 X_Tilde_2 = inv( M_Mat ) * X_Pic_backtransform_2; 
 X_Tilde_3 = inv( M_Mat ) * X_Pic_backtransform_3; 
 X_Tilde_4 = inv( M_Mat ) * X_Pic_backtransform_4; 

 mue_N_1 = -C_tilde(3) / X_Tilde_1(3); 
 mue_N_2 = -C_tilde(3) / X_Tilde_2(3); 
 mue_N_3 = -C_tilde(3) / X_Tilde_3(3); 
 mue_N_4 = -C_tilde(3) / X_Tilde_4(3); 

 
 
 % 2D -- > 3D
% Do the inversion of above steps... 
 X_World_backtransform_1 = mue_N_1 * inv( M_Mat ) * X_Pic_backtransform_1 + C_tilde; 
 X_World_backtransform_2 = mue_N_2 * inv( M_Mat ) * X_Pic_backtransform_2 + C_tilde; 
 X_World_backtransform_3 = mue_N_3 * inv( M_Mat ) * X_Pic_backtransform_3 + C_tilde; 
 X_World_backtransform_4 = mue_N_4 * inv( M_Mat ) * X_Pic_backtransform_4 + C_tilde; 


% Plot everything
figure(1); 
% First Bird Perspective of World-Coordinate System... 
subplot(1,2,1); 
xlabel('Y-World'); 
ylabel('X-World'); 
grid on; 
axis([-3000 3000 0 22000]); 
hold on; 


plot( -X_World_1(2), X_World_1(1), 'bo' ); 
plot( -X_World_2(2), X_World_2(1), 'bo' ); 
plot( -X_World_3(2), X_World_3(1), 'bo' ); 
plot( -X_World_4(2), X_World_4(1), 'bo' ); 
line([-X_World_1(2) -X_World_2(2) -X_World_4(2) -X_World_3(2) -X_World_1(2)], [X_World_1(1) X_World_2(1) X_World_4(1) X_World_3(1) X_World_1(1)], 'Color', 'blue' ); 

plot( -X_World_backtransform_1(2), X_World_backtransform_1(1), 'ro' ); 
plot( -X_World_backtransform_2(2), X_World_backtransform_2(1), 'ro' ); 
plot( -X_World_backtransform_3(2), X_World_backtransform_3(1), 'ro' ); 
plot( -X_World_backtransform_4(2), X_World_backtransform_4(1), 'ro' ); 
line([-X_World_backtransform_1(2) -X_World_backtransform_2(2) -X_World_backtransform_4(2) -X_World_backtransform_3(2) -X_World_backtransform_1(2)], [X_World_backtransform_1(1) X_World_backtransform_2(1) X_World_backtransform_4(1) X_World_backtransform_3(1) X_World_backtransform_1(1)], 'Color', 'red' ); 


hold off; 

% ...then the camera picture (perspective!)
subplot(1,2,2); 
hold on; 
image(ones(480,640).*255); 
colormap(gray(256)); 
axis([0 640 -480 0]); 
line([X_Pic_1(1) X_Pic_2(1) X_Pic_4(1) X_Pic_3(1) X_Pic_1(1)], -1*[X_Pic_1(2) X_Pic_2(2) X_Pic_4(2) X_Pic_3(2) X_Pic_1(2)], 'Color', 'blue' ); 
line([X_Pic_backtransform_1(1) X_Pic_backtransform_2(1) X_Pic_backtransform_4(1) X_Pic_backtransform_3(1) X_Pic_backtransform_1(1)], -1*[X_Pic_backtransform_1(2) X_Pic_backtransform_2(2) X_Pic_backtransform_4(2) X_Pic_backtransform_3(2) X_Pic_backtransform_1(2)], 'Color', 'red' ); 
hold off;