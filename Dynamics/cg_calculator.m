wheelbase = [0,1];
% Battery
x1 = 0.9; %fraction of wheelbase
m1 = 60; %kg

% Aerobody
x2 = 0.4;
m2 = 80;

% Chassis + interiors
x3 = 0.6;
m3 = 120;

% FSU + Steering
x4 = 0.05;
m4 = 20;

% RSU 
x5 = 0.9;
m5 = 20;

total_mass = m1 + m2 + m3 + m4 + m5;

CG = (x1 * m1 + x2 * m2 + x3 * m3 + x4 * m4 + x5 * m5) / total_mass;

fprintf('The center of gravity (CG) of the system is at: %.2f\n', CG);

figure;
line(wheelbase, [0, 0], 'Color', 'b', 'LineWidth', 2); 
hold on;

plot(x1, 0, 'ro', 'MarkerSize', 10 + m1*10/total_mass, 'MarkerFaceColor', 'r'); %made them proportional to mass :D
plot(x2, 0, 'ro', 'MarkerSize', 10 + m2*10/total_mass, 'MarkerFaceColor', 'r'); 
plot(x3, 0, 'ro', 'MarkerSize', 10 + m3*10/total_mass, 'MarkerFaceColor', 'r'); 
plot(x4, 0, 'ro', 'MarkerSize', 10 + m4*10/total_mass, 'MarkerFaceColor', 'r');
plot(x5, 0, 'ro', 'MarkerSize', 10 + m5*10/total_mass, 'MarkerFaceColor', 'r');


plot(CG, 0, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');

grid on;
axis equal; 
xlabel('X-axis Position');
hold off;