% ----------------------------------------------------------------------- %
%
% Function to plot reaction force arrows
%
%   - Scales force arrows on plot by C.fscale
%
% ----------------------------------------------------------------------- %

function plotForce(N, FA, RS, R1, R2)
plot_arrow(N(8, :), FA)
plot_arrow(N(7, :), RS)
plot_arrow(N(1, :), R1)
plot_arrow(N(3, :), R2)
end

function plot_arrow(point, force)
    quiver3(point(1), point(3), point(2), force(1)/C.fscale, force(3)/C.fscale, force(2)/C.fscale, 'r', 'LineWidth', 3);
end