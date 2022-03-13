%% �����Ԫ���ߴ�ȷ����У��MATLAB����
%% �����ʼ��
clear all
clf
clc

%% ģ��1������ԭʼ�ߴ硢����ҪԪ��վλ���ݡ��������Ե���
% ��������Ϣ��
Mmax=10394; % ����������
Mh=Mmax/2; % ������������һ�루���Ե���������������㣩
Mw=580; % ���������������
f=1.5; % ��ȫϵ��
g=9.8; % �������ٶ�
nmax=3; % ���������ϵ��
nmin=-1; % ��󸺹���ϵ��

% �������������Բ�����
xac=0.241242799; % ���������λ��
xcg=0.45; % �����������λ��
xz=0.5; % ������λ��

% ��������Ҫ�ߴ硿
e=1000; % ���ű���
bt=35420/e; % ��չ����
bth=bt/2; % ����չ����
cr=1873.3/e; % ���ҳ���
ct=749.3/e; % ���ҳ���
c_mean=1.42; % ƽ�������ҳ�
theta=atan((cr-ct)/bth); % ����ǰԵ���ӽ�
% skinb=0.02; % ��Ƥ���

% ���������ҪԪ��վλ���ݵ��롿
% ��������Ϣ��
% ����������λ��
L_spar_1=0.1787; % 1#����������ҳ�λ��
L_spar_2=0.3574; % 2#����������ҳ�λ��
L_spar_3=0.5361; % 3#����������ҳ�λ��
L_spar_4=0.7148; % 4#����������ҳ�λ��
L_spar=[L_spar_1,L_spar_2,L_spar_3,L_spar_4]; % ������������ҳ�λ��
n_spar=length(L_spar); % ��������
% ��������������λ����������ҳ��߶�
L_spar_h_1=0.085;
L_spar_h_2=0.095;
L_spar_h_3=0.080;
L_spar_h_4=0.055;
L_spar_h=[L_spar_h_1,L_spar_h_2,L_spar_h_3,L_spar_h_4];

% ��������Ϣ��
% ��������ǿ��λ��
L_str_rib_1=0.05333; % 1#��ǿ����չ��԰���չλ��
L_str_rib_2=0.18591; % 2#��ǿ����չ��԰���չλ��
L_str_rib=[L_str_rib_1,L_str_rib_2]; % �����ǿ����԰���չλ��
n_rib_str=length(L_str_rib); % ��ͨ���߸���

% ��������ͨ����λ��
L_rib_0=0.01;
L_rib_3=0.302208571428571;
L_rib_4=0.418507142857143;
L_rib_5=0.534805714285714;
L_rib_6=0.6511042857142861;
L_rib_7=0.767402857142857;
L_rib_8=0.883701428571429;
L_rib_9=0.95;
L_rib=[L_rib_3,L_rib_4,L_rib_5,L_rib_6,L_rib_7,L_rib_8]; % �������ͨ������԰���չλ�ã������������ߣ�

n_rib_ori=length(L_rib); % ��ͨ���߸���

% ��������������԰���չλ��
L_rib_all=[L_rib_0,L_str_rib,L_rib];
% ��ȡ������Ҫ�������ص���������
n_rib=length(L_rib_all);

% �����߶ȼ���
% �����վλ���߶�Ӧ�������ҳ�
c_rib_all=zeros(1,n_rib);
for i=1:n_rib
    c_rib_all(i)=cr-(L_rib_all(i)*bth*tan(theta));
end
% �����վλ���߶�Ӧ�������߶ȣ���λ��m��
L_spar_h_abs=L_spar_h'*c_rib_all;
% �����վλ���߶�Ӧ�ı��Ҳ��������ĸ���ǰԵ���ҽ���Ϊ�����Σ��м���������Ϊֱ�����Σ�
n_room=n_spar-1;
Room_area=zeros(n_room,n_rib); % ����������
Room_C=zeros(n_room,n_rib); % ��������ܳ�
for k=1:n_rib
%     Room_area(1,k)=0.6*(L_spar(1)*c_rib_all(k))*L_spar_h_abs(1,k); % ǰԵ���ҽ���Ϊ�����Σ�ϵ���Դ�ȡΪ0.6
%     Room_C(1,k)=(L_spar(1)*c_rib_all(k))+L_spar_h_abs(1,k)+1.2*sqrt((L_spar(1)*c_rib_all(k))^2+L_spar_h_abs(1,k)^2);
%     Area_room(n_room,k)=0.5*((1-L_spar(n_spar))*c_rib_all(k))*L_spar_h_abs(n_spar,k); % ��Ե���ҽ���Ϊ������
    for i=1:(n_spar-1)
        dl=(L_spar(i+1)-L_spar(i))*c_rib_all(k);
        ht=L_spar_h_abs(i,k)+L_spar_h_abs(i+1,k);
        dh=abs(L_spar_h_abs(i+1,k)-L_spar_h_abs(i,k));
        Room_area(i,k)=(0.5*ht)*dl;
        Room_C(i,k)=dl+ht+sqrt(dl^2+dh^2);
    end
end

% ���������ԡ�
% ̼��ά��������
E_carbon=143e9; % ��������ģ������λ��Pa��
sigma_b_carbon=2323e6; % ����ǿ�ȣ���λ��Pa��
% sigma_e_carbon; % ��ѹʧ���ٽ�Ӧ������λ��Pa��
% LY12���Ͻ��������
E_alum=68e9; % ��������ģ������λ��Pa��
sigma_b_alum=470e6; % ����ǿ�ȼ��ޣ���λ��Pa��
sigma_e_alum=280e6; % ��ѹʧ���ٽ�Ӧ������λ��Pa��
sigma_s_alum=325e6; % �������ޣ���λ��Pa��

%% ģ��2�����������λ��������Ϣ���������
% ����չ�������λ�õļ���Q�����M�ֲ����㣨���ù�ʽ������
syms x; % ���û��ַ��ű���x
A_q=zeros(1,n_rib); % ���������չ����ͨ����վλ����Fyֵ
A_m=zeros(1,n_rib); % ���������չ����ͨ����վλ���Mzֵ
A_mt=zeros(1,n_rib); % ���������չ����ͨ����վλŤ��Mtֵ

% �Ը�����վλ�����ؽ��м���
for i=1:n_rib
    L=L_rib_all(i); % ȡ����ǰ��������λ��
    z=f*nmax*2*Mh*g*sqrt(bth^2-x.^2)/(pi*bth^2);
    n=f*nmax*((0.31*2*Mh*g*sqrt(bth^2-x.^2)/(pi*(bth^2)))-(0.24*2*Mw*g*sqrt((bth^2)-x.^2)/(pi*(bth^2))));
    q=int(z,x,bth,L);
    m=int(q,x,bth,L);
    mt=int(n,x,bth,L);
    p_q=double(q);
    p_m=double(m);
    p_mt=double(mt);
    A_q(i)=p_q;
    A_m(i)=p_m;
    A_mt(i)=p_mt;
end

%% ģ��3��������Ԫ����Ҫ�ߴ�ȷ��
% ����Ƥ�ߴ�ȷ���������t_skin��
J_room=zeros(1,n_rib); % K_pla���Ա��������λ�õĸ�����Ťת����ϵ����Ϣ
Mt_room=zeros(n_room,n_rib);
qt_room=zeros(n_room,n_rib);
t_skin=zeros(n_room,n_rib);
q0_pla=zeros(n_spar,n_rib); % q0_pla���Ա�����Ťת����ĸ�����վλ�����Ŀ�������λ�ô����ܼ�����Ϣ
for k=1:n_rib
    for j=1:n_room
        J_room(k)=J_room(k)+((2*Room_area(j,k))^2)/Room_C(j,k);
    end
end
% ��������ߴ�����������Ť�أ����նȷ��䣩
for k=1:n_rib
    for j=1:n_room
        Mt_room(j,k)=A_mt(k)*((((2*Room_area(j,k))^2)/Room_C(j,k))/J_room(k));
        qt_room(j,k)=Mt_room(j,k)/(2*Room_area(j,k));
    end
end
% ��������ߴ���������Ƥ��ȣ���ȡ���ֵΪ��վλ��Ƥ���պ�ȣ�
for k=1:n_rib
    for j=1:n_room
        t_skin(j,k)=abs(qt_room(j,k))/(0.1*sigma_s_alum);
    end
end
% ������Ť������ĸ����ߴ�����������ļ���q0
for k=1:n_rib
    q0_pla(1,k)=qt_room(1,k);
    q0_pla(2,k)=qt_room(2,k)-qt_room(1,k);
    q0_pla(3,k)=qt_room(3,k)-qt_room(2,k);
    q0_pla(4,k)=(-1)*qt_room(3,k);
end

% ����������ߴ�ȷ���������t_spar���������и�����������ͬ
K_pla=zeros(1,n_rib); % K_pla���Ա��������λ�õ�������ն���Ϣ
q1_pla=zeros(n_spar,n_rib); % q1_pla���Ա����ɼ�������ĸ�����վλ��������λ�ô����ܼ�����Ϣ
q_pla=zeros(n_spar,n_rib); % q_pla���Ա����ɼ�����Ť�ص�������ĸ�����վλ��������λ�ô����ܼ�����Ϣ
t_pla_alum=zeros(n_spar,n_rib); % t_pla���������վλ�����Ŀ�����������Ϣ
t_pla_carbon=zeros(n_spar,n_rib);
t_pla_alum_add=zeros(n_spar,n_rib); % t_pla���������վλ�����Ŀ�����������Ϣ
t_pla_carbon_add=zeros(n_spar,n_rib);
for k=1:n_rib
    for i=1:n_spar
        K_pla(k)=K_pla(k)+(L_spar_h_abs(i,k)^2);
    end
end
% �����ɼ�������ĸ�����վλ���������������ܼ���q1��С�����նȷ��䣩
for i=1:n_spar
    for j=1:n_rib
        q1_pla(i,j)=(A_q(j)*((L_spar_h_abs(i,j)^2)/K_pla(j)))/L_spar_h_abs(i,j);
    end
end
% �����ɼ�����Ť�ص�������ĸ�����վλ���������������ܼ���q��С�����նȷ��䣩
for i=1:n_spar
    for j=1:n_rib
        q_pla(i,j)=q0_pla(i,j)+q1_pla(i,j);
    end
end
% ���������վλ������������ĺ��
for i=1:n_spar
    for j=1:n_rib
        % ���һ�������Ǽ�װ����
        t_pla_alum(i,j)=((abs(q_pla(i,j))*(L_spar_h_abs(i,j)^2))/(0.9*5.6*E_alum))^(1/3);
        t_pla_carbon(i,j)=((abs(q_pla(i,j))*(L_spar_h_abs(i,j)^2))/(0.9*5.6*E_carbon))^(1/3);
        % ����������Ǽ�װ����
        t_pla_alum_add(i,j)=((abs(q_pla(i,j))*(L_spar_h_abs(i,j)^2))/(0.9*9.38*E_alum))^(1/3);
        t_pla_carbon_add(i,j)=((abs(q_pla(i,j))*(L_spar_h_abs(i,j)^2))/(0.9*9.38*E_carbon))^(1/3);
    end
end

% ������Ե���ߴ�ȷ�������������
% ���ȿ�������Ե����������ر���Ϊϵ��Me��������Ƥ������ر���ΪMs=1-Me���󲿷֣���������ҪУ��
Me=0.08;
Ms=1-Me;
A_my=Me*A_m; % ������վλ����Ե�������������
Ke_str=0.95; % ������Ե����Ч�������ϵ��

M_str=zeros(n_spar,n_rib); % ���������վλ������Ե��������أ����նȷ��䣩
N_str=zeros(n_spar,n_rib); % ���������վλ������Ե����������
A_str_lower=zeros(n_spar,n_rib); % ���������վλ������Ե��������������죩
A_str_upper_001=zeros(n_spar,n_rib); % ���������վλ������Ե��������������죩
A_str_upper_002=zeros(n_spar,n_rib); % ���������վλ������Ե��������������죩
la_str_lower=zeros(n_spar,n_rib);
lb_str_lower=zeros(n_spar,n_rib);
la_str_upper_001=zeros(n_spar,n_rib);
lb_str_upper_001=zeros(n_spar,n_rib);
la_str_upper_002=zeros(n_spar,n_rib);
lb_str_upper_002=zeros(n_spar,n_rib);

% ���������վλ��������Ե����ش�С�����նȷ��䣩
for k=1:n_rib
    for i=1:n_spar
        M_str(i,k)=A_my(k)*((L_spar_h_abs(i,k)^2)/K_pla(k));
        N_str(i,k)=M_str(i,k)/L_spar_h_abs(i,k);
    end
end

% ȷ����Ե���ߴ硪���������ɾ�ǿ��ȷ����A=N/sigma_b
for k=1:n_rib
    for i=1:n_spar
        A_str_lower(i,k)=(N_str(i,k)/sigma_b_alum)/Ke_str;
        la_str_lower(i,k)=0.08;
        lb_str_lower(i,k)=A_str_lower(i,k)/la_str_lower(i,k);
    end
end

% ȷ����Ե���ߴ硪����ѹ����ѹ�������ȶ���ȷ�������ַ�ʽ��
% ����һ
for k=1:n_rib
    for i=1:n_spar
        A_str_upper_001(i,k)=(N_str(i,k)/sigma_e_alum)/Ke_str;
        la_str_upper_001(i,k)=0.08;
        lb_str_upper_001(i,k)=A_str_upper_001(i,k)/la_str_upper_001(i,k);
    end
end

% ������
for k=1:n_rib
    if (k<n_rib)
        l_ik=(L_rib_all(k+1)-L_rib_all(k))*bth;
    else
        l_ik=(1-L_rib_all(k))*bth;
    end
    for i=1:n_spar
        lb_str_upper_002(i,k)=(((3*N_str(i,k)*(l_ik^2))/(20*4*(pi^2)*sigma_e_alum))^(1/3))/Ke_str;
        la_str_upper_002(i,k)=0.08;
        A_str_upper_002(i,k)=la_str_upper_002(i,k)*lb_str_upper_002(i,k);
    end
end

%% ģ��4���ߴ���������
fprintf('��UAV������ҪԪ���ߴ���㣨2020/07/10����\n');
fprintf('\n');
fprintf('����Ƥ�ߴ硿\n');
fprintf('\n');
ts=max(t_skin);
fprintf('���ҶΣ�0*��ͨ�ߣ�����Ƥ���Ϊ��%.4f��mm��\n',ts(1)*e);
fprintf('�м�Σ�5*��ͨ�ߣ�����Ƥ���Ϊ��%.4f��mm��\n',ts(5)*e);
fprintf('���ҶΣ�9*��ͨ�ߣ�����Ƥ���Ϊ��%.4f��mm��\n',ts(n_rib)*e);
fprintf('\n');
fprintf('�������ߴ硿\n');
fprintf('\n');
fprintf('��������ߴ硿��ע��CATIA��ģʱ��ͨ�����ߺ����ߴ�������������������\n');
fprintf('\n');
fprintf('1) ������߶�\n');
fprintf('\n');
for i=1:n_spar
    fprintf('��%d# ��������ߴ��߶�Ϊ��%.4f��mm��\n',i,L_spar_h_abs(i,1)*e);
    fprintf('��%d# ���������ߴ��߶�Ϊ��%.4f��mm��\n',i,L_spar_h_abs(i,n_rib)*e);
    fprintf('\n');
end
fprintf('\n');
fprintf('2) ��������\n');
fprintf('\n');
fprintf('���1������֧��������LY12���Ͻ�\n');
for i=1:n_spar
    ta=max(t_pla_alum');
    fprintf('��%d# ��������Ϊ��%.4f��mm��\n',i,ta(i)*e);
end
fprintf('\n');
fprintf('���2����֧��������LY12���Ͻ�\n');
for i=1:n_spar
    ta_add=max(t_pla_alum_add');
    fprintf('��%d# ��������Ϊ��%.4f��mm��\n',i,ta_add(i)*e);
end
fprintf('\n');
fprintf('���3������֧�������ù���I��̼��ά\n');
for i=1:n_spar
    tc=max(t_pla_carbon');
    fprintf('��%d# ��������Ϊ��%.4f��mm��\n',i,tc(i)*e);
end
fprintf('\n');
fprintf('���4����֧�������ù���I��̼��ά\n');
for i=1:n_spar
    tc_add=max(t_pla_carbon_add');
    fprintf('��%d# ��������Ϊ��%.4f��mm��\n',i,tc_add(i)*e);
end
fprintf('\n');
fprintf('����Ե���ߴ硿�����ù������ṹ��\n');
fprintf('\n');
fprintf('���1������LY12���Ͻ�\n');
for i=1:n_spar
    ta=max(A_str_lower');
    fprintf('��%d# ��Ե�������Ϊ��%.4f��mm^2��\n',i,ta(i)*e*e);
end
for i=1:n_spar
    la=max(la_str_lower');
    fprintf('��%d# ��Ե�����Ϊ��%.4f��mm��\n',i,la(i)*e);
end
for i=1:n_spar
    lb=max(lb_str_lower');
    fprintf('��%d# ��Ե���߶�Ϊ��%.4f��mm��\n',i,lb(i)*e);
end
fprintf('\n');
for i=1:n_spar
    ta=max(A_str_upper_001');
    fprintf('����һ����%d# ��Ե�������Ϊ��%.4f��mm^2��\n',i,ta(i)*e*e);
end
for i=1:n_spar
    la=max(la_str_upper_001');
    fprintf('����һ����%d# ��Ե������Ϊ��%.4f��mm��\n',i,la(i)*e);
end
for i=1:n_spar
    lb=max(lb_str_upper_001');
    fprintf('����һ����%d# ��Ե�����Ϊ��%.4f��mm��\n',i,lb(i)*e);
end
fprintf('\n');
for i=1:n_spar
    ta=max(A_str_upper_002');
    fprintf('����������%d# ��Ե�������Ϊ��%.4f��mm^2��\n',i,ta(i)*e*e);
end
for i=1:n_spar
    la=max(la_str_upper_002');
    fprintf('����������%d# ��Ե������Ϊ��%.4f��mm��\n',i,la(i)*e);
end
for i=1:n_spar
    lb=max(lb_str_upper_002');
    fprintf('����������%d# ��Ե�����Ϊ��%.4f��mm��\n',i,lb(i)*e);
end
fprintf('\n');
