% APPM3021 Lab 3, Exercise 4

clc
clear global variable

syms x;
f = @(x)  2*x^3 - 7*x + 2;
x_0 = 2;
I_0 = [1, 2];
tol = 0.00001;

% measurements
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
disp(['Newton fixed-point root found in ', num2str(t_newton*1000), ' milli-seconds'])


%% Display setting and output setup
scr = get(groot,'ScreenSize');                              % screen resolution
fig1 =  figure('Position',...                               % draw figure
    [1 scr(4)*3/5 scr(3)*3.5/5 scr(4)*3/5]);
set(fig1,'numbertitle','off',...                            % Give figure useful title
    'name','Comparison of iterative root-finding methods',...
    'Color','white');
set(fig1, 'MenuBar', 'none');                               % Make figure clean
set(fig1, 'ToolBar', 'none');                             
% fontName='CMU Serif';
fontName='Helvetica';
set(0,'defaultAxesFontName', fontName);                     % Make fonts pretty
set(0,'defaultTextFontName', fontName);
set(groot,'FixedWidthFontName', 'ElroNet Monospace')      

%% Plot
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
title('Relative Error vs. Iterations',...
    'FontSize',14,...
    'FontName',fontName);

% Axes and labels
ax1 = gca;
% hold(ax1,'on');
ylabel('Relative Error',...
    'FontName',fontName,...
    'FontSize',14);%,...
xlabel('Number of Iterations',...
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
     'Box','off');
hold off
% epswrite('images/relative_error.eps');