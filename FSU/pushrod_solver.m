function node_14 = pushrod_solver (node_13, node_14)
    force_13 = node_13.find_applied_force();
    node_14.modify_force([-force_13(1), -force_13(2), -force_13(3)]);
end
