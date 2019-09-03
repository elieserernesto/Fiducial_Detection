function eeg_J_mueve_el_mouse(adonde)
% adonde: vector 1x2
import java.awt.Robot;
mouse = Robot;
mouse.mouseMove(0, 0);
screenSize = get(0, 'screensize');
mouse.mouseMove(adonde(1),adonde(1));
