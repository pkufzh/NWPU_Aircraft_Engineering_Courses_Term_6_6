function myplot1(X1, Y1, X2, YMatrix1)
%CREATEFIGURE(X1, Y1, X2, YMATRIX1)
%  X1:  x ���ݵ�ʸ��
%  Y1:  y ���ݵ�ʸ��
%  X2:  x ���ݵ�ʸ��
%  YMATRIX1:  y ���ݵľ���

%  �� MATLAB �� 25-Feb-2020 13:11:42 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');

% ���� plot
plot(X1,Y1,'Parent',axes1,'Marker','*','LineStyle','none',...
    'DisplayName','ԭʼ����');

% ʹ�� plot �ľ������봴������
plot1 = plot(X2,YMatrix1,'Parent',axes1);
set(plot1(1),'LineStyle',':','DisplayName','1�����');
set(plot1(2),'DisplayName','3�����');

% ���� legend
legend(axes1,'show');

