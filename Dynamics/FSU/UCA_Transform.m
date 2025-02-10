function Transformed_node = UCA_Transform(input_node)
    % Define the transform matrix
    Transform = [1 0 0; 0 0 0; 0 0 1];

    % Transform the location of the node onto the xz-plane, zeroing the y-direction
    transformed_location = (Transform * input_node.location')'; % Force row vector
    input_node = input_node.modify_location_vector(transformed_location);

    % Transform the applied force of the node onto the xz-plane, zeroing the y-forces
    transformed_force = (Transform * input_node.applied_force')'; % Force row vector
    input_node = input_node.modify_force_vector(transformed_force);

    % Return the transformed node
    Transformed_node = input_node;
end

%{
function Transformed_node = UCA_Transform(input_node)
    %Define the transform matrix
    Transform = [1 0 0; 0 0 0; 0 0 1];

    %Transform the location of node onto the xz-plane, zeroing the y-direction
    Transformed_node.location = input_node.modify_location(Transform * input_node.location');

    %Transform the applied force of node onto the xz-plane, zeroing the y-forces
    Transformed_node.applied_force = input_node.modify_force(Transform * input_node.applied_force');
end
%}