% ----------------------------------------------------------------------- %
%
% Class to define global variables of trailing arm suspension
%
%   - Global variables must be preceeded by G. when called
%   - Global variable values can be changed by this program
%   - G = GlobalVars.getInstance(); must be at start of every script and
%   function that uses global variables
%
% ----------------------------------------------------------------------- %

classdef GlobalVars < handle  % Inherit from handle class
    properties
        restAngle
        theta2
        theta3
        p2y
        p2z
        shockNoLoad
        origin_to_p2
    end
    
    methods (Access = private)
        function obj = GlobalVars()
            obj.restAngle = 0;
            obj.theta2 = 0;
            obj.theta3 = 0;
            obj.p2y = 0;
            obj.p2z = 0;
            obj.shockNoLoad = 0;
            obj.origin_to_p2 = 0;

        end
    end
    
    methods (Static)
        function obj = getInstance()
            persistent uniqueInstance;
            if isempty(uniqueInstance) || ~isvalid(uniqueInstance)  % Now isvalid works
                uniqueInstance = GlobalVars();
            end
            obj = uniqueInstance;
        end
    end
end
