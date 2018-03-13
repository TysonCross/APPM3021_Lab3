% APPM3021 Lab 3, Question 1 (b)

clc; clear all;

syms x y;
f = @(x) tan(x) - x;
x_0 = [1.5, pi/2, 4.6, 3*pi/2, 4.71, 5*pi/2, 7.6, 7.85]; % guesses based on visual intercepts
tol = 0.0001;
root_newton = [];

%% calculations
fprime = matlabFunction( diff(f(x)) );
for i=1:length(x_0)
    root = NewtonMethodScaler(f, fprime, x_0(i), tol);
    if isempty(root) || isnan(root) || isinf(root)
    elseif (root > 10) || (root < 0)
    else
        root_newton(i) = root;
    end
end
root_newton= sort(unique(root_newton));

% iterations
iter_newton = length(root_newton);

%% Display setting and output setup
scr = get(groot,'ScreenSize');                              % screen resolution
phi = (1 + sqrt(5))/2;
ratio = phi/3;
offset = [ scr(3)/4 scr(4)/4]; 
fig1 =  figure('Position',...                               % draw figure
        [offset(1) offset(2) scr(3)*ratio scr(4)*ratio]);
set(fig1,'numbertitle','off',...                            % Give figure useful title
        'name','Intersections of y=tan(x) and y=x',...
        'Color','white');
fontName='Helvetica';
set(0,'defaultAxesFontName', fontName);                     % Make fonts pretty
set(0,'defaultTextFontName', fontName);
set(groot,'FixedWidthFontName', 'ElroNet Monospace')      

% Draw plot to examine the function tan(x)-x=0
values = [0:0.01:10];
a=tan(values);
p2 = plot(values,a,...
        'Color',[0.18 0.9 0.18 .6],...                 
        'LineStyle','-',...
        'LineWidth',1);
hold on

r1 = refline(1,0);
set(r1,'Color',[0.18 0.18 0.9 .6],...                 
        'LineStyle','-',...
        'LineWidth',1);
hold on

for i=1:length(root_newton)
    root_dot(i) = plot(root_newton(:,i),root_newton(:,i),'rx');
hold on
end

% Axes and labels
ax1 = gca;;
ax1.XTick = [0:pi/4:3*pi];
ax1.XTickLabel = {'0','$\frac{\pi}{4}$','$\frac{\pi}{2}$','$\frac{3\pi}{4}$','$\pi$',...
                  '$1\frac{\pi}{4}$','$1\frac{\pi}{2}$','$1\frac{3\pi}{4}$','$2\pi$',...
                  '$2\frac{\pi}{4}$','$2\frac{\pi}{2}$','$2\frac{3\pi}{4}$','$3\pi$',...
                  '$3\frac{\pi}{4}$','$3\frac{\pi}{2}$','$3\frac{3\pi}{4}$','$4\pi$'};
box(ax1,'off');
set(ax1,'FontSize',14,...
    'YMinorTick','off',...
    'XMinorTick','off',...
    'TickLabelInterpreter','latex');
hold on
ylabel('y \rightarrow',...
    'FontName',fontName,...
    'FontSize',14);%,...
xlabel('x \rightarrow',...
    'FontName',fontName,...
    'FontSize',14);
% Legend
legend1 = legend({'y = tan(x)','y = x', 'intercepts'},...
     'Location','best',...
     'Position',[0.7    0.3    0.2    0.09],...
     'Box','off');
hold on

% Numeric values on extra X axis
ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k',...
            'Box','off');
offsetx = 0.5;
ax1.XLim = [0 10+offsetx];
ax1.YLim = [0 10+offsetx];
ax2.XLim=ax1.XLim;
ax2.YLim=ax1.YLim;
set(ax2,'YTick','')

% Adjust figure
pos = get(ax1, 'Position');
pos(1) = 0.05;
pos(3) = pos(3)*1.1;
set(ax1, 'Position', pos)
set(ax2, 'Position', pos)
hold off