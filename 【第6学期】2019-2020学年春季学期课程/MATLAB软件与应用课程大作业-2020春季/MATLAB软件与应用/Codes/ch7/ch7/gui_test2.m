%��һ��ͼ�δ��ڻ��������ߺ��������ߣ�������һ����֮����ϵ��
%�����Ĳ˵�%���ڿ�����������ɫ���߿����ͼ���ǵ���

% ������y1������������h=uicontextmenu; 
t=-1:0.1:1;subplot(2,1,1);y1=t.^2;h_line1=plot(t,y1); 
% ���������Ĳ˵�
h=uicontextmenu;
uimenu(h,'label','red','callback','set(h_line1,''color'',''r'')');
uimenu(h,'label','green','callback','set(h_line1,''color'',''g'')');
uimenu(h,'label','yellow','callback','set(h_line1,''color'',''y'')');
uimenu(h,'label','linewidth1.5','callback','set(h_line1,''linewidth'',1.5)');
uimenu(h,'label','linestyle*','callback','set(h_line1,''linestyle'',''*'')');
uimenu(h,'label','linestyle:','callback','set(h_line1,''linestyle'','':'')');
uimenu(h,'label','marker','callback','set(h_line1,''marker'',''s'')');
set(h_line1,'uicontextmenu',h)  % ʹ�����Ĳ˵�����������h_line1����ϵ 
title('�����ߺ���������','fontweight','bold','fontsize',14)
set(gca,'xtick',[-1:0.5:1])      % ����������ı�ȷ�Χ
set(gca,'xticklabel',{'-1','0.5','0','0.5','1'})      % ����������ı��ֵ



%������y2, ����������
subplot(2,1,2);t=0:0.1:2*pi;y2=cos(t);h_line2=plot(t,y2);
h=uicontextmenu;
uimenu(h,'label','red','callback','set(h_line2,''color'',''r'')');
uimenu(h,'label','crimson','callback','set(h_line2,''color'',''m'')');
uimenu(h,'label','black','callback','set(h_line2,''color'',''k'')');
uimenu(h,'label','linewidth1.5','callback','set(h_line2,''linewidth'',1.5)');
uimenu(h,'label','linestyle*','callback','set(h_line2,''linestyle'',''*'')');
uimenu(h,'label','linestyle:','callback','set(h_line2,''linestyle'','':'')');
uimenu(h,'label','marker','callback','set(h_line2,''marker'',''s'')');
set(h_line2,'uicontextmenu',h)  
set(gca,'xtick',[0:pi/2:2*pi])
set(gca,'xticklabel',{'0','pi/2','pi','3pi/2','2pi'})
xlabel('time 0-2\pi','fontsize',10)


% �����ر�ͼ���û����水ť��close��

hbutton=uicontrol('position',[80 30 60 30],'string','close', 'fontsize',8,'fontweight','bold','callback','close'); 
