% ----------------------------------------------------------------------- %
%
% Script to calculate geometry characteristics & reaction forces
%
%   - Positive X axis points to left side of car from driver POV
%   - Positive Y axis points to up
%   - Positive Z axis points to front of car
%   - Moments are counter clockwise about positive axis when facing
%       negative axis
%
%   - Everything in SI units, angles in radians unless specified otherwise
%
% ----------------------------------------------------------------------- %

clear; clc; close all;
G = GlobalVars.getInstance();

% ----------------------- Geometry Characteristics ---------------------- %

solveFixedGeometry()
disp(['Theta rest (deg): ', num2str(rad2deg(G.restAngle))]);

drop = solveDrop(C.shock_min_comp);
disp(['Drop distance: ', num2str(drop)]);

G.shockNoLoad = solveShockNoLoad();

preload = solvePreload;
disp(['Preload : ', num2str(preload)]);

% ------------------ Reaction Forces & Node Locations ------------------- %
loadCases = readmatrix('MSXV CG and Load Transfer Calc.xlsx', 'Sheet', 'MS16 Calcs', 'Range', 'Q32:S36')/2;


for i = 1:5
figure(i);
FA = loadCases(i,:);
MA = translateForce(FA);

geometryAtLoad = solveGeometryAtLoad(FA, MA);
disp(['Trailing arm angle at applied load (deg): ', num2str(rad2deg(geometryAtLoad(2)))]);

N = solveNodePos(geometryAtLoad(2));

RS = solveReactionSpring(geometryAtLoad);

reactionForces = round(solveReactionForces(N, FA, MA, RS),10);

% ------------------------ Simulation Parameters -------------------------%
translatedLocalXYZ= translateLocalpartCoords([reactionForces; RS], geometryAtLoad(2));
angledOutputForces = translateAngledOutputForces(translatedLocalXYZ);

writematrix(translatedLocalXYZ, 'reactionCases.xlsx', 'Sheet', 1, 'Range', ['B' num2str(i+1)]);
writematrix(angledOutputForces, 'reactionCases.xlsx', 'Sheet', 2, 'Range', ['B' num2str(i+1)]);

% ------------------- Plot & Static Equilibrium Check ------------------- %
plotGraph(N)
plotForce(N, FA, RS, reactionForces(1,:), reactionForces(2,:))

sumofforces = round(FA + RS + reactionForces(1,:) + reactionForces(2,:), 2);
sumofMoments = round(cross(N(8,:), FA) + cross(N(7,:), RS) + cross(N(3,:), reactionForces(2,:)) + MA, 2);

largestForce = double(max([norm(reactionForces(1,:)), norm(reactionForces(4,:)), norm(RS)]));
disp(['Max force : ', num2str(largestForce)]);
end