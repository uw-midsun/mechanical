% Define the node coordinates directly (replace these with your actual coordinates)
Hub_spacing = 0.007; % distance from center of wheel to hub bearings
Hub_xC = 0.425; % X value of hub
forces = [
    -1381.27,   2762.55,   -1381.27;
     1381.27,  -2762.55,    1381.27;
        0,     -311.7735,  2660.523344;
        0,    -3074.3235,  1279.253344;
    -1381.27,   2762.55,   -1381.27;
    -487.4922891,  -334.2022176,  -890.7303226;
    1921.344102,  -2427.341447,  2275.647074;
    -172.8221471,      0,   890.7303226;
     660.3144361,      0,   890.7303226;
    2565.905408,  -416.4461723,  1137.823537;
    -644.5613056, -2010.895275,  1137.823537;
        0,         0,         0;
     659.0317962, -3772.658309,     0;
    -659.0317962,  3772.658309,     0;
   -2603.752443,  -5522.299892,     0;
    3262.784239,   1749.641583,     0;
   -3262.784239,  -1749.641583,     0;
];
Steering_arm = [-0.02129228, 0.17693358, -0.13450333];
forces_swapped = forces;
forces_swapped(:, [2, 3]) = forces(:, [3, 2]); 
nodesRH = [
    [0.42592, -0.04531, 0];       % Node 1: Contact patch
    [Hub_xC, 0.23422, -0.005966]; % Node 2: Hub
    [Hub_xC + Hub_spacing, 0.23422, -0.005966]; % Node 3: Outer Hub
    [Hub_xC - Hub_spacing, 0.23422, -0.005966]; % Node 4: Inner Hub
    [0.37482, 0.23097, -0.00628]; % Node 5: Spindle to Upright
    [0.35213, 0.35372, -0.01282]; % Node 6: Upright to UCA
    [0.39662, 0.11313, 0];       % Node 7: Upright to LCA
    [0.27377, 0.300, -0.07282];  % Node 8: Rear UCA
    [0.27377, 0.300, 0.07718];   % Node 9: Front UCA
    [0.23498, 0.08000, -0.12800]; % Node 10: Rear LCA
    [0.23498, 0.08000, 0.19200];  % Node 11: Front LCA
    [0.35254, 0.10410, 0];       % Node 12: Shock Clevis LCA Bottom
    [0.34651, 0.13348, 0];       % Node 13: Shock Clevis LCA Top
    [0.30349, 0.37975, 0];       % Node 14: Bottom Bellcrank
    [0.22790, 0.34088, 0];       % Node 15: Middle Bellcrank
    [0.17648, 0.40856, 0];       % Node 16: Top Bellcrank
    [0.03162, 0.33088, 0];       % Node 17: Shock Clevis Chassis
    [0.37921 + Steering_arm(1), 0.15033 + Steering_arm(2), -0.00628+ Steering_arm(3)]
];


% Create an empty figure for visualization
figure;

% Hold the plot to keep adding the lines and arrows
hold on;

% Define the connections (pairs of nodes to connect with lines)
connections = [
    1, 2;
    2, 3;
    2, 4;
    4, 5;
    5, 6;
    5, 7;
    6, 8;
    6, 9;
    7, 10;
    7, 11;
    7, 12;
    12, 13;
    13, 14;
    14, 15;
    15, 16;
    16, 17;
    5, 18;
];

% Plot the lines connecting the nodes with switched y and z coordinates
for i = 1:size(connections, 1)
    node1 = nodesRH(connections(i, 1), :);  % Get coordinates of node 1
    node2 = nodesRH(connections(i, 2), :);  % Get coordinates of node 2
    
    % Swap y and z coordinates
    node1_swapped = [node1(1), node1(3), node1(2)];
    node2_swapped = [node2(1), node2(3), node2(2)];
    
    % Plot the line between the swapped coordinates
    plot3([node1_swapped(1), node2_swapped(1)], [node1_swapped(2), node2_swapped(2)], [node1_swapped(3), node2_swapped(3)], 'k-', 'LineWidth', 2);
end
scale = 0.00002; % Adjust scale for visualization

% Loop through each node and apply the respective force vector
for i = 1:size(forces_swapped, 1)
    node_coords = nodesRH(i, :);  % Get coordinates of the corresponding node
    force_vector = forces_swapped(i, :) * scale; % Scale forces for better visibility
    
    % Swap y and z coordinates for consistent visualization
    node_coords_swapped = [node_coords(1), node_coords(3), node_coords(2)];
    force_vector_swapped = [force_vector(1), force_vector(2), force_vector(3)];
    
    % Plot force arrows originating from the correct node
    quiver3(node_coords_swapped(1), node_coords_swapped(2), node_coords_swapped(3), ...
            force_vector_swapped(1), force_vector_swapped(2), force_vector_swapped(3), ...
            0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5);
end


% Add labels for clarity, with switched y and z
for i = 1:size(nodesRH, 1)
    node_coords = nodesRH(i, :);  % Get coordinates of each node
    
    % Swap y and z coordinates
    node_coords_swapped = [node_coords(1), node_coords(3), node_coords(2)];
    
    % Add labels at the swapped coordinates
    text(node_coords_swapped(1), node_coords_swapped(2), node_coords_swapped(3), ['Node ', num2str(i)], 'Color', 'b');
end

% Set the axes and labels for better visualization
xlabel('X');
ylabel('Z');
zlabel('Y');
title('Suspension Geometry with Forces');

% Adjust the view for better perspective (set a 3D view angle)
view(3);
axis equal;
grid on;

% Release the plot hold
hold off;
