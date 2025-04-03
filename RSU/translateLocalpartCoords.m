% ----------------------------------------------------------------------- %
%
% Function translates forces from global car coordinate system to part
%   coordinate system at angle
%
%   - Uses rotation matrix to rotate y and z components by theta
%   - Returns 1x15 matrix of force components
%   - R1-Case1 R2-Case1 R2-Case2 R2-Case2 RS
%
% ----------------------------------------------------------------------- %

function translatedLocalXYZ = translateLocalpartCoords(outputReactionForces, theta)
rotationMatrix = [1,  0,           0;
       0,  cos(theta),  -sin(theta);
       0, sin(theta),  cos(theta)];

translatedLocalXYZ = double(reshape((outputReactionForces*rotationMatrix)', 1, []));
end