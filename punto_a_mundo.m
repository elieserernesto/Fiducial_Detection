
function coord3d = punto_a_mundo(p2d, ang, surface)

ft_plot_mesh(surface);
view(180,90);
rotate(x,[0 1 0],ang);
imagen = getframe;
images = imagen.cdata;
imageSize = [size(images,1) size(images,2)];





fisheyeParams = estimateFisheyeParameters(imagePoints,worldPoints,imageSize);
intrinsics = fisheyeParams.Intrinsics;
