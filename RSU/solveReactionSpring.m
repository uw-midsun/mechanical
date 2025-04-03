% ----------------------------------------------------------------------- %
%
% Function to calculate total spring force & reaction forces due to spring 
%   in yz components
%   
% - Returns force vector
%
% ----------------------------------------------------------------------- %

function RS = solveReactionSpring(geometryAtLoad)
    G = GlobalVars.getInstance();
    FS = C.spring_constant * (G.shockNoLoad - geometryAtLoad(1));
    RS = -FS*[0 sin(geometryAtLoad(3)) cos(geometryAtLoad(3))];
end