    function [x] = unproject(cam, C, u, d)
      % UNPROJECT Take an image plane point u, and unproject it back into 3D space.
      % If the distance d is given, it is set as the fixed distance between the camera
      % and the point. Otherwise, the distance is left unmodified. The returned point
      % is homogeneous with a fourth component of 1.0.
      %
      % C: camera matrix of the form [R' -Rt; 0 0 0 1]
      % u: 2D point in image plane, without distortion
      % d: distance to new 3D point from camera (optional)
      % x: calculated 3D point
      n = size(u, 2);
      u = u - repmat(cam.center, 1, n);
      x = [u ./ repmat(cam.focal, 1, n); ones(1,n)];
      if nargin > 3
        for i = 1:n
          x(:,i) = d * x(:,i) / norm(x(:,i));
        end
      end
      x = inv(C) * [x; ones(1,n)];
      x = x(1:3,:);
end