% Define vehicle mass (kg)
vehicle_mass = 300;
normal_force = vehicle_mass * 9.8 * 0.25;

%Wheelbase and CG
wheelbase = 2.6; %m
cg = 0.6; %front 0, back 1

%Acceleration
Motor_torque = 150; %N/m
Motor_radius = 0.3; %m
acceleration = ((Motor_torque/vehicle_mass)*Motor_radius)/9.8;
 
%Geometry Parameters
Hub_spacing = 0.007; %distance from center of wheel to hub bearings
Hub_x = 0.425; %X value of hub
Hub_xC =  0.42050;

%Steering 
Steering_arm = [-0.01988, -0.00926, 0.13827];
Tie_rod = [-0.1625, -0.00311, -0.01127];

nodesRH = [
    node('Node 1', [0.41063, -0.12888, 0]); % Contact patch
    node('Node 2', [Hub_x, 0.15027, -0.00705]); % Hub
    node('Node 3', [Hub_x + Hub_spacing, 0.15027, -0.00705]); % Outer Hub
    node('Node 4', [Hub_x - Hub_spacing, 0.15027, -0.00705]); % Inner Hub
    node('Node 5', [0.37921, 0.15033, -0.00628]); % Spindle to Upright
    node('Node 6', [0.36525, 0.27437, -0.01282]); % Upright to UCA
    node('Node 7', [0.39261, 0.03124, 0]); % Upright to LCA
    node('Node 8', [0.27378, 0.300, -0.07282]); % Rear UCA
    node('Node 9', [0.27378, 0.300, 0.07718]); % Front UCA
    node('Node 10', [0.23498, 0.080, -0.128]); % Rear LCA
    node('Node 11', [0.23498, 0.080, 0.192]); % Front LCA
    node('Node 12', [0.34962, 0.04454, 0]); % Shock Clevis LCA Bottom
    node('Node 13', [0.35849, 0.07320, 0]); % Shock Clevis LCA Top
    node('Node 14', [0.31290, 0.34040, 0]); % Bottom Bellcrank
    node('Node 15', [0.22790, 0.34088, 0]); % Middle Bellcrank
    node('Node 16', [0.21360, 0.42466, 0]); % Top Bellcrank
    node('Node 17', [0.03162, 0.33088, 0]); % Shock Clevis Chassis
    node('Node 18', [0.37921 + Steering_arm(1), 0.15033 + Steering_arm(2), -0.00628+ Steering_arm(3)]); % Steering Arm approx.
    node('Node 19', [0.37921 + Steering_arm(1) + Tie_rod(1), 0.15033 + Steering_arm(2) + Tie_rod(2), -0.00628 + Steering_arm(3) + Tie_rod(3)]);
];

nodesC = [
    node('Node 1', [0.42592, -0.04531, 0]); % Contact patch
    node('Node 2', [Hub_xC, 0.23422, -0.005966]); % Hub
    node('Node 3', [Hub_xC + Hub_spacing, 0.23422, -0.005966]); % Outer Hub
    node('Node 4', [Hub_xC - Hub_spacing, 0.23422, -0.005966]); % Inner Hub
    node('Node 5', [0.37482, 0.23097, -0.00628]); % Spindle to Upright
    node('Node 6', [0.35213, 0.35372, -0.01282]); % Upright to UCA
    node('Node 7', [0.39662, 0.11313, 0]); % Upright to LCA
    node('Node 8', [0.27377, 0.300, -0.07282]); % Rear UCA
    node('Node 9', [0.27377, 0.300, 0.07718]); % Front UCA
    node('Node 10', [0.23498, 0.08000, -0.12800]); % Rear LCA
    node('Node 11', [0.23498, 0.08000, 0.19200]); % Front LCA
    node('Node 12', [0.35254, 0.10410, 0]); % Shock Clevis LCA Bottom
    node('Node 13', [0.34651, 0.13348, 0]); % Shock Clevis LCA Top
    node('Node 14', [0.30349, 0.37975, 0]); % Bottom Bellcrank
    node('Node 15', [0.22790, 0.34088, 0]); % Middle Bellcrank
    node('Node 16', [0.17648, 0.40856, 0]); % Top Bellcrank
    node('Node 17', [0.03162, 0.33088, 0]); % Shock Clevis Chassis
    node('Node 18', [0.37482 + Steering_arm(1), 0.23097 + Steering_arm(2), -0.00628 + Steering_arm(3)]); % Steering Arm approx.
    node('Node 19', [0.37482 + Steering_arm(1) + Tie_rod(1), 0.23097 + Steering_arm(2) + Tie_rod(2), -0.00628 + Steering_arm(3) + Tie_rod(3)]);
];

nodeDescriptions = {
    'Contact patch';    % 1
    'Hub';              % 2
    'Outer Hub';        % 3
    'Inner Hub';        % 4
    'Spindle to Upright'; % 5
    'Upright to UCA';    % 6
    'Upright to LCA';    % 7
    'Rear UCA';         % 8
    'Front UCA';        % 9
    'Rear LCA';         % 10
    'Front LCA';        % 11
    'Shock Clevis LCA Bottom'; % 12
    'Shock Clevis LCA Top'; % 13
    'Bottom Bellcrank';  % 14
    'Middle Bellcrank';  % 15
    'Top Bellcrank';     % 16
    'Shock Clevis Chassis'; % 17
    'Steering Arm';      % 18
    'Tie Rod'           % 19
};

% Define the loading cases

loading_cases = [
0 1 0; %normal
-1 2 -1;% R + bump + Brake
1 2 -1; 
-1 2 acceleration; 
1 2 acceleration;
0 2 0
];
%{
loading_cases = [
0 1 0; %normal
1 2 -1; %2G bump
1 1 0; %1G turn
0 1 -1; %1G brake
0 1 acceleration %Acceralation 
];
%}

shock_lengthsRH = [];
shock_lengthsC = [];
shock_forcesRH = [];
shock_forcesC = [];


loadingDescriptions = {
    'Normal'; %1
    '2G bump'; %2
    '1G turn'; %3
    '1G brake'; %4
    'Acceralation'; %5
};
% Get the size of the loading cases matrix
load_size = size(loading_cases, 1);
% Pre-allocate result table with appropriate size

result_table = table('Size', [length(nodesRH), 7], ...
    'VariableTypes', {'string', 'double', 'double', 'double', 'double', 'double', 'double'}, ...
    'VariableNames', {'NodeName', 'FX', 'FY', 'FZ', 'MX', 'MY', 'MZ'});

% Assign initial node names
for i = 1:length(nodesRH)
    result_table.NodeName(i) = string(['Nodea ', num2str(i), ' Ride Height']);
end

for i = 1:length(nodesC)
    result_table.NodeName(i) = string(['Node ', num2str(i), ' Compressed']);
end

% Iterate through each loading case
for case_num = 1:load_size
    % Perform contact patch calculations and update the first node
    nodesRH(1) = contact_patch_solver(loading_cases(case_num, :), vehicle_mass, cg, nodesRH(1));
    if case_num == 1
        nodesRH(1).modify_force([0, 1048.29, 0]);
    end
    
    if case_num == 2
        nodesRH(1).modify_force([-1381.27, 2762.55, -1381.27]);
    end
    % Solve for the wheel and update nodes 1 and 2
    nodesRH(2) = wheel_solver(nodesRH(1), nodesRH(2));

    % Solve for the hub and update nodes 2, 3, and 4
    [nodesRH(3), nodesRH(4)] = hub_solver(nodesRH(2), nodesRH(3), nodesRH(4));

    % Solve for the spindle and updates nodes 1 and 5
    nodesRH(5) = spindle_solver(nodesRH(1), nodesRH(5));

    % Solve for the upright and update nodes 6, 7, 18
    [nodesRH(6), nodesRH(7), nodesRH(18)] = upright_solver(nodesRH(5), nodesRH(6), nodesRH(7), nodesRH(8), nodesRH(18), nodesRH(19));

    % Solve for the upper control arm and update nodes 6, 8, and 9
    [nodesRH(8), nodesRH(9)] = UCA_solver(nodesRH(6), nodesRH(8), nodesRH(9));

    [nodesRH(10), nodesRH(11), nodesRH(13)] = LCA_Solver(nodesRH(7), nodesRH(10), nodesRH(11), nodesRH(13), nodesRH(14));
    
    nodesRH(14) = pushrod_solver(nodesRH(13), nodesRH(14));

    [nodesRH(15), nodesRH(16), shock_forceRH, shock_lengthRH] = bellcrank_solver(nodesRH(14), nodesRH(15), nodesRH(16), nodesRH(17));

    nodesRH(17) = shock_solver(nodesRH(16), nodesRH(17));

    for i = 1:length(nodesRH)
        result_table.FX(i) = nodesRH(i).applied_force(1);  % X component of the force
        result_table.FY(i) = nodesRH(i).applied_force(2);  % Y component of the force
        result_table.FZ(i) = nodesRH(i).applied_force(3);  % Z component of the force
        result_table.MX(i) = nodesRH(i).applied_moment(1); % X component of the moment
        result_table.MY(i) = nodesRH(i).applied_moment(2); % Y component of the moment
        result_table.MZ(i) = nodesRH(i).applied_moment(3); % Z component of the moment
        sheetname = strcat("Ride Height_" + case_num + ".xlsx");
        writetable(result_table, sheetname, 'Sheet', 1, 'Range', 'A1');
    end


    % Perform contact patch calculations and update the first node
    nodesC(1) = contact_patch_solver(loading_cases(case_num, :), vehicle_mass, cg, nodesC(1));
    if case_num == 1
        nodesC(1).modify_force([0, 1048.29, 0]);
    end
    
    if case_num == 2
        nodesC(1).modify_force([-1381.27, 2762.55, -1381.27]);
    end

    % Solve for the wheel and update nodes 1 and 2
    nodesC(2) = wheel_solver(nodesC(1), nodesC(2));

    % Solve for the hub and update nodes 2, 3, and 4
    [nodesC(3), nodesC(4)] = hub_solver(nodesC(2), nodesC(3), nodesC(4));

    % Solve for the spindle and updates nodes 1 and 5
    nodesC(5) = spindle_solver(nodesC(1), nodesC(5));

    % Solve for the upright and update nodes 5, 6, and 7
    [nodesC(6), nodesC(7), nodesC(18)] = upright_solver(nodesC(5), nodesC(6), nodesC(7), nodesC(8), nodesC(18), nodesC(19));

    % Solve for the upper control arm and update nodes 6, 8, and 9
    [nodesC(8), nodesC(9)] = UCA_solver(nodesC(6), nodesC(8), nodesC(9));

    [nodesC(10), nodesC(11), nodesC(13)] = LCA_Solver(nodesC(7), nodesC(10), nodesC(11), nodesC(13), nodesC(14));

    nodesC(14) = pushrod_solver(nodesC(13), nodesC(14));

    [nodesC(15), nodesC(16), shock_forceC, shock_lengthC] = bellcrank_solver(nodesC(14), nodesC(15), nodesC(16), nodesC(17));

    nodesC(17) = shock_solver(nodesC(16), nodesC(17));

    for i = 1:length(nodesC)
        result_table.FX(i) = nodesC(i).applied_force(1);  % X component of the force
        result_table.FY(i) = nodesC(i).applied_force(2);  % Y component of the force
        result_table.FZ(i) = nodesC(i).applied_force(3);  % Z component of the force
        result_table.MX(i) = nodesC(i).applied_moment(1); % X component of the moment
        result_table.MY(i) = nodesC(i).applied_moment(2); % Y component of the moment
        result_table.MZ(i) = nodesC(i).applied_moment(3); % Z component of the moment
        sheetname = strcat("Compressed_" + case_num + ".xlsx");
        writetable(result_table, sheetname, 'Sheet', 1, 'Range', 'A1');
    end

    for i = 1:length(nodesRH)
        nodesRH(i).applied_force = [0, 0, 0];
        nodesRH(i).applied_moment = [0, 0, 0];
        nodesC(i).applied_force = [0, 0, 0];
        nodesC(i).applied_moment = [0, 0, 0];
    end
    shock_lengthsRH(case_num) = shock_lengthRH;
    shock_lengthsC(case_num) = shock_lengthC;
    shock_forcesRH(case_num) = shock_forceRH;
    shock_forcesC(case_num) = shock_forceC;

end

% Save the result table to an Excel file
disp('Loading case calculations complete. Results saved to "Loading_Cases_MS16.xlsx".');

%Shock math 

disp(['Shock Force Ride Height Rest (N): ', num2str(shock_forcesRH(1))]);
disp(['Shock Force Worst Case Rest (N): ', num2str(shock_forcesRH(2))]);
disp(['Shock Force Ride Height Compressed (N): ', num2str(shock_forcesC(1))]);
disp(['Shock Force Worst Case Compressed (N): ', num2str(shock_forcesC(2))]);

k = ((shock_forcesC(2) - shock_forcesRH(1))/(shock_lengthsRH(1)  - shock_lengthsC(2))/1000);
disp(['Shock Constant (N/mm): ', num2str(k)]);