function [node_15, node_16, shock_force, shock_length] = bellcrank_solver(node_14, node_15, node_16, node_17)
    
    % Retrieve the applied force at node 14
    force_14 = node_14.applied_force();
    node_14_force_x = force_14(1);
    node_14_force_y = force_14(2);

    % Calculate displacements
    shock_x = (node_17.location(1) - node_16.location(1));
    shock_y = (node_17.location(2) - node_16.location(2));
    
    syms F16x F16y
    eq1 = node_14_force_y * (node_14.location(1) - node_15.location(1))  - node_14_force_x * (node_14.location(2) - node_15.location(2)) + F16y * (node_16.location(1) - node_15.location(1)) - F16x * (node_16.location(2) - node_15.location(2)) == 0;
    eq2 = (shock_x/shock_y) == (F16x/F16y);

    solutions = solve([eq1, eq2], [F16x, F16y]);
    node_16_force_x = solutions.F16x;
    node_16_force_y = solutions.F16y;

    %{
    % Get bellcrank -> shock forces
    node_16_force_y = (node_14_force_y*abs(node_15.location(1) - node_14.location(1)) - node_14_force_x*(node_15.location(2) - node_14.location(2)))/(abs(node_16.location(1) - node_15.location(1)) + (shock_x/shock_y)*abs(node_16.location(2) - node_15.location(2)));
    node_16_force_x = (shock_x/shock_y)*node_16_force_y;
    %}
    % Get bellcrank clevis forces
    node_15_force_x = -node_16_force_x - node_14_force_x;
    node_15_force_y = -node_16_force_y - node_14_force_y;
    
    % Update forces on Node 15 and Node 16
    node_15.modify_force([node_15_force_x, node_15_force_y, 0]);
    node_16.modify_force([node_16_force_x, node_16_force_y, 0]);
    
    %Get shock length and forces
    shock_length = (sqrt((shock_x)^2 + (shock_y)^2));
    
    shock_force = double(sqrt((node_16_force_y)^2 + (node_16_force_x)^2));
    
end
