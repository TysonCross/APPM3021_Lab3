% APPM3021 Lab 3, Exercise 5

clc
clear all

% system of equations
syms f g x y;
f(x,y) = x^3 + y^3 -3 ;
g(x,y) = x^2 - y^2 -2;
F = [f;g];
J = jacobian(F, [x, y]);

X_0 = [ 1 1 ; -1 -1 ];
tol = 0.000001;

for i=1:length(X_0)
    root = NewtonMethodSystem(F, J, X_0(i,:), tol);
    if isempty(root(:)) || isnan(sum(root)) || isinf(sum(root(:)))
    else
        root_newton(:,i) = [root(1),root(2)]';
    end
end

%% Display setting and output setup
scr = get(groot,'ScreenSize');                              % screen resolution
fig1 =  figure('Position',...                               % draw figure
    [1 scr(4)*3/5 scr(3)*3.5/5 scr(4)*3/5]);
set(fig1,'numbertitle','off',...                            % Give figure useful title
    'Color','white');
fontName='Helvetica';
set(0,'defaultAxesFontName', fontName);                     % Make fonts pretty
set(0,'defaultTextFontName', fontName);
set(groot,'FixedWidthFontName', 'ElroNet Monospace')      


% Define the input grid
[xx, yy] = meshgrid(linspace(-1, 1));
% Calculate the two surfaces
z1 = yy.^2 + 2*xx;
z2 = 2*yy.^3 - xx.^2;
% Visualize the two surfaces
surface(xx, yy, z1, 'FaceColor', [0.5 1.0 0.5], 'EdgeColor', 'none', 'FaceLighting','gouraud');
surface(xx, yy, z2, 'FaceColor', [1.0 0.5 0.0], 'EdgeColor', 'none','FaceLighting','gouraud');
view(2); %camlight; axis vis3d
% Take the difference between the two surface heights and find the contour
% where that surface is zero.
zdiff = z1 - z2;
C = contours(xx, yy, zdiff, [0 0]);
% Extract the x- and y-locations from the contour matrix C.
xL = C(1, 2:end);
yL = C(2, 2:end);
% Interpolate on the first surface to find z-locations for the intersection
% line.
zL = interp2(xx, yy, z1, xL, yL);
% Visualize the line.
line(xL, yL, zL, 'Color', 'k', 'LineWidth', 3);
hold on
s = scatter([root_newton(1,1) root_newton(2,1)],[root_newton(1,2) root_newton(2,2)]);
m = s.Marker;
s.Marker = 'o';
s.MarkerEdgeColor = [0.9 0.18 0.18];

% root_dot(1) = plot(f(root_newton(1,1),root_newton(2,1)),'rx');
% hold on
% root_dot(2) = plot(g(root_newton(1,2),root_newton(2,2)),'rx');
% hold on

% values = [-100:1:100];
% 
% a=f(values,values);
% b=g(values,values);
% p1 = plot(values,a,...
%         'Color',[0.18 0.9 0.18 .6],...                 
%         'LineStyle','-',...
%         'LineWidth',1);
% hold on
% 
% p2 = plot(values,b,...
%         'Color',[0.18 0.9 0.18 .6],...                 
%         'LineStyle','-',...
%         'LineWidth',1);
% hold on
% 
% root_dot(1) = plot(f(root_newton(1,1),root_newton(2,1)),'rx');
% hold on
% root_dot(2) = plot(g(root_newton(1,2),root_newton(2,2)),'rx');
% hold on
% 
% 
% % Axes and labels
% ax1 = gca;;
% box(ax1,'off');
% set(ax1,'FontSize',14,...
%     'YMinorTick','off',...
%     'XMinorTick','off',...
%     'TickLabelInterpreter','latex');
% hold on
% ylabel('y \rightarrow',...
%     'FontName',fontName,...
%     'FontSize',14);%,...
% xlabel('x \rightarrow',...
%     'FontName',fontName,...
%     'FontSize',14);
% % Legend
% legend1 = legend({'y = tan(x)','y = x', 'intercepts'},...
%      'Location','best',...
%      'Position',[0.7    0.3    0.2    0.09],...
%      'Box','off');
% hold on
