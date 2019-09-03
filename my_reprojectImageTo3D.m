
function XYZ = my_reprojectImageTo3D(D, Q)
    [h,w] = size(D);
    XYZ = zeros([h,w,3], 'single');
    for x=1:h
        for y=1:w
            v = Q * [x; y; double(D(x,y)); 1];
            XYZ(x,y,:) = v(1:3) ./ v(4);
        end
    end
end

