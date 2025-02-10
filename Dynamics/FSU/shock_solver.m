function node_17 = shock_solver(node_16, node_17)
    force_16 = node_16.find_applied_force();
    node_17.modify_force([-force_16(1), -force_16(2), -force_16(3)]);
end
