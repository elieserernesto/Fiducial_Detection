%% Load fieldtrip toolbox
clc, clear all
cd E:\___FieldTrip\fieldtrip-20171231
ft_defaults

%% Load and plot the model of the subject
cd E:\10_Electrodes_recognition
head_surface = ft_read_headshape('Model.obj');
head_surface = ft_convert_units(head_surface, 'mm');
ft_plot_mesh(head_surface);

%% Locate anatomical marks. (Press 'q' when done, 'r' to remove)
cfg = [];
cfg.method = 'headshape';
fiducials = ft_electrodeplacement(cfg,head_surface);

%% Record the scanner information with the coordinate system 
cfg = [];
cfg.method = 'fiducial';
cfg.coordsys = 'ctf';
cfg.fiducial.nas = fiducials.elecpos(1,:); % NAS position
cfg.fiducial.lpa = fiducials.elecpos(2,:); % LPA position
cfg.fiducial.rpa = fiducials.elecpos(3,:); % RPA position
head_surface = ft_meshrealign(cfg,head_surface);
close all
ft_plot_axes(head_surface);
ft_plot_mesh(head_surface);

%% Locate the electrodes (Press 'q' when done, 'r' to remove)
cfg = [];
cfg.method = 'headshape';
elec = ft_electrodeplacement(cfg,head_surface);
elect.label(61:65) = { ...
'GND'
'REF'
'NAS'
'LPA'
'RPA'
};
close all, ft_plot_mesh(head_surface)
ft_plot_sens(elec)

%% Vizualize electrodes  
figure,ft_plot_sens(elec, 'label','on');
save('posicion_electrodos.mat','elec');
cfg=[];
cfg.method = 'moveinward';
cfg.moveinward = 6;

cfg.elec = elec;
ft_plot_mesh(head_surface)
hold on, plot3(elec.elecpos(:,1),elec.elecpos(:,2), elec.elecpos(:,3),'*','color','r'), h=findobj(gca,'Type','line','-not','Color','b');set(h,'LineWidth',5);

%% salvar las coordenadas
temp=elec.elecpos;
save('posicion_de_electrodos_asciil.mat','temp','-ascii');
save('posicion_de_electrodos_normal.mat','temp'); 

