% Code to spatially calibrate and image.
% Code asks user to draw a line and then to specify the length
% of the line in real world units.  It then calculates a spatial calibration factor.
% User can then draw lines and have them reported in real world units.
% Take out the next two lines if you're transferring this to your program.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
clc;    % Clear the command window.
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;
fontSize = 20;
% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
  % User does not have the toolbox installed.
  message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
  reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
  if strcmpi(reply, 'No')
    % User said No, so exit.
    return;
  end
end
% Read in a standard MATLAB gray scale demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'cameraman.tif';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
  % File doesn't exist -- didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 1, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 
% Initialize
units = 'pixels';
spatialCalibration = 1.0;
button = 1;
while button ~= 3
  % Get which action the user wants to do.
  button = menu('Choose an action', 'Calibrate', 'Measure', 'Exit');
  if button == 3
    % Bail out because they clicked Exit.
    break;
  end
  % Make caption the instructions.
  subplot(2, 1, 1);
  title('Left-click first point.  Right click last point.', 'FontSize', fontSize);
  % Ask user to plot a line.
  [x, y, profile] = improfile();
  % Restore caption.
  title('Original Grayscale Image', 'FontSize', fontSize);
  % Calculate distance
  distanceInPixels = sqrt((x(1)-x(end))^2 + (y(1)-y(end))^2);
  % Plot it.
  subplot(2,1,2);
  plot(profile);
  grid on;
  
  % Initialize
  realWorldNumericalValue = distanceInPixels;
  caption = sprintf('Intensity Profile Along Line\nThe distance = %f pixels', ...
    distanceInPixels);
  title(caption, 'FontSize', fontSize);
  ylabel('Gray Level', 'FontSize', fontSize);
  xlabel('Pixels Along Line', 'FontSize', fontSize);
  if button == 1
    % They want to calibrate.
    % Ask user for a number.
    userPrompts = {'Enter true size:','Enter units:'};
    defaultValues = {'180', 'cm'};
    titleBar = 'Enter known distance';
    caUserInput = inputdlg(userPrompts, titleBar, 2, defaultValues);
    if isempty(caUserInput),return,end; % Bail out if they clicked Cancel.
    
    % Initialize.
    realWorldNumericalValue = str2double(caUserInput{1});
    units = char(caUserInput{2});
    
    % Check for a valid integer.
    if isnan(realWorldNumericalValue)
      % They didn't enter a number.  
      % They clicked Cancel, or entered a character, symbols, or something else not allowed.
      message = sprintf('I said it had to be an number.\nI will use %d and continue.', distanceInPixels);
      uiwait(warndlg(message));
      realWorldNumericalValue = distanceInPixels;
      units = 'pixels';
      spatialCalibration = 1.0;
%       continue; % Skip to end of loop.
    end
    spatialCalibration = realWorldNumericalValue / distanceInPixels;
  end
  realWorldDistance = distanceInPixels * spatialCalibration;
  caption = sprintf('Intensity Profile Along Line\nThe distance = %f pixels = %f %s', ...
    distanceInPixels, realWorldDistance, units);
  title(caption, 'FontSize', fontSize);
  ylabel('Gray Level', 'FontSize', fontSize);
  xlabel('Pixels Along Line', 'FontSize', fontSize);
end