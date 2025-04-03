% ----------------------------------------------------------------------- %
%
% Function to plot node points, labels & connecting lines
%
%   - Relabels matlab coordinate system to car coordinate system
%   - Scales 3d plot to have equal length axis
%   
% ----------------------------------------------------------------------- %

function plotGraph(N)
% 3D plot settings
xlabel('X'); ylabel('Z'); zlabel('Y'); title('RSU Geometry with Forces')
hold on; grid on; axis equal; daspect([1 1 1]); pbaspect([1 1 1]); set(gca, 'XDir', 'reverse');

% Plotting points on plot


plotPointWithLabel(N(1, :), 'N1')
plotPointWithLabel(N(2, :), 'N2')
plotPointWithLabel(N(3, :), 'N3')
plotPointWithLabel(N(4, :), 'N4')
plotPointWithLabel(N(5, :), 'N5')
plotPointWithLabel(N(6, :), 'N6')
plotPointWithLabel(N(7, :), 'N7')
plotPointWithLabel(N(8, :), 'N8')

plot_line(N(1, :), N(2, :))
plot_line(N(2, :), N(3, :))
plot_line(N(2, :), N(4, :))
plot_line(N(4, :), N(5, :))
plot_line(N(4, :), N(6, :))
plot_line(N(6, :), N(7, :))
plot_line(N(5, :), N(8, :))
end

function plotPointWithLabel(point, label)
    % Create the 3D plot
    plot3(point(1), point(3), point(2), 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');
    
    % Add the label
     text(point(1), point(3), point(2), label, 'Color', 'blue', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end


% Plotting lines on plot
function plot_line(P1, P2)
    plot3([P1(1), P2(1)], [P1(3), P2(3)], [P1(2), P2(2)], 'black-', 'LineWidth', 2);
end