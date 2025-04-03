% ----------------------------------------------------------------------- %
%
% Function to translate force applied to system at contact patch to point on 
%   wheel axis
%
%   - Solves for induced moments
%   - Returns moment vector
%   - Moments act about node 8
%   - Brake caliper takes x moment
%
% ----------------------------------------------------------------------- %

function MA = translateForce(FA)
   MA = [FA(3)*C.contacty-FA(2)*C.contactz, FA(1)*C.contactz-FA(3)*C.contactx, FA(2)*C.contactx-FA(1)*C.contacty];
   if MA(1) < 0
       MA(1) = 0;
   end
   %MA(1) = 0; % Brake caliper takes x moment
end