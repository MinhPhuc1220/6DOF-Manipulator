function plotdata(num, XData1, YData1, Name1, Title1, len, Scale1)
%CREATEFIGURE1(XData1, YData1, Parent1)
%  NUM: 0 ('default') is close all figure before we opened, otherwise that
%  will hold figure.
%  XDATA1:  line xdata
%  YDATA1:  line ydata
%  NAME1:  text name data
%  Title1: text title
%  LEN: Length of stream data.
%  SCALE1: set lower and upper bound for y axes

%  Auto-generated by MATLAB on 08-May-2022 23:20:51

% Create figure
switch num
    case 0
        close all;
    otherwise
end
figure('Tag','ScopePrintToFigure','Color',[1 1 1],...
    'OuterPosition',[485 233 947 691]);

% uicontainer currently does not support code generation, enter 'doc uicontainer' for correct input syntax
% In order to generate code for uicontainer, you may use GUIDE. Enter 'doc guide' for more information
% uicontainer(...);

% uicontainer currently does not support code generation, enter 'doc uicontainer' for correct input syntax
% In order to generate code for uicontainer, you may use GUIDE. Enter 'doc guide' for more information
% uicontainer(...);

% uipanel currently does not support code generation, enter 'doc uipanel' for correct input syntax
% In order to generate code for uipanel, you may use GUIDE. Enter 'doc guide' for more information
% uipanel(...);

% Create axes
axes1 = axes('Tag','DisplayAxes1_RealMag',...
    'ColorOrder',[0 0 0;1 0 0;0 0 1;0 0 0;1 0 0;0 0 1]);
hold(axes1,'on');

% Create hgtransform
hgtransform('HitTest','off','Matrix',[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1]);
    
% Create line
if len<3
    line(XData1,YData1,'Tag','DisplayLine1',...
        'LineWidth',2);
else
    line(XData1(:,1:3),YData1(:,1:3),'Tag','DisplayLine1',...
        'LineWidth',2);
    line(XData1(:,4:len),YData1(:,4:len),'Tag','DisplayLine1',...
        'LineWidth',2,'LineStyle','--');
end
% Create ylabel
ylabel('Amplitude');

% Create xlabel
xlabel('Time');

% Create title
title(Title1,'fontsize',26);

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 10]);
% Uncomment the following line to preserve the Y-limits of the axes
switch nargin
    case 7
        ylim(axes1,Scale1);
    otherwise
        % ylim(axes1,[-12.5 12.5]);
end
% ylim(axes1,[-12.5 12.5]);
% Uncomment the following line to preserve the Z-limits of the axes
% zlim(axes1,[-1 1]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'ClippingStyle','rectangle','FontSize',14,'GridAlpha',0.4,...
    'GridColor',[0 0 0],'TickLabelInterpreter','none','XGrid','on','YGrid','on');
% Create legend
legend(axes1,Name1,'Units','pixels',...
    'Interpreter','none',...
    'FontSize',12,...
    'EdgeColor',[0 0 0]);

