% ----------------------------------------------------------------------- %
%
% Class to define constant parameters of trailing arm suspension
%
%   - Constants must be preceeded by C. when called
%   - Constant values cannot be changed anywhere in this program
%
% ----------------------------------------------------------------------- %

classdef C
    properties (Constant)
        % Defining known geometry and constant parameters
        length = 0.3;
        shock_max_comp = 0.295275;
        shock_min_comp = 16.875*0.0254; 
        nub_percent = 0.76;
        spring_constant = 26269.0122;
        mount_dist1 = 0.08;
        mount_dist2 = 0.1;

        wheel_offset = 0.14 + 0.1;
        
        nub = 0; 
        height = 0.075; 

        contactx = 0.06411;
        contacty = -0.2785;
        contactz = 0.00302;



        % Defining rest load conditions
        Mx_rest = 0; Fy_rest = 882.9; Fz_rest = 0;

        % Defining max compression load conditions
        %Mx_max = -157.305; 
        Fy_max = 2165.4; Fz_max = 541.35;
        Mx_max = 0;

        % Force scale factor for plot
        fscale = 10000;
    end
   
    methods (Static)
        function val = nub_dist()
            val = sqrt((C.length * C.nub_percent)^2 + C.nub^2);
        end
    end
end