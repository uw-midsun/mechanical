function node_5 = spindle_solver(node_1, node_5)
    % Function to calculate and update spindle forces and moments
    
    % Extract locations
    location_1 = node_1.find_location();
    location_5 = node_5.find_location();
    
    % Extract forces from node_1
    force_1 = node_1.find_applied_force();
    force_x = force_1(1);
    force_y = force_1(2);
    force_z = force_1(3);
    
    % Calculate the moments at node_5 based on node_1's location and forces
    %{
    moment_5_x = force_y * (location_5(3) - location_1(3)) + force_z * (location_1(2) - location_5(2));
    moment_5_y = force_z * (location_5(1) - location_1(1)) + force_x * (location_5(3) - location_1(3));
    moment_5_z = force_y * (location_5(1) - location_1(1)) + force_x * (location_1(2) - location_5(2));
    %}
        % Calculate the moments at node_5 based on node_1's location and forces
    moment_5_x = force_z * (location_1(2) - location_5(2)) - force_y * (location_1(3) - location_5(3)) ;
    moment_5_y = force_x * (location_1(3) - location_5(3)) - force_z * (location_1(1) - location_5(1)) ; 
    moment_5_z = force_y * (location_1(1) - location_5(1)) - force_x * (location_1(2) - location_5(2));
    
    %need to confirm order of operations
    node_5 = node_5.modify_force([force_x, force_y, force_z]);
    node_5 = node_5.modify_moment([moment_5_x, moment_5_y, moment_5_z]);
end
