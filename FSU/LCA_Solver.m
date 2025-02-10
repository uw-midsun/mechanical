function [node_10, node_11, node_13] = LCA_Solver(node_7, node_10, node_11, node_13, node_14)
    
    % Retrieve the applied force at node_7
    force_7 = node_7.find_applied_force();
    node_7_force_x = -force_7(1);
    node_7_force_y = -force_7(2);
    node_7_force_z = -force_7(3);
    
    % Calculate push rod displacements
    syms pr_x pr_y F13x F13y

    eq1 = pr_x == node_14.location(1) - node_13.location(1);
    eq2 = pr_y == node_14.location(2) - node_13.location(2);
    eq3 = F13y * (node_13.location(1) - node_10.location(1)) - F13x * (node_13.location(2) - node_10.location(2)) + node_7_force_y * (node_7.location(1) - node_10.location(1)) -  node_7_force_x * (node_7.location(2) - node_10.location(2))== 0;
    eq4 = (pr_x/pr_y) == (F13x/F13y);
    
    solutions = solve([eq1, eq2, eq3, eq4], [pr_x, pr_y, F13x, F13y]);

    node_13_force_x = solutions.F13x;
    node_13_force_y = solutions.F13y;
    %{
    % Calculate force at node_13
    node_13_force_x = (node_7_force_x * abs(node_7.location(2) - node_10.location(2)) + node_7_force_y * abs(node_7.location(1) - node_10.location(1))) / -(abs(node_13.location(2) - node_10.location(2)) + (push_rod_y / push_rod_x) * abs(node_13.location(1) - node_10.location(1)));
    node_13_force_y = -(push_rod_y/push_rod_x)*node_13_force_x;
    %}

    %Calculate force at node 11
    node_11_force_x = (-node_13_force_x*abs(node_10.location(3)-node_13.location(3)) - node_7_force_x*abs(node_10.location(3)-node_7.location(3)) + node_7_force_z*abs(node_10.location(1)-node_7.location(1)))/abs(node_10.location(3)-node_11.location(3));
    node_11_force_y = (node_7_force_z*abs(node_7.location(2)-node_10.location(2)) - node_7_force_y*abs(node_7.location(3)-node_10.location(3)) - node_13_force_y*abs(node_7.location(3)-node_13.location(3)))/abs(node_7.location(3)-node_11.location(3));
    node_11_force_z = -0.5*node_7_force_z;
    
    %Calculate force at node 11
    node_10_force_x = -node_11_force_x - node_7_force_x;
    node_10_force_y = -node_11_force_y - node_7_force_y;
    node_10_force_z = -0.5*node_7_force_z;
    
    % Update node forces with the solutions
    node_10.modify_force([node_10_force_x, node_10_force_y, node_10_force_z]);
    node_11.modify_force([node_11_force_x, node_11_force_y, node_11_force_z]);
    node_13.modify_force([node_13_force_x, node_13_force_y, 0]);
end
