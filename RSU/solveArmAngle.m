% ----------------------------------------------------------------------- %
%
% Function to calculate angle of traling arm relative to xz plane given a
% length of the shock
%
%   - Returns angle of arm
%
% ----------------------------------------------------------------------- %

function armAngle = solveArmAngle(shock_length_at_applied_load)
    G = GlobalVars.getInstance();
    armAngle = pi/2 - acos((C.nub_dist^2 - shock_length_at_applied_load^2 + G.origin_to_p2^2) / (2 * C.nub_dist * G.origin_to_p2)) - atan(-G.p2z / G.p2y) - G.theta2;
end