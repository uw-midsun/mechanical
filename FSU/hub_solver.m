function [node_3, node_4] = hub_solver(node_2, node_3, node_4)
    % Function to calculate and update inner and outer hub forces
    % Context of hub
    disp_2_4_x = node_4.location(1) - node_2.location(1);
    disp_2_3_x = node_3.location(1) - node_2.location(1);

    syms F3y F3z F4y F4z
    eq1 = node_2.applied_force(2) + F3y + F4y == 0;
    eq2 = node_2.applied_force(3) + F3z + F4z == 0;
    eq3 = node_2.applied_moment(2) - disp_2_3_x * F3z - disp_2_4_x * F4z == 0;
    eq4 = node_2.applied_moment(3) + disp_2_3_x * F3y + disp_2_4_x * F4y == 0;

    solutions = solve([eq1, eq2, eq3, eq4], [F3y, F3z, F4y, F4z]);
    force_y_3 = solutions.F3y;
    force_z_3 = solutions.F3z;
    force_y_4 = solutions.F4y;
    force_z_4 = solutions.F4z;

    node_3 = node_3.modify_force([0, force_y_3, force_z_3]);
    node_4 = node_4.modify_force([0, force_y_4, force_z_4]);
end

