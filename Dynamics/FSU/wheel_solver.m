function node_2 = wheel_solver(node_1, node_2)
    % Function to calculate forces and moments on wheel node
    %Context of hub
    % Retrieve the locations of node_1 and node_2
    loc_1 = node_1.find_location();
    loc_2 = node_2.find_location();
    
    % Retrieve the applied force on node_1
    force_1 = node_1.find_applied_force();
    
    % Calculate the moments at node_2 caused by the forces at node_1
    moment_2_y = -force_1(1) * abs(loc_1(3) - loc_2(3));
    moment_2_z = force_1(2) * abs(loc_1(1) - loc_2(1));
    
    % Update node_2 with the reaction moments
    node_2.modify_moment([0, moment_2_y, moment_2_z]);
    force_2_x = -force_1(1);
    force_2_y = -force_1(2);
    force_2_z = -force_1(3);
    % Also set the reaction forces at node_2 equal to the applied forces at node_1
    node_2.modify_force([force_2_x, force_2_y, force_2_z]);
end

