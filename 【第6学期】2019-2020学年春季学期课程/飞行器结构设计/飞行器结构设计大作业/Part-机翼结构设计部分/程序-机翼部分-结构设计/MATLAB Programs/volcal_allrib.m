function Vol_Goal = volcal_allrib(L_rib_x)
%% �����Ԫ���ߴ��Ż�MATLABĿ�꺯��
%% ģ��1������ԭʼ�ߴ硢����ҪԪ��վλ���ݡ��������Ե���
% ��������Ϣ��
Mmax=10394; % ����������
Mh=Mmax; % ������������һ�루���Ե���������������㣩
Mw=1160; % ���������������
f=1.5; % ��ȫϵ��
g=9.8; % �������ٶ�
nmax=3; % ���������ϵ��

% ��������Ҫ�ߴ硿
e=1000; % ���ű���
bt=35420/e; % ��չ����
bth=bt/2; % ����չ����
cr=1873.3/e; % ���ҳ���
ct=749.3/e; % ���ҳ���
theta=atan((cr-ct)/bth); % ����ǰԵ���ӽ�

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

% ��������ͨ����λ��
L_rib_0=0.01;
% L_rib_3=0.302208571428571;
% L_rib_4=0.418507142857143;
% L_rib_5=0.534805714285714;
% L_rib_6=0.6511042857142861;
% L_rib_7=0.767402857142857;
% L_rib_8=0.883701428571429;
% L_rib_9=0.95;
% L_rib=[L_rib_3,L_rib_x]; % �������ͨ������԰���չλ�ã������������ߣ�
L_rib=L_rib_x;

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
Room_C_foil=zeros(1,n_rib); % ���������ܳ�
for k=1:n_rib
    for i=1:n_room
        dl=(L_spar(i+1)-L_spar(i))*c_rib_all(k);
        ht=L_spar_h_abs(i,k)+L_spar_h_abs(i+1,k);
        dh=abs(L_spar_h_abs(i+1,k)-L_spar_h_abs(i,k));
        Room_area(i,k)=(0.5*ht)*dl;
        Room_C(i,k)=dl+ht+sqrt(dl^2+dh^2);
    end
end
for k=1:n_rib
    Room_C_foil(k)=(Room_C(1,k)+Room_C(2,k)+Room_C(3,k))-2*(L_spar_h_abs(2,k)-L_spar_h_abs(3,k));
end

% ���������ԡ�
% ̼��ά��������
% sigma_e_carbon; % ��ѹʧ���ٽ�Ӧ������λ��Pa��
% LY12���Ͻ��������
E_alum=68e9; % ��������ģ������λ��Pa��
sigma_s_alum=325e6; % �������ޣ���λ��Pa��
rou_alum=2770; % �����ܶ�

%% ģ��2�����������λ��������Ϣ���������
% ����չ�������λ�õļ���Q�����M�ֲ����㣨���ù�ʽ������
syms x; % ���û��ַ��ű���x
A_q=zeros(1,n_rib); % ���������չ����ͨ����վλ����Fyֵ
A_m=zeros(1,n_rib); % ���������չ����ͨ����վλ���Mzֵ
A_mt=zeros(1,n_rib); % ���������չ����ͨ����վλŤ��Mtֵ

% �Ը�����վλ�����ؽ��м���
for i=1:n_rib
    L=L_rib_all(i)*bth; % ȡ����ǰ��������λ��
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

% �����߸�����ȷ���������t_rib��
t_rib=zeros(1,n_rib);
for k=1:n_rib
    a_rib=(L_spar_2-L_spar_1)*c_rib_all(k);
    b_rib=L_spar_h_abs(1,k);
    K_rib=5.6+(3.78/((a_rib/b_rib)^2));
    t_rib(k)=(abs((q_pla(1,k)*b_rib*b_rib))/(0.9*K_rib*E_alum))^(1/3);
end

%% ģ��4���ṹ��������Ԫ�����������
% ������жγ���
dis_long=zeros(1,n_rib);
for k=1:n_rib-1
    dis_long(k)=(L_rib_all(k+1)-L_rib_all(k))*bth;
end
dis_long(n_rib)=(1-L_rib_all(n_rib))*bth;

% ��Ƥ�ڰ����������������
Vol_Skin=0;
t_skin_max=max(t_skin);
for i=1:n_rib
    Vol_Skin=Vol_Skin+(t_skin_max(i)*Room_C_foil(i)*dis_long(i));
end

% ���߸������������������
Vol_Rib=0;
for i=1:n_rib
    Vol_Rib=Vol_Rib+((Room_area(1,i)+Room_area(2,i)+Room_area(3,i))*t_rib(i));
end

% ����Ԫ�������ΪVol_Goal
Vol_Goal=(Vol_Skin+Vol_Rib)*rou_alum;

end

