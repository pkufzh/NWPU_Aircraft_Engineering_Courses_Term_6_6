function myplot1(X1, Y1, X2, YMatrix1)
%CREATEFIGURE(X1, Y1, X2, YMATRIX1)
%  X1:  x 数据的矢量
%  Y1:  y 数据的矢量
%  X2:  x 数据的矢量
%  YMATRIX1:  y 数据的矩阵

%  由 MATLAB 于 25-Feb-2020 13:11:42 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');

% 创建 plot
plot(X1,Y1,'Parent',axes1,'Marker','*','LineStyle','none',...
    'DisplayName','原始数据');

% 使用 plot 的矩阵输入创建多行
plot1 = plot(X2,YMatrix1,'Parent',axes1);
set(plot1(1),'LineStyle',':','DisplayName','1次拟合');
set(plot1(2),'DisplayName','3次拟合');

% 创建 legend
legend(axes1,'show');

