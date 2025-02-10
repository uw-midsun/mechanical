classdef node < handle
    % Class representing a node in the system with properties for location, 
    % applied forces, and moments, and methods for accessing, modifying, 
    % and calculating related attributes.

    properties
        name;                     % Name of the node (identifier, e.g., "Node 6")
        location;                 % 3D location of the node in space [x, y, z]
        applied_force = [0 0 0];  % Applied force vector [Fx, Fy, Fz], default is zero
        applied_moment = [0 0 0]; % Applied moment vector [Mx, My, Mz], default is zero
    end

    methods
        % Constructor method to initialize a node with a name and location
        function obj = node(name, location)
            obj.name = name;            % Set the name of the node
            obj.location = location;    % Set the location of the node
        end
            
        % Accessor methods for retrieving the node's attributes

        % Retrieve the location of the node
        function output = find_location(obj)
            output = [obj.location];    % Return the location as a vector
        end

        % Retrieve the applied force on the node
        function output = find_applied_force(obj)
            output = [obj.applied_force]; % Return the applied force as a vector
        end

        % Retrieve the applied moment on the node
        function output = find_applied_moment(obj)
            output = [obj.applied_moment]; % Return the applied moment as a vector
        end

        % Mutator methods for modifying the node's attributes

        % Modify the location of the node
        function obj = modify_location(obj, new_location)
            obj.location = new_location; % Update the location with the new value
        end

        % Modify the applied force on the node
        function obj = modify_force(obj, new_force)
            obj.applied_force = new_force; % Update the applied force with the new value
        end

        % Modify the applied moment on the node
        function obj = modify_moment(obj, new_moment)
            obj.applied_moment = new_moment; % Update the applied moment with the new value
        end

        function obj = modify_location_vector(obj, new_location)
            obj.location = new_location(:)'; % Force row vector
        end

        function obj = modify_force_vector(obj, new_force)
            obj.applied_force = new_force(:)'; % Force row vector
        end

        function obj = modify_moment_vector(obj, new_moment)
            obj.applied_moment = new_moment(:)'; % Update the applied moment with the new value
        end

        % Calculate the displacement vector between the current node and another node
        function displacement_vector = displacement(obj, new_node)
            displacement_vector = abs(find_location(new_node) - find_location(obj));
            % Compute the absolute displacement vector between two nodes
        end

        % Set the reaction force at the current node equal to the force from another node
        function obj = rxn_force(obj, new_node)
            obj.applied_force = new_node.find_applied_force; % Copy the applied force from the other node
        end
    end
end

