% ----------------------------------------------------------------------- %
%
% Function to solve for the preload of spring
%   - Returns preload of spring in newtons
%
% ----------------------------------------------------------------------- %

function preload = solvePreload()
    G = GlobalVars.getInstance();
    preload = (C.shock_min_comp - G.shockNoLoad)*C.spring_constant;
end