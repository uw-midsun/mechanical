% ----------------------------------------------------------------------- %
%
% Function to calculate geometry of system when load is applied
%
%   - 2D Equlibrium equation about yz plane
%   - Returns vector [shockAtLoad, armAngleAtLoad,
%   theta_spring_not_relative]
%   - Solves nonlinear system of equations with fsolve and error function
%
% ----------------------------------------------------------------------- %

function geometryAtLoad = solveGeometryAtLoad(FA, MA)

G = GlobalVars.getInstance();
% Initial guess for shock length at applied load
shock_length_sol = G.shockNoLoad;

% Solving for shock length at applied load
g = @(shock_length_at_applied_load) compute_sum_of_moments(shock_length_at_applied_load, FA, MA);
shockAtLoad = fsolve(g, shock_length_sol, optimoptions('fsolve', 'Display', 'off'));

armAngleAtLoad = solveArmAngle(shockAtLoad);

theta_spring_relative = acos((C.nub_dist^2 + shockAtLoad^2 - G.origin_to_p2^2) / (2 * C.nub_dist * shockAtLoad));
theta_spring_not_relative = theta_spring_relative - G.theta2 - armAngleAtLoad;

geometryAtLoad = [shockAtLoad, armAngleAtLoad, theta_spring_not_relative];
end

    
function error = compute_sum_of_moments(shock_length_at_applied_load, FA, MA)
  G = GlobalVars.getInstance();

    theta_spring_relative = acos((C.nub_dist^2 + shock_length_at_applied_load^2 - G.origin_to_p2^2) / (2 * C.nub_dist * shock_length_at_applied_load));

    theta_arm_ground = pi/2 - acos((C.nub_dist^2 - shock_length_at_applied_load^2 + G.origin_to_p2^2) / (2 * C.nub_dist * G.origin_to_p2)) - atan(-G.p2z / G.p2y) - G.theta2;

    error = C.spring_constant * (G.shockNoLoad - shock_length_at_applied_load) - (MA(1) + FA(2) * sin(pi/2 - theta_arm_ground) * C.length + FA(3) * sin(theta_arm_ground) * C.length) / ...
          (sin(theta_spring_relative) * C.nub_dist); % = sum of moments
end
