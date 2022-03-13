% ƽβ����ͼ
% ����������ƽβ����ȵĹ�ϵ��ȷ��ƽβ�ߴ�������λ��
% ���в����ĵ�λ�����ù��ʱ�׼��λ��

%% ����ԭʼ����
m = 21800;        % �ɻ�����
g = 9.81;         % �������ٶ�
Iy  = 450000;     % �������Ծ�
lh  = 12.48;      % ƽβ����
cbar = 2.811;     % ����ƽ�������ҳ�
cebar = 1.93*0.33;% ������ƽ�������ҳ�
x_ac = 0.25;      % ��������役�����λ��
S = 74.98;        % �������
kq = 0.9;         % �ٶ�����ϵ��
ea = 0.15;        % ƽβ��ϴ����
CLawb = 3.8;      % ���������������б��
CL0 = 0.2;        % ��ӭ������ϵ��
CLha = 3.0;       % ƽβ������б��
Se_Sh = 0.3;      % ��������ƽβ���֮��
Chd = -0.42;      % ����������Բ�����ƫ�ǵĵ���
Cha = -0.24;      % �����������ӭ�ǵĵ���
G = 0.4;          % ������
Vtr = 200;        % �������״̬�ķ����ٶ�
rho = 1.255*0.5;  % �������״̬�Ĵ����ܶ�
iw = 3/57.3;      % ����װ��

%% ����Ʒ��Ҫ��
Knmin = 0.016*lh/cbar;       % �ո˾��ȶ�ԣ��
dFe_dvmin = 0.15*9.81;       % �����ٶ��ݶ���Сֵ
dFe_dvmax = 36/0.7/63*9.81;  % -----------���ֵ
Kmmin = 0.1;                 % �ո˻���ԣ��
dFe_dnmin = 2.7*9.81;        % ���������ݶ���Сֵ
dFe_dnmax = 54.48*9.81;      % -----------���ֵ
zetamin  = 0.35;             % �����������
CAPmin = 0.085;              % ������������

%% �ո˾��ȶ���
% ��Ӧ���ĺ���
Sbar = [0:0.025:0.5];                           % ƽβ�����������Ƽ���ͼ��
CLa = CLawb + kq*(1-ea)*Sbar*CLha;              % ȫ��������б��
Xn = x_ac + kq*(1-ea)*lh/cbar * Sbar*CLha./CLa;  % �ո����Ե�
Xcg1 = Xn - Knmin;                              % �ո˾��ȶ��Զ�Ӧ������λ��
plot(Xcg1,Sbar,'b-')
axis([0 1 0 0.5])             

%% �ɸ˾��ȶ�
% ��Ӧ1������ǰ�޺�1�����ĺ���
CLha1 = CLha *(1- Cha/Chd*sqrt(Se_Sh));          % �ɸ�ʱƽβ��������б��
CLa1 = CLa - CLha1*kq*(1-ea).*Sbar;              % �ɸ�ʱ��������б��
CLhd = CLha * sqrt(Se_Sh);
Xn1 = x_ac+kq*(1-ea)*Sbar*lh/cbar * CLha1./CLa1; % �ɸ����Ե�
Xcg2min = Xn1 + dFe_dvmin*Vtr*lh*CLhd/(2*m*g*cbar*G*cebar*Chd)/Se_Sh; % �ɸ˾��ȶ��Զ�Ӧ������λ��1������
Xcg2max = Xn1 + dFe_dvmax*Vtr*lh*CLhd/(2*m*g*cbar*G*cebar*Chd)/Se_Sh; % �ɸ˾��ȶ��Զ�Ӧ������λ��2��ǰ��
plot(Xcg2min,Sbar,'b--',Xcg2max,Sbar,'b.-')
axis([0 1 0 0.5])

%% �ո˻�����
% ���ĺ���
Xm = Xn + 0.55*rho*S*lh*lh*CLha/m/cbar*Sbar;    % �ո˻�����
Xcg3 = Xm - Kmmin;                              % �ո˻����Զ�Ӧ������λ��
plot(Xcg3,Sbar,'r-')
axis([0 1 0 0.5])

%% �ɸ˻�����
% ��Ӧ1������ǰ�޺�1�����ĺ���
Xm1 = Xn1 + 0.55*rho*S*lh*lh*CLha1/m/cbar*Sbar; % �ɸ˻�����
Xcg4min = Xm1 + dFe_dnmin*lh*CLhd/(m*g*cebar*cbar*Se_Sh*G*Chd); % �ɸ˻����Զ�Ӧ������λ��1������
Xcg4max = Xm1 + dFe_dnmax*lh*CLhd/(m*g*cebar*cbar*Se_Sh*G*Chd); % �ɸ˻����Զ�Ӧ������λ��2��ǰ��
plot(Xcg4min,Sbar,'r--',Xcg4max,Sbar,'r.-')
axis([0 1 0 0.5])

%% �����������
% ���ĺ���
Ky2 = Iy/(m*cbar*cbar);     % �������Ծص��������   
muc = 2*m/(rho*S*cbar);     % ��������ܶ� 
damp = (Ky2*CLa + 1.1*CLha.*Sbar*(lh/cbar)*(lh/cbar)*(1+ea)).^2./(8*Ky2*muc*CLa*zetamin*zetamin);
Xcg5 = Xm - damp;           % �����������Ҫ���Ӧ������λ��
plot(Xcg5,Sbar,'m-')
axis([0 1 0 0.5])

%% �������ݲ���
% ���ĺ���
Xcg6 = Xm - CAPmin*Iy/(m*g*cbar);  % CAPҪ������Ӧ������λ��
plot(Xcg6,Sbar,'c-*') 
axis([0 1 0 0.5])

%% �ɻ�ʧ��Ҫ��
% ����ǰ��
Cmac = 0.15;            % ��������役�㴦�ĸ�������ϵ��
alfa = 15/57.3;         % ʧ��ӭ��
de = -19/57.3;          % �����������ƫ��
eaS=0.4;                % ʧ��ӭ�Ǹ�������ϴϵ��
CLh = CLha*(alfa*(1-eaS)+0.6*de); % �ٶ�CLhd=0.6*CLha
CLmax = 1.2;            % ����������������ϵ��
Xcg7 = x_ac - (Cmac-CLh*kq*Sbar*lh/cbar)./(CLmax+CLh*kq*Sbar);  % �ɻ�ʧ��Ҫ���Ӧ������λ��
plot(Xcg7,Sbar,'g-s') 
axis([0 1 0 0.5])

%% ���̧ǰ��
% ����ǰ��
Cmac0 = 0.15;
Xg = 12.67;         % ������ܾ��ͷλ�ã�m
Xh = 23;            % ƽβ���ͷλ����ԭʼ���ݣ����ȡ�ģ�m
T = 2*2200*9.8;     % ����������,˫��
Zcg = 2;            % ���ľ�������ܵĸ߶ȣ�m
ZT = 0.3;           % �����������ĸ߶ȣ�������������֮��Ϊ��
nh = kq*(Xh-Xg)/lh; % β��Ч������1
thetaRdot = 5/57.3; % ���̧ǰ�ֵĸ������ٶ�
VS = 63;            % ʧ���ٶ�
VR = 1.05*VS;       % ���̧ǰ���ٶ�
alfa = 3/57.3;      % ̧ǰ��ʱӭ��
CLh = CLhd*de+CLha*alfa*(1-ea);  %̧ͷʱƽβ������
nq = 1 + CLha/CLh*thetaRdot*(Xh-Xg)/VR; % β��Ч������2
CLR = CL0+(alfa+iw)*CLa;  % ̧ǰ��ʱ������ϵ��������̫��
X25 = Xg - 0.8;     % ������ͷλ��
Xc = 11;            % ƽ��������ǰԵ���ͷ����
Xcg8 = lh*CLh*nq*nh/(CLmax*0.907*cbar)*Sbar+(Xg/cbar+T*(Zcg-ZT)/(m*g*cbar))-(Cmac0+CLR*(Xg-X25)/cbar)/CLmax/0.907-Xc/cbar;
plot(Xcg8,Sbar,'k-s') 
axis([0 1 0 0.5])

%% �����븴��
% ����ǰ��
ahmin = -0.25;    % ƽβʧ��ӭ��(��ӭ��)
Xcg9 = x_ac+1/0.7*(nh*CLha*lh/cbar*(ahmin/CLmax+0.39*(1-eaS)./CLa).*Sbar-Cmac/CLmax);
plot(Xcg9,Sbar,'b-s') 
axis([0 1 0 0.5])

%% ��½��ƽ 
% ����ǰ��
Cmac0 = 0.15;
Xg = 12.67;         % ������ܾ��ͷλ��
Xh = 23;            % ��ԭʼ���ݣ����ȡ��
nh = kq*(Xh-Xg)/lh; % β��Ч������1
thetaRdot = 5/57.3;
VS = 63;            % ʧ���ٶ�,m/s
VT = 1.3*VS;
alfa = 6/57.3;
CLh = CLhd*de+CLha*alfa*(1-ea);  %�ӵ�ʱƽβ������
nq = 1 + CLha/CLh*thetaRdot*(Xh-Xg)/VR; % β��Ч������2
CLT = CL0+(alfa+iw)*CLa;  %�ӵ�ʱ������ϵ��
X25 = Xg - 0.8;  %������ͷλ��
Xc = 11;
Xcg10 = lh*CLh*nq*nh/(CLmax*0.907*cbar)*Sbar+Xg/cbar-(Cmac0+CLT*(Xg-X25)/cbar)/CLmax/0.907-Xc/cbar;
plot(Xcg10,Sbar,'c-+')
axis([0 1 0 0.5])

%% ��������ͼ
% plot(Xcg1,Sbar,'b-',  Xcg2min,Sbar,'b--',  Xcg2max,Sbar,'b.-',  Xcg3,Sbar,'r-',  Xcg4min,Sbar,'r--',  Xcg4max,Sbar,'r.-',...
%      Xcg5,Sbar,'m-',  Xcg6,Sbar,'c-',  Xcg7,Sbar,'g-s',  Xcg8,Sbar,'k-s',  Xcg9,Sbar,'b-s',  Xcg10,Sbar,'c-+')
plot(Xcg1,Sbar,'b-',  Xcg2min,Sbar,'b--',  Xcg2max,Sbar,'b.-',  Xcg3,Sbar,'r-',  Xcg4min,Sbar,'r--',  Xcg4max,Sbar,'r.-',...
     Xcg8,Sbar,'k-s', Xcg10,Sbar,'c-+')
axis([0 1 0 0.5])

%{
title('ƽβ����ͼ');
text(0.5,0.08,'�������ŵ����߱�ʾ���ĺ���')
text(0.5,0.055,'�����ŵ����߱�ʾ����ǰ��')
text(0.5,0.03,'����Χ�ļ�Ϊ����Ҫ�������')
%}