% APPM3021 Lab 3, Exercise 4

clc; clear all;

syms f x;
f = @(x) 2*x^3 - -x^2 - exp(x) - 2.2;
x_0 = 1;
I_0 = [1, 2];
tol = 0.00001;

% measurements and timing
tic;
root_bisec = bisectionSearch(f, tol, I_0, true);
t_bisec = toc; tic;
root_falsi = regulaFalsiSearch(f, tol, I_0, true);
t_falsi = toc; tic;
fprime = matlabFunction( diff(f(x)) );                      % included in timing 
root_newton = NewtonMethodScaler(f, fprime, x_0, tol, true);
t_newton = toc;

% iterations
iter_bisec = length(root_bisec);
iter_falsi = length(root_falsi);
iter_newton = length(root_newton);

% relative error
error_bisec(1) = I_0(2)-I_0(1);
error_falsi(1) = I_0(2)-I_0(1);
error_newton(1) = x_0;

for index=2:iter_bisec
    difference = abs(root_bisec(:,index) - root_bisec(:,index-1));
    error_bisec(index) = max(difference)/max(abs(root_bisec(:,index)));
end
for index=2:iter_falsi
    difference = abs(root_falsi(:,index) - root_falsi(:,index-1));
    error_falsi(index) = max(difference)/max(abs(root_falsi(:,index)));
end
for index=2:iter_newton
    difference = abs(root_newton(:,index) - root_newton(:,index-1));
    error_newton(index) = max(difference)/max(abs(root_newton(:,index)));
end

% time
disp(' ')
disp(['Bisection root found in ', num2str(t_bisec*1000), ' milli-seconds'])
disp(['Regula Falsi root found in ', num2str(t_falsi*1000), ' milli-seconds'])
disp(['Newton fixed-point root found in ', num2str(t_newton*1000), ' milli-seconds (including calculation of f'')'])


%% Main plot
% Display setting and output setup
scr = get(groot,'ScreenSize');                              % screen resolution
phi = (1 + sqrt(5))/2;
ratio = phi/3;
offset = [ scr(3)/4 scr(4)/4]; 
fig1 =  figure('Position',...                               % draw figure
        [offset(1) offset(2) scr(3)*ratio scr(4)*ratio*0.9]);
set(fig1,'numbertitle','off',...                            % Give figure useful title
    'name','Comparison of iterative root-finding methods',...
    'Color','white');
set(fig1, 'MenuBar', 'none');                               % Make figure clean
set(fig1, 'ToolBar', 'none');                             
fontName='Helvetica';
set(0,'defaultAxesFontName', fontName);                     % Make fonts pretty
set(0,'defaultTextFontName', fontName);
set(groot,'FixedWidthFontName', 'ElroNet Monospace')      
ax1 = gca;

% Plot
p1 = plot(error_bisec,...
        'Color',[0.18 0.18 0.9 .6],...                 
        'LineStyle','-',...
        'LineWidth',1);
hold on
p2 = plot(error_falsi,...
        'Color',[0.18 0.9 0.18 .6],...                 
        'LineStyle','-',...
        'LineWidth',1);
hold on
p3 = plot(error_newton,...
        'Color',[0.9 0.18 0.18 .6],...                 
        'LineStyle','-',...
        'LineWidth',1);
hold on
p4 = refline(0,tol);
set(p4,'Color',[0.18 0.18 0.18 .6],...                 
        'LineStyle',':',...
        'LineWidth',1);
hold on

% Title
title('Error vs. Iterations',...
    'FontSize',14,...
    'FontName',fontName);

% Annotations
    info_pos =   [0.71 0.18 0.5 0.2];
    str_info = {'Iterations to find root',...
            [' Bisection:           ', num2str(iter_bisec)],...
            [' Regula Falsi:      ', num2str(iter_falsi)],...
            [' Newton:              ', num2str(iter_newton)]};
    info = annotation('textbox',info_pos,...
        'String', str_info,...
        'FitBoxToText','on',...
        'LineStyle','-',...
        'FontName',fontName,...
        'FontSize',15);

% Axes and labels
ylabel(ax1,'Relative Error',...
    'FontName',fontName,...
    'FontSize',14);%,...
xlabel(ax1,'Number of Iterations',...
    'FontName',fontName,...
    'FontSize',14);
max_x = max(iter_bisec(1,1),iter_falsi(1,1));
xlim(ax1,[1 max_x]);
box(ax1,'off');
set(ax1,'FontSize',14,...
    'XTick',[0:1:max_x],...
    'XTickLabelRotation',45,...
    'YMinorTick','on');hold on

% Legend
legend1 = legend({'Bisection','Regula Falsi',...
     'Newton Fixed Point', 'Error Threshold'},...
     'Position',[0.7    0.7    0.2    0.09],...
     'Box','off',...
     'FontName',fontName,...
     'FontSize',13);

% Mini-plot of function
pos = ax1.Position;
ax2 = axes('Position', [pos(3)-pos(1)/2 pos(4)-pos(4)/2.2 pos(3)/5 pos(4)/5]);
ezplot(ax2, f, [-5,8]);
% r1 = refline(0,0);
% r1.Color = 'black';
set(ax2,'FontSize',9,...
    'XAxisLocation','origin',...
    'YAxisLocation','origin',...
    'Box','on',...
    'Layer','top',...
    'Color','none');
ylabel(ax2,'');
xlabel(ax2,'');
hold on

% Adjust figure
pos = get(ax1, 'Position');
pos(1) = 0.05;
pos(3) = pos(3)*1.2;
set(ax1, 'Position', pos)
hold off