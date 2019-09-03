function fff = eeg_Gen_Cord_Sys(head_surfacex, Fiducials)
clc
close all;

cfg = [];
cfg.method = 'fiducial';
cfg.coordsys = 'ctf';
cfg.fiducial.nas = Fiducials.elecpos(1,:); % NAS position
cfg.fiducial.lpa = Fiducials.elecpos(2,:); % LPA position
cfg.fiducial.rpa = Fiducials.elecpos(3,:); % RPA position
head_surfacex = ft_meshrealign(cfg,head_surfacex);
close all
ft_plot_axes(head_surfacex);
ft_plot_mesh(head_surfacex);


