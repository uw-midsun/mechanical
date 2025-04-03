% ----------------------------------------------------------------------- %
%
% Function to solve for the wheel drop relative to rest at maximum shock 
%   extention
%
%   - Returns drop of wheel
%
% ----------------------------------------------------------------------- %

function drop = solveDrop(shockAtLoad)
    G = GlobalVars.getInstance();
    maxDropAngle = solveArmAngle(shockAtLoad);
    drop = C.length*sin(G.restAngle) - C.length*sin(maxDropAngle);
end