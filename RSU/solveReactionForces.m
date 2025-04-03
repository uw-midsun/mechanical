% ----------------------------------------------------------------------- %
%
% Function to solve for reaction forces at nodes 1 & 2
%
%   - Uses linsolve to solve system of linear equations
%   - 3D equilibrium is statically indeterminate
%   - Cannot solve for reaction forces in x direction must calculate sum 
%       of reaction forces in x
%   - Returns 4x3 matrix of reaction forces 1 & 2 in case 1 then case 2
%   - Case 1 is all x force on R1. Case 2 is all x force on R2
%
% ----------------------------------------------------------------------- %

function reactionForces = solveReactionForces(N, FA, MA, RS)

syms Ry1 Rz1 Ry2 Rz2

R1 = [0 Ry1 Rz1];
R2 = [0 Ry2 Rz2];

% sum of forces
RxT = FA(1) + RS(1);

forcey = FA(2) + RS(2) + R1(2) + R2(2) == 0;
forcez = FA(3) + RS(3) + R1(3) + R2(3) == 0;

% sum of moments
N8FA = cross(N(8, :), FA);
N7RS = cross(N(7, :), RS);
N3R2 = cross(N(3, :), R2);

momenty = N8FA(2) + N7RS(2) + N3R2(2) + MA(2) == 0;
momentz = N8FA(3) + N7RS(3) + N3R2(3) + MA(3) == 0;

% Using linsolve
eqns = [forcey, forcez, momenty, momentz];

[A, B] = equationsToMatrix(eqns, [Ry1 Rz1 Ry2 Rz2]);

solutions = linsolve(A, B);

reactionForces = [-RxT, solutions(1), solutions(2); 0, solutions(3), solutions(4); 0, solutions(1), solutions(2); -RxT, solutions(3), solutions(4)];

end