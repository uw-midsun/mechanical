function [node_3, node_4] = hub_solver(node_2, node_3, node_4)
    % Function to calculate and update inner and outer hub forces
    % Context of hub
    % Calculate displacement vectors
    disp_2_to_3 = node_3.find_location() - node_2.find_location();
    disp_2_to_4 = node_4.find_location() - node_2.find_location();
    disp_3_to_4 = node_4.find_location() - node_3.find_location();
    
    % Retrieve forces and moments from node_2
    force_2 = node_2.find_applied_force();
    moment_2 = node_2.find_applied_moment();
    force_y_2 = force_2(2);
    force_z_2 = force_2(3);
    moment_y_2 = moment_2(2);
    moment_z_2 = moment_2(3);
    
    % Use displacement vectors to calculate forces for node_3 and node_4
    length_2_to_4 = norm(disp_2_to_4); % Distance between node_2 and node_4
    length_2_to_3 = norm(disp_2_to_3); % Distance between node_2 and node_3
    length_3_to_4 = norm(disp_3_to_4); % Distance between node_3 and node_4

    force_y_3 = (moment_z_2 + length_2_to_4 * force_y_2) / length_3_to_4;
    force_y_4 = force_y_2 + force_y_3;

    force_z_4 = (moment_y_2 + length_2_to_3 * force_z_2) / length_3_to_4;
    force_z_3 = force_z_2 + force_z_4;

    % Update node_3 and node_4 with calculated forces
    node_3 = node_3.modify_force([0, force_y_3, force_z_3]); % Assuming Fx is 0
    node_4 = node_4.modify_force([0, force_y_4, force_z_4]);
end

