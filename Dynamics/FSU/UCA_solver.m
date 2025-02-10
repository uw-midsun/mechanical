function [node8, node9] = UCA_solver(Upright_UCA, UCA_front, UCA_rear) 
    % UCA_solver solves for the forces acting on the Upper Control Arm (UCA)
    % given the nodes of the UCA system.
    %
    % Inputs:
    %   Upright_UCA - Node representing the upright connection to the UCA (node6)
    %   UCA_front   - Node representing the front attachment of the UCA (node8)
    %   UCA_rear    - Node representing the rear attachment of the UCA (node9)
    %
    % Outputs:
    %   node6       - Transformed node6 with updated forces
    %   node8       - Updated node8 with calculated forces
    %   node9       - Updated node9 with calculated forces
    
    % Initialize nodes
    node6 = Upright_UCA; 
    node8 = UCA_front;   
    node9 = UCA_rear;    
        
    % Transform node6 to the xz-plane by eliminating any y-components
    % This ensures all calculations assume the UCA lies in the xz-plane.
    %node6 = UCA_Transform(node6);
    
    % Calculate the displacement vectors
    r_6_8 = displacement(node8, node6);
    r_9_8 = displacement(node8, node9);


    % Find the sum of moments about node8 to solve for the x-component of force at node9
    node9.applied_force(1) = (-r_6_8(3) * node6.applied_force(1) - r_6_8(1) * node6.applied_force(3)) / r_9_8(3);

    % Find the sum of forces in the x-direction to solve for the x-component of force at node8
    node8.applied_force(1) = -node6.applied_force(1) - node9.applied_force(1);

    % Assume the maximum force in the z-direction is carried through the UCA.
    node8.applied_force(3) = -node6.applied_force(3);
    node9.applied_force(3) = -node6.applied_force(3);
    
end

