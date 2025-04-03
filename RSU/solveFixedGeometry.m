% ----------------------------------------------------------------------- %
%
% Function to solve for trailing arm rest angle, location of shock mount, 
%   theta2, theta3
%
%   - Function directly edits global variables
%   - Uses fsolve to solve nonlinear system of equations
%   - fsolves starts with a guess for the rest angle and iterates until the
%   error function returns a difference of 0 between the calculated and
%   theoretical spring constants
%
% ----------------------------------------------------------------------- %

function solveFixedGeometry()
G = GlobalVars.getInstance();
% Initial guess for theta
theta_guess = 0.1;

f = @(theta) compute_spring_constant(theta); 
G.restAngle = fsolve(f, theta_guess, optimoptions('fsolve', 'Display', 'off'));

G.theta3 = asin((C.height + C.length * sin(G.restAngle)) / C.length);
G.theta2 = asin(C.nub / C.nub_dist);

G.p2y = C.nub_dist * sin(G.theta2 + G.theta3) + C.shock_max_comp * sin(pi/2 - G.theta2 - G.theta3);
G.p2z = -C.nub_dist * cos(G.theta2 + G.theta3) + C.shock_max_comp * cos(pi/2 - G.theta2 - G.theta3);

G.origin_to_p2 = sqrt(G.p2y^2 + G.p2z^2);
end


function error = compute_spring_constant(theta)
    theta3 = asin((C.height + C.length * sin(theta)) / C.length);
    theta2 = asin(C.nub / C.nub_dist);

    p2y = C.nub_dist * sin(theta2 + theta3) + C.shock_max_comp * sin(pi/2 - theta2 - theta3);
    p2z = -C.nub_dist * cos(theta2 + theta3) + C.shock_max_comp * cos(pi/2 - theta2 - theta3);

    p1y = C.nub_dist * sin(theta + theta2);
    p1z = -C.nub_dist * cos(theta + theta2);

    shock_rest = sqrt((p2y - p1y)^2 + (p1z - p2z)^2);

    theta_spring = atan((p2y - p1y) / (p2z - p1z));
    theta_spring_relative = theta_spring + theta2 + theta;

    F1 = (C.Mx_rest + C.Fy_rest * sin(pi/2 - theta) * C.length + C.Fz_rest * sin(theta) * C.length) / (sin(theta_spring_relative) * C.nub_dist);

    F2 = (C.Mx_max + C.Fy_max * sin(pi/2 - theta3) * C.length + C.Fz_max * sin(theta3) * C.length) / (sin(pi/2) * C.nub_dist);

    error = (F2 - F1) / (shock_rest - C.shock_max_comp) - C.spring_constant;
end