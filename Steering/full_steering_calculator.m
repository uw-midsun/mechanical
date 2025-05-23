x = [240, 543, 929, 1322];
y = [83, 167, 236, 278];

p = polyfit(x, y, 3);

%vehicle parameters for steady state cornering, when w is constant
L = 2.6; %meters
W = 0.8; %meters
CoG_top = 0.6*L;
CoG_bottom = L - CoG_top;
vechicle_mass = 300; %kg
g = 9.8; %chat is this true 
wheel_radius = 0.2792; %meters
cg_vertical = 0.0827; %meters

rear_weight = CoG_top/L; %fraction of weight  
front_weight = CoG_bottom/L;
inner_force_frac = ((W/2) + cg_vertical)/W;
force_z_front = front_weight*vechicle_mass*g*inner_force_frac;
force_z_rear = rear_weight*vechicle_mass*g*inner_force_frac;
tire_coefficent_front = polyval(p,force_z_front);
tire_coefficent_rear = polyval(p,force_z_rear);

v = 6.3; %m/s
turning_radius = 5; %meters

kin_steering_angle_rad_outer = atan(L/(turning_radius+W)); 
kin_steering_angle_outer = kin_steering_angle_rad_outer*180/pi;
kin_steering_angle_rad_inner = atan(L/turning_radius); 
kin_steering_angle_inner = kin_steering_angle_rad_inner*180/pi;

rear_slip = (0.5*vechicle_mass*rear_weight*(v^2))/(tire_coefficent_rear*turning_radius);
front_slip = (0.5*vechicle_mass*front_weight*(v^2))/(tire_coefficent_front*turning_radius);
steering_angle_outer = kin_steering_angle_outer + front_slip - rear_slip;
steering_angle_inner = kin_steering_angle_inner + front_slip - rear_slip;

understeer_gradient = (front_weight/tire_coefficent_front) - (rear_weight/tire_coefficent_rear);

lateral_force = tire_coefficent_front *(v*(cos(kin_steering_angle_rad_inner) + sin(kin_steering_angle_rad_inner)));

disp(['Front slip angle (degrees): ', num2str(front_slip)]);
disp(['Rear slip angle (degrees): ', num2str(rear_slip)]);
disp(['Outer Steering angle (degrees): ', num2str(steering_angle_outer)]);
disp(['Inner Steering angle (degrees): ', num2str(steering_angle_inner)]);

disp(['Lateral Force (N): ', num2str(lateral_force)]);
