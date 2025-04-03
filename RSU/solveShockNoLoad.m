% ----------------------------------------------------------------------- %
%
% Function to calculate the length of the shock when no load is applied
%
%   - Returns length of shock at no load
%
% ----------------------------------------------------------------------- %

function shock_no_load = solveShockNoLoad()
G = GlobalVars.getInstance();

F2 = (C.Mx_max + C.Fy_max * sin(pi/2 - G.theta3) * C.length + C.Fz_max * sin(G.theta3) * C.length) / (C.nub_dist);
shock_no_load = F2/C.spring_constant + C.shock_max_comp;
end