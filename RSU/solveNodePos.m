% ----------------------------------------------------------------------- %
%
% Function to calculate position of nodes on trailing arm suspention
%
%   - Returns 8x3 matrix of node locations
%
% ----------------------------------------------------------------------- %

function N = solveNodePos(theta_arm_ground)
G = GlobalVars.getInstance();

N1 = [0, 0, 0]; 
N2 = [C.mount_dist1, 0, 0];
N3 = N2 + [C.mount_dist2, 0, 0];
N4 = N2 + [0, C.length*C.nub_percent*sin(theta_arm_ground), -C.length*C.nub_percent*cos(theta_arm_ground)];
N5 = N2 + [0, C.length*sin(theta_arm_ground), -C.length*cos(theta_arm_ground)];
N6 = N4 + [0, C.nub*sin(pi/2 - theta_arm_ground), +C.nub*cos(pi/2 - theta_arm_ground)];
N7 = N2 + [0, G.p2y, G.p2z];
N8 = N5 + [C.wheel_offset, 0, 0];

N = [N1; N2; N3; N4; N5; N6; N7; N8];
end