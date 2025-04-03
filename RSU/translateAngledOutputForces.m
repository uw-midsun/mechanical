% ----------------------------------------------------------------------- %
%
% Function translate forces from global car coordinate system to part
%   coordinate system
%
%   - Uses rotation matrix to rotate y and z components by theta
%   - Returns 1x15 matrix of force components
%   - R1-Case1 R2-Case1 R2-Case2 R2-Case2 RS
%
% ----------------------------------------------------------------------- %

function angledOutputForces = translateAngledOutputForces(translatedLocalXYZ)
refVec = [0 0 -1];

Fyz1 = [0 translatedLocalXYZ(2), translatedLocalXYZ(3)];
Fyz2 = [0 translatedLocalXYZ(5), translatedLocalXYZ(6)];
FyzS = [0 translatedLocalXYZ(14), translatedLocalXYZ(15)];

Ayz1 = acosd(dot(Fyz1,refVec)/norm(Fyz1));
Ayz2 = acosd(dot(Fyz2,refVec)/norm(Fyz2));
AyzS = 360 - acosd(dot(FyzS,refVec)/norm(FyzS));

if Fyz1(2) < 0
    Ayz1 = 360 - Ayz1;
end

if Fyz2(2) < 0
    Ayz2 = 360 - Ayz2;
end

angledOutputForces = double([translatedLocalXYZ(1), norm(Fyz1), Ayz1, norm(Fyz2), Ayz2, norm(FyzS), AyzS]);
end