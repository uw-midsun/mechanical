function [node_6, node_7, node_18] = upright_solver(node_5, node_6, node_7, node_8, node_18, node_19)
    % Known parameters
    location_5 = node_5.location;  
    location_6 = node_6.location;
    location_7 = node_7.location;
    location_8 = node_8.location;
    location_18 = node_18.location;
    location_19 = node_19.location;

    force_5 = node_5.applied_force;
    moment_5 = node_5.applied_moment;
    disp_5_6_x = node_6.location(1) - node_5.location(1);
    disp_5_7_x = node_7.location(1) - node_5.location(1);
    disp_5_18_x = node_18.location(1) - node_5.location(1);
    disp_5_6_y = node_6.location(2) - node_5.location(2);
    disp_5_7_y = node_7.location(2) - node_5.location(2);
    disp_5_18_y = node_18.location(2) - node_5.location(2);
    disp_5_6_z = node_6.location(3) - node_5.location(3);
    disp_5_7_z = node_7.location(3) - node_5.location(3);
    disp_5_18_z = node_18.location(3) - node_5.location(3);

    % Define symbolic variables for unknown forces at Node 6 and Node 7
    syms F6x F6y F6z F7x F7y F7z F18x F18y F18z

    % Force equilibrium equations (sum of forces = 0)
    eq1 = force_5(1) + F6x + F7x + F18x == 0;  
    eq2 = force_5(2) + F6y + F7y + F18y == 0;  
    eq3 = force_5(3) + F6z + F7z + F18z == 0;  

    % Moment equilibrium equations
    %{
    eq4 = moment_5(1) + abs(location_5(3) - location_7(3)) * force_5(2) + abs(location_5(2) - location_7(2)) * force_5(3) ...
        + abs(location_6(3) - location_7(3)) * F6y + abs(location_6(2) - location_7(2)) * F6z + ...
        abs(location_18(2) - location_7(2)) * F18z + abs(location_18(3) - location_7(3)) * F18y == 0;
    eq5 = moment_5(2) - abs(location_5(3) - location_7(3)) * force_5(1) + abs(location_5(1) - location_7(1)) * force_5(3) ...
        - abs(location_6(3) - location_7(3)) * F6x + abs(location_6(1) - location_7(1)) * F6z + ...
        - abs(location_18(3) - location_7(3)) * F18x - abs(location_18(1) - location_7(1)) * F18z == 0;
    eq6 = moment_5(3) - abs(location_5(2) - location_7(2)) * force_5(1) - abs(location_5(1) - location_7(1)) * force_5(2) ... 
        - abs(location_6(2) - location_7(2)) * F6x - abs(location_6(1) - location_7(1)) * F6y ...
        - abs(location_18(2) - location_7(2)) * F18x - abs(location_18(1) - location_7(1)) * F18y == 0;
    %}
    
    % Sum of moment equations
    eq4 = moment_5(1) + F6z * disp_5_6_y - F6y * disp_5_6_z + F7z * disp_5_7_y - F7y * disp_5_7_z + F18z * disp_5_18_y - F18y * disp_5_18_z == 0;
    eq5 = moment_5(2) + F6x * disp_5_6_z - F6z * disp_5_6_x + F7x * disp_5_7_z - F7z * disp_5_7_x + F18x * disp_5_18_z - F18z * disp_5_18_x == 0;
    eq6 = moment_5(3) + F6y * disp_5_6_x - F6x * disp_5_6_y + F7y * disp_5_7_x - F7x * disp_5_7_y + F18y * disp_5_18_x - F18x * disp_5_18_y == 0;

    % Equations that define two-force member relationships
    %{
    eq7 = (((location_8(1) - location_6(1)) * F6y)/(((location_8(2) - location_6(2)) * F6x))) == 1;
    eq8 = (((location_19(2) - location_18(2)) * F18z)/(((location_19(3) - location_18(3)) * F18y))) == 1;
    eq9 = (((location_19(1) - location_18(1))* F18y)/(((location_19(2) - location_18(2)) * F18x))) == 1;
    %}
    eq7 = (location_8(1) - location_6(1)) / (location_8(2) - location_6(2)) == F6x / F6y;
    eq8 = (location_19(2) - location_18(2)) / (location_19(3) - location_18(3)) == F18y / F18z;
    eq9 = (location_19(1) - location_18(1)) / (location_19(2) - location_18(2)) == F18x / F18y;    
    
    % Solve the system of equations
    solutions = solve([eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9], [F6x, F6y, F6z, F7x, F7y, F7z, F18x, F18y, F18z]);
    % Extract the solved forces
    force_6 = double([solutions.F6x, solutions.F6y, solutions.F6z]);
    force_7 = double([solutions.F7x, solutions.F7y, solutions.F7z]);
    force_18 = double([solutions.F18x, solutions.F18y, solutions.F18z]);
    
    %node_6 = modify_force_vector(node_6, force_6); 
    %node_7 = modify_force_vector(node_7, force_7);
    %node_18 = modify_force_vector(node_18, force_18);

    node_6 = node_6.modify_force(force_6); 
    node_7 = node_7.modify_force(force_7);
    node_18 = node_18.modify_force(force_18);
end