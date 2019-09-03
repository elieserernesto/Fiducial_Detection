
function fiducials  = eeg_H_proyecccion_Fiducials(NAS,angulo,RPA, LPA, head_surface )
%% 
clc, close all;

cfg = [];
cfg.method = 'headshape';

save 'NAS_file' 'NAS' 'angulo';
NAS3d = eeg_ft_electrodeplacement_NAS(cfg, head_surface); 

save 'RPP_file' 'RPA' 'angulo';
RPP3d = eeg_ft_electrodeplacement_RPP(cfg, head_surface); 

save 'LPP_file' 'LPA' 'angulo';
LPP3d = eeg_ft_electrodeplacement_LPP(cfg, head_surface); 

posicion_electrodos = [NAS3d.elecpos; LPP3d.elecpos; RPP3d.elecpos];

fiducials = NAS3d;
fiducials.elecpos = posicion_electrodos;

