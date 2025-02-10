function node_1 = contact_patch_solver(loading_cases, vehicle_mass, cg, node_1) 
    % Calculate forces at the contact patch node based on loading cases and vehicle mass.
    g = 9.81; % Gravitational acceleration (m/s^2)

    % Assuming loading_cases has columns [x, y, z] forces for each case
    force_x_1 = 0.25 * vehicle_mass* loading_cases(1,1) * g;  % X force
    force_y_1 = ((1-cg)/2) * vehicle_mass * loading_cases(1,2) * g;  % Y force
    force_z_1 = 0.25 * vehicle_mass * loading_cases(1,3) * g;   % Z force (Placeholder for steering integration)
    
    % Create a `node` object and assign calculated forces
    node_1 = node_1.modify_force([force_x_1 force_y_1 force_z_1]);
    
    % Moments are initialized as zero (can be updated later if needed)
    node_1 = node_1.modify_moment([0, 0, 0]);
end
