%% �����ж���ѧ�����£��γ̴���ҵ
%% N0.2���ɻ����ȶ��ԡ����˶�ģ̬���Է���
%% ��������
% Using the data of the given aircraft to 
%	1. Calculate the short-period, roll-subsidence and Dutch-roll mode parameters, including ��_sp, ��_sp, T_r, ��_d, ��_d;
%	2. Evaluate the flying quality for Category A flight phases;
% 	3. Design proper flight control system to make the aircraft has Level I flying quality
% For the given flight condition: �� H=5000m, M=0.8; �� H=8000m, M=0.8; �� H=14000m, M=1.4.

%% ���ؼ�����
% Step 1: Define the flight condition;
% Step 2: Define the geometry and mass data;
% Step 3: Calculate the airspeed and density based on flight condition,using the atmosphere model;
% Step 4: Load aerodynamic data;
% Step 5: Calculate the aerodynamic derivatives based on the flight condition using interpolation;
% Step 6: Calculate the matrix A_long,B_long, A_lat, B_lat;
% Step 7: Calculate the mode parameters, i.e., ��_sp, ��_sp, CAP,and T_r,��_d, ��_d;

%% ������Ϣ
% �ڿ���ʦ��������ʦ
% ���������
% ѧ�ţ�2017300281
% ѧԺ������ѧԺ
% ���ʱ�䣺2020��5��1��

%% �����ʼ���뻷������
clear all
clc
format short;
fprintf('��������Ϣ��\n');
fprintf('�����ж���ѧ�����£��γ̴���ҵ\n');
fprintf('���������\n');
fprintf('ѧ�ţ�2017300281\n');
fprintf('ѧԺ������ѧԺ\n');
fprintf('\n');
fprintf('��Problem 2�� �ɻ����ȶ��ԡ��˶�ģ̬�����������н��\n');
fprintf('\n');

%% Question 1������ģ̬���㣺Calculate the short-period, roll-subsidence and Dutch-roll mode parameters, including ��_sp, ��_sp, T_r, ��_d, ��_d;��
fprintf('��Question 1�� �ɻ���������ģ̬���㣺\n');
fprintf('\n');

%% Step 1: �������״̬
% ����ɻ���������
H=5000; % ������и߶ȣ��ɵ������������
Ma=0.8; % ���������������ɵ������������
g=9.807; % ��γ45�ȵ������������ٶ�ֵ

% ����ɻ�ˮƽ��ֵ���и��Ƕ�״̬
alfa=0; % ӭ��
beta=0; % �໬��

psi=0; % ƫ����
theta=alfa; % ������
phi=0; % ��ת��

%% Step 2: ����ɻ���������������
fprintf('��Part 1�� �ɻ�����Ҫ��������������\n');
fprintf('\n');
% ����ɻ������������
S=23; % �ο������������λ��m^2��
b=7.15; % ������չ���ȣ���λ��m��
c_mean=4.002; % ����ƽ�������ҳ�����λ��m��

fprintf('�ɻ�����Ҫ���γߴ磺\n');
fprintf('�ο�������� S = %.4f m^2\n',S);
fprintf('������չ���� b = %.4f m\n',b);
fprintf('����ƽ�������ҳ� c_mean = %.4f m\n',c_mean);
fprintf('\n');

% ����ɻ������������
m=6000; % ȫ����������λ��kg��
Ix=4312; % ȫ����x�������Ծأ���λ��kg*m^2��
Iy=45374; % ȫ����y�������Ծأ���λ��kg*m^2��
Iz=48216; % ȫ����z�������Ծأ���λ��kg*m^2��
Ixz=0; % ȫ����x��,z����Ի�����λ��kg*m^2��

fprintf('�ɻ�����Ҫ����������\n');
fprintf('ȫ������ m = %.4f kg\n',m);
fprintf('ȫ����x�������Ծ� Ix = %.4f kg*m^2\n',Ix);
fprintf('ȫ����y�������Ծ� Iy = %.4f kg*m^2\n',Iy);
fprintf('ȫ����z�������Ծ� Iz = %.4f kg*m^2\n',Iz);
fprintf('ȫ����x��,z����Ի� Ixz = %.4f kg*m^2\n',Ixz);
fprintf('\n');

%% Step 3: ���ݷɻ�����״̬����ϴ���ģ�ͣ���������ٶ��뵱�ش����ܶ�
% ���㵱ǰ���к��θ߶��µ��¶�T��ѹǿp
if (H<11000)     % ������߶�
    T=288.15-0.0065*H;
    p=101325*((1-2.25577*H*(1e-5)).^(5.2588)); % ѹǿp�뺣�θ߶�H֮���ϵ���㹫ʽһ
%   p=101.3*1000*((288.15./(288.15-6.5*H*0.001)).^(34.17./(-6.5))); % ѹǿp�뺣�θ߶�H֮���ϵ���㹫ʽ��
elseif (H<20000) % ͬ�²�߶�
    T=216.65;
    p=22631*exp(-((H-11000)*g)/(287*216.65));
else
    fprintf('\n');
    fprintf('���󣺵�ǰ���к��θ߶ȴ���20000m�������״̬������������������\n');
    fprintf('\n');
    exit;
end

% ���㵱ǰ�����ٶ�
a=sqrt(1.4*287*T); % ���㵱������
V=Ma*a; % ��������ٶ�

% ���㵱�ش����ܶ�
rou=p/(287*T);

% �����ǰ����״̬��Ϣ
fprintf('��Part 2�� �ɻ���ǰ�趨����״̬\n');
fprintf('\n');

fprintf('���к��θ߶ȣ�H = %d��m��\n',H);
fprintf('�����������Ma = %.2f\n',Ma);
fprintf('�����¶ȣ�T = %.2f��K��\n',T);
fprintf('���ش���ѹǿ��p = %.2f��Pa��\n',p);
fprintf('���ش����ܶȣ��� = %.2f��kg/m^3��\n',rou);
fprintf('�������٣�a = %.2f��m/s��\n',a);
fprintf('��ǰ�����ٶȣ�V = %.2f��m/s��\n',V);
fprintf('\n');

%% Step 4: ��������ɻ���������
LAD=load('Longitudinal Aerodynamic Data.txt');
% �����������ݸ��д������˵��
% 1 - H���߶ȣ���2 - Ma�����������3 - C_L_alfa��������б�ʣ���4 - C_m_CL��
% 5 - C_m_det_e�����������Ч�ʣ���6 - C_L_det_e��7 - C_m_q�����ᶯ��������
% 8 - C_m_alfa_dot�����ᶯ��������9 - C_m_alfa�������ȶ���ָ�꣬�������ض�ӭ�ǵ����ĵ�������
% 10 - C_m0��������������ϵ����

% ����ɻ��ẽ����������
LDAD=load('Lateral-Directional Aerodynamic Data.txt');
% �ẽ���������ݸ��д������˵��
% 1 - H���߶ȣ���2 - Ma�����������3 - C_y_beta��4 - C_l_beta�������ȶ���ָ�꣬�����Բ໬�ǵĵ�������
% 5 - C_n_beta�������ȶ���ָ�꣬ƫ�����ضԲ໬�ǵĵ�������6 - C_y_det_r��7 - C_l_det_r��
% 8 - C_n_det_r����������Ч�ʣ���9 - C_l_det_a�����ݸ������Ч�ʣ���
% 10 - C_l_p����ת���ᶯ��������11 - C_n_r��ƫ�����ᶯ��������12 - C_n_p���������ᶯ��������13 - C_l_r���������ᵼ����

% ��ȡ�ݺẽ��״̬�ĸ���
LAD_num=length(LAD); % ����״̬����
LDAD_num=length(LDAD); % �ẽ��״̬����

%% Step 5: �����������״̬�µ��������������ò�ֵ������
% ��������������ȡ����
Long_Num=8; % ����������������8��
H_LAD=[0,3,5,8,10]; % �����������ݱ���и����߶ȼ���
N_Ma_long=[5,6,7];
H1=H/1000;
times_long=(H1-H_LAD(end))/(H_LAD(end)-H_LAD(end-1));
Long_Com=zeros(length(H_LAD),Long_Num);
% Case 1: �����и߶��ڱ���и��������У�����ȡ��Ӧ�߶����ݣ���ͨ����ֵ��������������������
% Case 2: ���򣬲������β�ֵ���Ȳ�ֵ��������ٲ�ֵ�߶ȣ����������������
% Case 1:
if (~isempty(find(H_LAD==H1,1)))
    % ����һ����ȡ��Ӧ�߶�����
    cnt=0;
    for i=1:LAD_num
        if (LAD(i,1)==H1)
            cnt=cnt+1;
            Long_Ori_Data(cnt,:)=LAD(i,:);
        end
    end
    % ���������Ma��ֵ��õ�ǰ����״̬�µĸ�������������
    if (Ma>max(LAD(:,2)))
        Long_Ma=Long_Ori_Data(:,2);
        Long_003=Long_Ori_Data(:,3);
        Long_004=Long_Ori_Data(:,4);
        Long_005=Long_Ori_Data(:,5);
        Long_006=Long_Ori_Data(:,6);
        Long_007=Long_Ori_Data(:,7);
        Long_008=Long_Ori_Data(:,8);
        Long_009=Long_Ori_Data(:,9);
        Long_010=Long_Ori_Data(:,10);
        C_l_alfa=interp1(Long_Ma(N_Ma_long),Long_003(N_Ma_long),Ma,'spline');
        C_m_Cl=interp1(Long_Ma(N_Ma_long),Long_004(N_Ma_long),Ma,'spline');
        C_m_det_e=interp1(Long_Ma(N_Ma_long),Long_005(N_Ma_long),Ma,'spline');
        C_l_det_e=interp1(Long_Ma(N_Ma_long),Long_006(N_Ma_long),Ma,'spline');
        C_m_q=interp1(Long_Ma(N_Ma_long),Long_007(N_Ma_long),Ma,'spline');
        C_m_alfa_dot=interp1(Long_Ma(N_Ma_long),Long_008(N_Ma_long),Ma,'spline');
        C_m_alfa=interp1(Long_Ma(N_Ma_long),Long_009(N_Ma_long),Ma,'spline');
        C_m0=interp1(Long_Ma(N_Ma_long),Long_010(N_Ma_long),Ma,'spline');     
    else
        C_l_alfa=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,3),Ma,'linear');
        C_m_Cl=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,4),Ma,'linear');
        C_m_det_e=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,5),Ma,'linear');
        C_l_det_e=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,6),Ma,'linear');
        C_m_q=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,7),Ma,'linear');
        C_m_alfa_dot=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,8),Ma,'linear');
        C_m_alfa=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,9),Ma,'linear');
        C_m0=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,10),Ma,'linear');      
    end
% Case 2:
else
    % ����һ������֪�߶ȣ�H=0,3,5,8,10km�����ڷ��������״̬���в�ֵ�����ϲ�����
    for k=1:length(H_LAD)
        cnt=0;
        for i=1:LAD_num
            if (LAD(i,1)==H_LAD(k))
                cnt=cnt+1;
                Long_Data_k(cnt,:)=LAD(i,:);
            end
        end
        Long_Ma=Long_Data_k(:,2);
        for j=1:8
            if (Ma>max(Long_Ma))
                Long_para=Long_Data_k(:,(j+2));
                Long_Com(k,j)=interp1(Long_Ma(N_Ma_long),Long_para(N_Ma_long),Ma,'spline');
            else
                Long_Com(k,j)=interp1(Long_Ma,Long_Data_k(:,(j+2)),Ma,'linear');
            end            
        end
        clear Long_Data_k;
    end
    % ��������Ը������и߶�״̬���в�ֵ���ڲ����壩����ø���������������
    if (H1>max(H_LAD))
        C_l_alfa=Long_Com(5,1)+(times_long*(Long_Com(5,1)-Long_Com(4,1)));
        C_m_Cl=Long_Com(5,2)+(times_long*(Long_Com(5,2)-Long_Com(4,2)));
        C_m_det_e=Long_Com(5,3)+(times_long*(Long_Com(5,3)-Long_Com(4,3)));
        C_l_det_e=Long_Com(5,4)+(times_long*(Long_Com(5,4)-Long_Com(4,4)));
        C_m_q=Long_Com(5,5)+(times_long*(Long_Com(5,5)-Long_Com(4,5)));
        C_m_alfa_dot=Long_Com(5,6)+(times_long*(Long_Com(5,6)-Long_Com(4,6)));
        C_m_alfa=Long_Com(5,7)+(times_long*(Long_Com(5,7)-Long_Com(4,7)));
        C_m0=Long_Com(5,8)+(times_long*(Long_Com(5,8)-Long_Com(4,8)));       
    else
        C_l_alfa=interp1(H_LAD,Long_Com(:,1)',H1,'linear');
        C_m_Cl=interp1(H_LAD,Long_Com(:,2)',H1,'linear');
        C_m_det_e=interp1(H_LAD,Long_Com(:,3)',H1,'linear');
        C_l_det_e=interp1(H_LAD,Long_Com(:,4)',H1,'linear');
        C_m_q=interp1(H_LAD,Long_Com(:,5)',H1,'linear');
        C_m_alfa_dot=interp1(H_LAD,Long_Com(:,6)',H1,'linear');
        C_m_alfa=interp1(H_LAD,Long_Com(:,7)',H1,'linear');
        C_m0=interp1(H_LAD,Long_Com(:,8)',H1,'linear');        
    end
end

% �ẽ������������ȡ����
Lat_Dir_Num=11; % �ẽ��������������11��
H_LDAD=[0,3,5,8]; % �ẽ���������ݱ���и����߶ȼ���
H2=H/1000;
times_lat=(H2-H_LDAD(end))/(H_LDAD(end)-H_LDAD(end-1));
N_Ma_lat=[5,6,7];
Lat_Dir_Com=zeros(length(H_LDAD),Lat_Dir_Num);
% Case 1: �����и߶��ڱ���и��������У�����ȡ��Ӧ�߶����ݣ���ͨ����ֵ��������������������
% Case 2: ���򣬲������β�ֵ���Ȳ�ֵ��������ٲ�ֵ�߶ȣ����������������
% Case 1:
if (~isempty(find(H_LDAD==H2,1)))
    % ����һ����ȡ��Ӧ�߶�����
    cnt=0;
    for i=1:LDAD_num
        if (LDAD(i,1)==H2)
            cnt=cnt+1;
            Lat_Dir_Ori_Data(cnt,:)=LDAD(i,:);
        end
    end
    % ���������Ma��ֵ��õ�ǰ����״̬�µĸ�������������
    if (Ma>max(LDAD(:,2)))
        Lat_Ma=Lat_Dir_Ori_Data(:,2);
        Lat_003=Lat_Dir_Ori_Data(:,3);
        Lat_004=Lat_Dir_Ori_Data(:,4);
        Lat_005=Lat_Dir_Ori_Data(:,5);
        Lat_006=Lat_Dir_Ori_Data(:,6);
        Lat_007=Lat_Dir_Ori_Data(:,7);
        Lat_008=Lat_Dir_Ori_Data(:,8);
        Lat_009=Lat_Dir_Ori_Data(:,9);
        Lat_010=Lat_Dir_Ori_Data(:,10);
        Lat_011=Lat_Dir_Ori_Data(:,11);
        Lat_012=Lat_Dir_Ori_Data(:,12);
        Lat_013=Lat_Dir_Ori_Data(:,13);
        C_y_beta=interp1(Lat_Ma(N_Ma_lat),Lat_003(N_Ma_lat),Ma,'spline');
        C_l_beta=interp1(Lat_Ma(N_Ma_lat),Lat_004(N_Ma_lat),Ma,'spline');
        C_n_beta=interp1(Lat_Ma(N_Ma_lat),Lat_005(N_Ma_lat),Ma,'spline');
        C_y_det_r=interp1(Lat_Ma(N_Ma_lat),Lat_006(N_Ma_lat),Ma,'spline');
        C_l_det_r=interp1(Lat_Ma(N_Ma_lat),Lat_007(N_Ma_lat),Ma,'spline');
        C_n_det_r=interp1(Lat_Ma(N_Ma_lat),Lat_008(N_Ma_lat),Ma,'spline');
        C_l_det_a=interp1(Lat_Ma(N_Ma_lat),Lat_009(N_Ma_lat),Ma,'spline');
        C_l_p=interp1(Lat_Ma(N_Ma_lat),Lat_010(N_Ma_lat),Ma,'spline');
        C_n_r=interp1(Lat_Ma(N_Ma_lat),Lat_011(N_Ma_lat),Ma,'spline');
        C_n_p=interp1(Lat_Ma(N_Ma_lat),Lat_012(N_Ma_lat),Ma,'spline');
        C_l_r=interp1(Lat_Ma(N_Ma_lat),Lat_013(N_Ma_lat),Ma,'spline');
    else
        C_y_beta=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,3),Ma,'linear');
        C_l_beta=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,4),Ma,'linear');
        C_n_beta=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,5),Ma,'linear');
        C_y_det_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,6),Ma,'linear');
        C_l_det_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,7),Ma,'linear');
        C_n_det_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,8),Ma,'linear');
        C_l_det_a=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,9),Ma,'linear');
        C_l_p=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,10),Ma,'linear');
        C_n_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,11),Ma,'linear');
        C_n_p=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,12),Ma,'linear');
        C_l_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,13),Ma,'linear');
    end
% Case 2:
else
    % ����һ������֪�߶ȣ�H=0,3,5,8km�����ڷ��������״̬���в�ֵ�����ϲ�����
    for k=1:length(H_LDAD)
        cnt=0;
        for i=1:LDAD_num
            if (LDAD(i,1)==H_LDAD(k))
                cnt=cnt+1;
                Lat_Dir_Data_k(cnt,:)=LDAD(i,:);
            end
        end
        Lat_Ma=Lat_Dir_Data_k(:,2);
        Lat_003=Lat_Dir_Data_k(:,3);
        Lat_004=Lat_Dir_Data_k(:,4);
        Lat_005=Lat_Dir_Data_k(:,5);
        Lat_006=Lat_Dir_Data_k(:,6);
        Lat_007=Lat_Dir_Data_k(:,7);
        Lat_008=Lat_Dir_Data_k(:,8);
        Lat_009=Lat_Dir_Data_k(:,9);
        Lat_010=Lat_Dir_Data_k(:,10);
        Lat_011=Lat_Dir_Data_k(:,11);
        Lat_012=Lat_Dir_Data_k(:,12);
        Lat_013=Lat_Dir_Data_k(:,13);
        Lat_Dir_Com(k,1)=interp1(Lat_Ma(N_Ma_lat),Lat_003(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,2)=interp1(Lat_Ma(N_Ma_lat),Lat_004(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,3)=interp1(Lat_Ma(N_Ma_lat),Lat_005(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,4)=interp1(Lat_Ma(N_Ma_lat),Lat_006(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,5)=interp1(Lat_Ma(N_Ma_lat),Lat_007(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,6)=interp1(Lat_Ma(N_Ma_lat),Lat_008(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,7)=interp1(Lat_Ma(N_Ma_lat),Lat_009(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,8)=interp1(Lat_Ma(N_Ma_lat),Lat_010(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,9)=interp1(Lat_Ma(N_Ma_lat),Lat_011(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,10)=interp1(Lat_Ma(N_Ma_lat),Lat_012(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,11)=interp1(Lat_Ma(N_Ma_lat),Lat_013(N_Ma_lat),Ma,'spline');
        clear Lat_Dir_Data_k;
    end
    % ��������Ը������и߶�״̬���в�ֵ���ڲ����壩����ø���������������
    if (H2>max(H_LDAD))
        C_y_beta=Lat_Dir_Com(4,1)+(times_lat*(Lat_Dir_Com(4,1)-Lat_Dir_Com(3,1)));
        C_l_beta=Lat_Dir_Com(4,2)+(times_lat*(Lat_Dir_Com(4,2)-Lat_Dir_Com(3,2)));
        C_n_beta=Lat_Dir_Com(4,3)+(times_lat*(Lat_Dir_Com(4,3)-Lat_Dir_Com(3,3)));
        C_y_det_r=Lat_Dir_Com(4,4)+(times_lat*(Lat_Dir_Com(4,4)-Lat_Dir_Com(3,4)));
        C_l_det_r=Lat_Dir_Com(4,5)+(times_lat*(Lat_Dir_Com(4,5)-Lat_Dir_Com(3,5)));
        C_n_det_r=Lat_Dir_Com(4,6)+(times_lat*(Lat_Dir_Com(4,6)-Lat_Dir_Com(3,6)));
        C_l_det_a=Lat_Dir_Com(4,7)+(times_lat*(Lat_Dir_Com(4,7)-Lat_Dir_Com(3,7)));
        C_l_p=Lat_Dir_Com(4,8)+(times_lat*(Lat_Dir_Com(4,8)-Lat_Dir_Com(3,8)));
        C_n_r=Lat_Dir_Com(4,9)+(times_lat*(Lat_Dir_Com(4,9)-Lat_Dir_Com(3,9)));
        C_n_p=Lat_Dir_Com(4,10)+(times_lat*(Lat_Dir_Com(4,10)-Lat_Dir_Com(3,10)));
        C_l_r=Lat_Dir_Com(4,11)+(times_lat*(Lat_Dir_Com(4,11)-Lat_Dir_Com(3,11)));
    else
        C_y_beta=interp1(H_LDAD,Lat_Dir_Com(:,1)',H2,'linear');
        C_l_beta=interp1(H_LDAD,Lat_Dir_Com(:,2)',H2,'linear');
        C_n_beta=interp1(H_LDAD,Lat_Dir_Com(:,3)',H2,'linear');
        C_y_det_r=interp1(H_LDAD,Lat_Dir_Com(:,4)',H2,'linear');
        C_l_det_r=interp1(H_LDAD,Lat_Dir_Com(:,5)',H2,'linear');
        C_n_det_r=interp1(H_LDAD,Lat_Dir_Com(:,6)',H2,'linear');
        C_l_det_a=interp1(H_LDAD,Lat_Dir_Com(:,7)',H2,'linear');
        C_l_p=interp1(H_LDAD,Lat_Dir_Com(:,8)',H2,'linear');
        C_n_r=interp1(H_LDAD,Lat_Dir_Com(:,9)',H2,'linear');
        C_n_p=interp1(H_LDAD,Lat_Dir_Com(:,10)',H2,'linear');
        C_l_r=interp1(H_LDAD,Lat_Dir_Com(:,11)',H2,'linear');
    end
end

%% Step 6: ��������ϵͳ����A_long��������ݾ���B_long���ẽ��ϵͳ����A_lat���ẽ����ݾ���B_lat
fprintf('��Part 3�� �ɻ����߻�С�Ŷ��˶����̸�ϵͳ����ݾ��������\n');
fprintf('\n');

%% �� �����˶����̾���A_long��B_long����
% �Բ�ֵ�õ���������������per����(deg)-->per����(rad)��ת�����������й��ڽǶȵĵ�����
mk=(180/pi); % ����ת������
% ������������ת��
C_l_alfa=C_l_alfa*mk;
C_m_det_e=C_m_det_e*mk;
C_l_det_e=C_l_det_e*mk;
C_m_alfa=C_m_alfa*mk;
% �ẽ����������ת��
C_y_beta=C_y_beta*mk;
C_l_beta=C_l_beta*mk;
C_n_beta=C_n_beta*mk;
C_y_det_r=C_y_det_r*mk;
C_l_det_r=C_l_det_r*mk;
C_n_det_r=C_n_det_r*mk;
C_l_det_a=C_l_det_a*mk;

% ����ԭ������δ��������ϵ���������ߣ���Ϣ���ʲο������׸�-21/��-7�ɻ�����
% ��������������Ϊ CD = 0.012 + 0.07*CL^2 (CD = CD0 + k*CL^2)��0.025��
% ��Ҫ������������
W=m*g; % �ɻ�����
L=W; % ˮƽ��ֵ
CL=L/(0.5*rou*V*V*S); % ����ϵ������
C_D0=0.012; % ��������ϵ��
ke=0.07; % �յ�����ϵ��
CD=C_D0+ke*(CL^2); % ����ϵ������
E=CL/CD; % ����ȼ���
C_D_det_e=0;

% ����������������
C_D_u=0;
C_D_alfa_dot=0;
C_l_alfa_dot=0;
C_D_alfa=2*ke*CL*C_l_alfa;
C_D_q=0;
C_l_q=0;
C_l_u=0;
C_m_u=0;

% �����·��ű���
m1=(2*m)/(rou*V*S);
c1=c_mean/(2*V);
q=0.5*rou*V*V;
qc=q;
Iy1=Iy/(qc*S*c_mean);

C_x_u=-(2*CD)-C_D_u;
C_x_alfa_dot=(-1)*C_D_alfa_dot;
C_z_alfa_dot=(-1)*C_l_alfa_dot;
C_x_alfa=CL-C_D_alfa;
C_x_q=(-1)*C_D_q;
C_z_q=(-1)*C_l_q;
C_x_theta=(-1)*CL*cos(theta);
C_z_alfa=(-1)*C_l_alfa+(-1)*CD;
C_x_det_e=(-1)*C_D_det_e;
C_z_theta=(-1)*CL*sin(theta);
C_z_u=(-2)*CL+(-1)*C_l_u;
C_z_det_e=(-1)*C_l_det_e;

Eps1=(C_x_alfa_dot*c1)/m1;
Eps2=(C_m_alfa_dot*c1)/m1;

% ��������ϵͳ����A_long��Ԫ��
A11_long=(C_x_u+(Eps1*C_z_u))/m1;
A12_long=(C_x_alfa+(Eps1*C_z_alfa))/m1;
A13_long=(C_x_q+Eps1*(m1+(C_z_q*c1)))/m1;
A14_long=(C_x_theta+(Eps1*C_z_theta))/m1;
A21_long=C_z_u/m1;
A22_long=C_z_alfa/m1;
A23_long=(m1+(C_z_q*c1))/m1;
A24_long=C_z_theta/m1;
A31_long=(C_m_u+(Eps2*C_z_u))/Iy1;
A32_long=(C_m_alfa+(Eps2*C_z_alfa))/Iy1;
A33_long=((C_m_q*c1)+(Eps2*(m1+(C_z_q*c1))))/Iy1;
A34_long=(Eps2*C_z_theta)/Iy1;
A41_long=0;
A42_long=0;
A43_long=1;
A44_long=0;

% ������������ϵͳ����A_long
fprintf('[3.1] �����˶�������Ҫϵ���������£�\n');
fprintf('\n');
fprintf('����ϵͳ����A_long��\n');

A_long=[A11_long A12_long A13_long A14_long
        A21_long A22_long A23_long A24_long
        A31_long A32_long A33_long A34_long
        A41_long A42_long A43_long A44_long];
% �������ϵͳ����A_long
A_long

% ����������ݾ���B_long��Ԫ��
B11_long=(C_x_det_e+(Eps1*C_z_det_e))/m1;
B21_long=C_z_det_e/m1;
B31_long=(C_m_det_e+(Eps2*C_z_det_e))/Iy1;
B41_long=0;

% ��������������ݾ���B_long
fprintf('������ݾ���B_long��\n');

B_long=[B11_long
        B21_long
        B31_long
        B41_long];
% ���������ݾ���B_long
B_long

%% �� �ẽ���˶����̾���A_lat��B_lat����
% �����·��ű���
C_y_phi=(m*g*cos(phi))/(q*S);
b1=b/(2*V);
Ix1=Ix/(qc*S*b);
Iz1=Iz/(qc*S*b);
Ixz1=Ixz/(qc*S*b);
Ix1_dot=Ix1/((Ix1*Iz1)-(Ixz1^2));
Iz1_dot=Iz1/((Ix1*Iz1)-(Ixz1^2));
Ixz1_dot=Ixz1/((Ix1*Iz1)-(Ixz1^2));
Eps3=Iz1_dot*C_l_beta;
Eps4=Ix1_dot*C_n_beta;

% ���������������
C_y_p=0;
C_y_r=0;
C_y_det_a=0;
C_n_det_a=0;

% ����ẽ��ϵͳ����A_lat��Ԫ��
A11_lat=C_y_beta/m1;
A12_lat=C_y_phi/m1;
A13_lat=C_y_p*b1/m1;
A14_lat=(-1)*((m1-(b1*C_y_r))/m1);
A21_lat=0;
A22_lat=0;
A23_lat=1;
A24_lat=0;
A31_lat=(C_l_beta*Iz1_dot)+(C_n_beta*Ixz1_dot)+(b1*Eps3*A11_lat);
A32_lat=(Eps3*b1*A12_lat);
A33_lat=b1*((C_l_p*Iz1_dot)+(C_n_p*Ixz1_dot)+(Eps3*A13_lat));
A34_lat=b1*((C_l_r*Iz1_dot)+(C_n_r*Ixz1_dot)+(Eps3*A14_lat));
A41_lat=(Ix1_dot*C_n_beta)+(Ixz1_dot*C_l_beta)+(b1*Eps4*A11_lat);
A42_lat=Eps4*b1*A12_lat;
A43_lat=b1*((C_n_p*Ix1_dot)+(C_l_p*Ixz1_dot)+(Eps4*A13_lat));
A44_lat=b1*((Ix1_dot*C_n_r)+(Ixz1_dot*C_l_r)+(Eps4*A14_lat));

% ���������ẽ��ϵͳ����A_lat
fprintf('[3.2] �ẽ���˶�������Ҫϵ���������£�\n');
fprintf('\n');
fprintf('�ẽ��ϵͳ����A_lat��\n');

A_lat=[A11_lat A12_lat A13_lat A14_lat
       A21_lat A22_lat A23_lat A24_lat
       A31_lat A32_lat A33_lat A34_lat
       A41_lat A42_lat A43_lat A44_lat];
% ����ẽ��ϵͳ����A_lat
A_lat

% ����ẽ����ݾ���B_lat��Ԫ��
B11_lat=C_y_det_a/m1;
B12_lat=C_y_det_r/m1;
B21_lat=0;
B22_lat=0;
B31_lat=(C_l_det_a*Iz1_dot)+(C_n_det_a*Ixz1_dot)+(Eps3*b1*B11_lat);
B32_lat=(C_l_det_a*Iz1_dot)+(C_n_det_r*Ixz1_dot)+(Eps3*b1*B12_lat);
B41_lat=(C_n_det_a*Ix1_dot)+(C_l_det_a*Ixz1_dot)+(Eps4*b1*B11_lat);
B42_lat=(C_n_det_r*Ix1_dot)+(C_l_det_r*Ixz1_dot)+(Eps4*b1*B12_lat);

% ���������ẽ����ݾ���B_lat
fprintf('�ẽ����ݾ���B_lat��\n');
B_lat=[B11_lat B12_lat
       B21_lat B22_lat
       B31_lat B32_lat
       B41_lat B42_lat];
% ����ẽ����ݾ���B_lat
B_lat

%% Step 7: ����short-period�������ڣ���roll-subsidence����ת������and Dutch-roll����������ģ̬������_sp, ��_sp, CAP,and T_r,��_d, ��_d; 
%% �� ��������ڣ�short-period��ģ̬������_sp, ��_sp �� CAP
% ����A_long���������ֵ���ж������ȶ������ģ̬����
fprintf('��Part 4�� �ɻ������򡢺ẽ�������ģ̬����\n');
fprintf('\n');
fprintf('[4.2] �ɻ�����������ģ̬������\n');
fprintf('\n');
fprintf('����ϵͳ����A_long������ֵΪ��\n');
A_long_eig=eig(A_long);
% �������ϵͳ����A_long������ֵ
A_long_eig
A_long_eig_real=real(A_long_eig); % ����A_long��������ֵ��ʵ��
A_long_eig_imag=imag(A_long_eig); % ����A_long��������ֵ���鲿

% ��A_long���������ֵ����Ӧģ̬����������ö�Ӧ�����ᡢ��Ƶ�Ķ�����ģ̬
% �ɻ�����ģ̬˵��
% �������� I�� һ�Խϴ����������Ӧ������ģ̬
Lambda_sp_1=A_long_eig(1);
Lambda_sp_2=A_long_eig(2);
fprintf('[����ģ̬��ȡ I�������ڣ�short-period��ģ̬]\n');
fprintf('\n');
fprintf('��Ӧ������ģ̬��һ�Թ���� Lambda_sp = %.4f +(-) %.4fi\n',(real(Lambda_sp_1)),abs(imag(Lambda_sp_1)));
fprintf('\n');
Omega_sp=sqrt((real(Lambda_sp_1))^2+(imag(Lambda_sp_1))^2); % ������ģ̬����Ƶ�ʦ�_sp
Zeta_sp=(-1)*real(Lambda_sp_1)/Omega_sp; % ������ģ̬����Ȧ�_sp
n_alfa=(1/(2*W))*rou*V*V*S*C_l_alfa;
CAP_sp=(Omega_sp^2)/n_alfa; % ������ģ̬������������CAP
fprintf('������ģ̬ ����ȣ�ֱ�ӣ� ��_sp = %.4f\n',Zeta_sp);
fprintf('������ģ̬ ����Ƶ�ʣ�ֱ�ӣ� ��_sp = %.4f\n',Omega_sp);
fprintf('������ģ̬ ��������������ֱ�ӣ� CAP = %.4f\n',CAP_sp);
fprintf('\n');

% ���ö����ڽ��Ƽ���ģ̬��������
Omega_sp_appro=sqrt(((C_z_alfa*c1*C_m_q)/(m1*Iy1))-(C_m_alfa/Iy1));
Zeta_sp_appro=(-1)*(C_z_alfa/m1+(c1/Iy1)*(C_m_q+C_m_alfa_dot))/(2*sqrt(((C_z_alfa*c1*C_m_q)/(m1*Iy1))-(C_m_alfa/Iy1)));
CAP_sp_appro=(Omega_sp_appro^2)/n_alfa;
fprintf('������ģ̬ ����ȣ����ƣ� ��_sp_appro = %.4f\n',Zeta_sp_appro);
fprintf('������ģ̬ ����Ƶ�ʣ����ƣ� ��_sp_appro = %.4f\n',Omega_sp_appro);
fprintf('������ģ̬ �����������������ƣ� CAP_appro = %.4f\n',CAP_sp_appro);
fprintf('\n');

% ������ģֱ̬������Ƽ���ģ̬�����������Ƚ�
Omega_sp_error=(abs(Omega_sp-Omega_sp_appro))/(Omega_sp);
Zeta_sp_error=(abs(Zeta_sp-Zeta_sp_appro))/(Zeta_sp);
CAP_sp_error=(abs(CAP_sp-CAP_sp_appro))/(CAP_sp);
fprintf('������ģ̬ ����ȣ�������ֱ�Ӽ����� ��_sp_error = %.4f %%\n',Zeta_sp_error*100);
fprintf('������ģ̬ ����Ƶ�ʣ�������ֱ�Ӽ����� ��_sp_error = %.4f %%\n',Omega_sp_error*100);
fprintf('������ģ̬ ��������������������ֱ�Ӽ����� CAP_error = %.4f %%\n',CAP_sp_error*100);
fprintf('\n');

% �������� II�� һ�Խ�С�����������Ӧ������ģ̬������ģ̬��
Lambda_p_1=A_long_eig(3);
Lambda_p_2=A_long_eig(4);
fprintf('[����ģ̬��ȡ II�������ڣ�long-period/phugoid��ģ̬]\n');
fprintf('\n');
fprintf('��Ӧ������ģ̬��һ�Թ���� Lambda_p = %.4f +(-) %.4fi\n',(real(Lambda_p_1)),abs(imag(Lambda_p_1)));
fprintf('\n');
Omega_p=sqrt((real(Lambda_p_1))^2+(imag(Lambda_p_1))^2);
Zeta_p=(-1)*real(Lambda_p_1)/Omega_p;
fprintf('������ģ̬ ����ȣ�ֱ�ӣ� ��_p = %.4f\n',Zeta_p);
fprintf('������ģ̬ ����Ƶ�ʣ�ֱ�ӣ� ��_p = %.4f\n',Omega_p);
fprintf('\n');

%% �� ����roll-subsidence����ת������and Dutch-roll����������ģ̬���� T_r,��_d, ��_d
% ����A_lat���������ֵ���жϺẽ���ȶ������ģ̬����
fprintf('[4.3] �ɻ��ĺẽ������ģ̬������\n');
fprintf('\n');
fprintf('�ẽ��ϵͳ����A_lat������ֵΪ��\n');
A_lat_eig=eig(A_lat);
% ����ẽ��ϵͳ����A_lat������ֵ
A_lat_eig
A_lat_eig_real=real(A_lat_eig); % ����A_lat��������ֵ��ʵ��
A_lat_eig_imag=imag(A_lat_eig); % ����A_lat��������ֵ���鲿

% �ɻ��ẽ���ģ̬˵��
% �������� I�� һ���ϴ�ʵ��������Ӧ��ת����ģ̬����Ӧ���٣�
Lambda_r=A_lat_eig(3);
fprintf('[�ẽ��ģ̬��ȡ I����ת������roll-subsidence��ģ̬]\n');
fprintf('\n');
fprintf('��Ӧ��ת����ģ̬����Ӧ���٣���һ���ϴ�ʵ�� Lambda_r = %.4f\n',Lambda_r);
fprintf('\n');

% ����roll-subsidence����ת��������ת����ʱ�䳣��T_r
T_r=(-1)*(1/Lambda_r);
fprintf('��ת����ģ̬ ��ת����ʱ�䳣����ֱ�ӣ� T_r = %.4f\n',T_r);
fprintf('\n');

% ���ù�ת�������Ƽ���ģ̬��������
Lambda_r_appro=(C_l_p*b1)/Ix1;
T_r_appro=(-1)*(1/Lambda_r_appro);
fprintf('��ת����ģ̬ ��ת����ʱ�䳣�������ƣ� T_r_appro = %.4f\n',T_r_appro);
fprintf('\n');

% ��ת����ģֱ̬������Ƽ���ģ̬�����������Ƚ�
T_r_error=(abs(T_r-T_r_appro))/(T_r);
fprintf('��ת����ģ̬ ��ת����ʱ�䳣����������ֱ�Ӽ����� T_r_error = %.4f %%\n',T_r_error*100);
fprintf('\n');

% �������� II�� һ���еȹ����������Ӧ������ģ̬����Ӧ�еȣ�
Lambda_d_1=A_lat_eig(1);
Lambda_d_2=A_lat_eig(2);
fprintf('[�ẽ��ģ̬��ȡ II����������Dutch-roll��ģ̬]\n');
fprintf('\n');
fprintf('��Ӧ������ģ̬����Ӧ�еȣ���һ���еȹ���� Lambda_d = %.4f +(-) %.4fi\n',(real(Lambda_d_1)),abs(imag(Lambda_d_1)));
fprintf('\n');

% ����Dutch-roll������������_d, ��_d
Omega_d=sqrt((real(Lambda_d_1))^2+(imag(Lambda_d_1))^2);
Zeta_d=(-1)*real(Lambda_d_1)/Omega_d;
Zeta_d_Omega_d=Omega_d*Zeta_d;
fprintf('������ģ̬ ����ȣ�ֱ�ӣ� ��_d = %.4f\n',Zeta_d);
fprintf('������ģ̬ ����Ƶ�ʣ�ֱ�ӣ� ��_d = %.4f\n',Omega_d);
fprintf('������ģ̬ �����*����Ƶ�ʣ�ֱ�ӣ� ��_d*��_d = %.4f\n',Zeta_d_Omega_d);
fprintf('\n');

% ���ú��������Ƽ���ģ̬��������
Omega_d_appro=sqrt((1/(m1*Iz1))*((C_y_beta*C_n_r*b1)+C_n_beta*(m1-(b1*C_y_r))));
Zeta_d_appro=(-1)*(1/(2*Omega_d))*((C_y_beta/m1)+((b1*C_n_r)/Iz1));
Zeta_d_Omega_d_appro=Zeta_d_appro*Omega_d_appro;
fprintf('������ģ̬ ����ȣ����ƣ� ��_d_appro = %.4f\n',Zeta_d_appro);
fprintf('������ģ̬ ����Ƶ�ʣ����ƣ� ��_d_appro = %.4f\n',Omega_d_appro);
fprintf('������ģ̬ �����*����Ƶ�ʣ����ƣ� ��_d*��_d_appro = %.4f\n',Zeta_d_Omega_d_appro);
fprintf('\n');

%������ģֱ̬������Ƽ���ģ̬�����������Ƚ�
Omega_d_error=(abs(Omega_d-Omega_d_appro))/(Omega_d);
Zeta_d_error=(abs(Zeta_d-Zeta_d_appro))/(Zeta_d);
Zeta_d_Omega_d_error=(abs(Zeta_d_Omega_d-Zeta_d_Omega_d_appro))/(Zeta_d_Omega_d);
fprintf('������ģ̬ ����ȣ�������ֱ�Ӽ����� ��_d_error = %.4f %%\n',Zeta_d_error*100);
fprintf('������ģ̬ ����Ƶ�ʣ�������ֱ�Ӽ����� ��_d_error = %.4f %%\n',Omega_d_error*100);
fprintf('������ģ̬ �����*����Ƶ�ʣ�������ֱ�Ӽ����� ��_d*��_d_error = %.4f %%\n',Zeta_d_Omega_d_error*100);
fprintf('\n');

% �������� III�� һ����С��ʵ��������Ӧ����ģ̬����Ӧ������
Lambda_s=A_lat_eig(4);
fprintf('[�ẽ��ģ̬��ȡ III��������spiral��ģ̬]\n');
fprintf('\n');
fprintf('��Ӧ����ģ̬����Ӧ��������һ����С��ʵ�� Lambda_s = %.4f\n',Lambda_s);
fprintf('\n');

%% Question 2������Ʒ��������Evaluate the flying quality for Category A flight phases;��
fprintf('��Question 2�� �ɻ����з���Ʒ��������\n');
fprintf('\n');

%% Step 8�������ɻ��ڷǳ���A�ַ��н׶εķ���Ʒ�ʣ���չ����plus��
% ������Ҫ��������Ʒ�ʵĶ�����Ϣ
Flight_phases='A'; % ������Ҫ��������Ʒ�ʵķ��н׶�����
Airplane_Class='IV'; % ������Ҫ��������Ʒ�ʵķɻ�����
fprintf('��Part 5�� ������Ҫ��������Ʒ�ʵĶ�����Ϣ���£�\n');
fprintf('��Ҫ��������Ʒ�ʵķ��н׶�����Ϊ��%s��\n',Flight_phases);
fprintf('��Ҫ��������Ʒ�ʵķɻ�����Ϊ��%s��\n',Airplane_Class);
fprintf('\n');

% ���������Ʒ�ʡ�����
%  ������ģ̬Ʒ��Ҫ����������_sp, ��_sp �� CAP��
fprintf('��Part 6�� �������Ʒ��Ҫ��������\n');
fprintf('\n');
fprintf('[6.1] ������ģ̬Ʒ��Ҫ����������_sp, ��_sp �� CAP����\n');
fprintf('\n');

% �� ����Ȧ�_spҪ��
if ((Flight_phases=='A') || (Flight_phases=='C'))
    if ((Zeta_sp>=0.35) && (Zeta_sp<=1.30))
        Type_Zeta_sp='I';
    elseif ((Zeta_sp>=0.25) && (Zeta_sp<=2.00))
        Type_Zeta_sp='II';
    elseif (Zeta_sp>=0.15)
        Type_Zeta_sp='III';
    else
        Type_Zeta_sp='Unknown';
    end
else
    if ((Zeta_sp>=0.30) && (Zeta_sp<=2.00))
        Type_Zeta_sp='I';
    elseif ((Zeta_sp>=0.20) && (Zeta_sp<=2.00))
        Type_Zeta_sp='II';
    elseif (Zeta_sp>=0.15)
        Type_Zeta_sp='III';
    else
        Type_Zeta_sp='Unknown';
    end
end
fprintf('������ģ̬ ����� ��_sp �ȼ�Ϊ��%s��\n',Type_Zeta_sp);

% �� ������������CAPҪ��
if (Flight_phases=='A')
    if ((CAP_sp>=0.28) && (CAP_sp<=3.60))
        Type_CAP_sp='I';
    elseif ((CAP_sp>=0.16) && (CAP_sp<=10.00))
        Type_CAP_sp='II';
    elseif (CAP_sp>=0.16)
        Type_CAP_sp='III';
    else
        Type_CAP_sp='Unknown';
    end
elseif (Flight_phases=='B')
    if ((CAP_sp>=0.085) && (CAP_sp<=3.60))
        Type_CAP_sp='I';
    elseif ((CAP_sp>=0.038) && (CAP_sp<=10.00))
        Type_CAP_sp='II';
    elseif (CAP_sp>=0.038)
        Type_CAP_sp='III';
    else
        Type_CAP_sp='Unknown';
    end
else
    if ((CAP_sp>=0.16) && (CAP_sp<=3.6))
        Type_CAP_sp='I';
    elseif ((CAP_sp>=0.096) && (CAP_sp<=10.00))
        Type_CAP_sp='II';
    elseif (CAP_sp>=0.096)
        Type_CAP_sp='III';
    else
        Type_CAP_sp='Unknown';
    end
end
fprintf('������ģ̬ ������������CAP �ȼ�Ϊ��%s��\n',Type_CAP_sp);
fprintf('\n');

% ������ģ̬���շ���Ʒ������
% �Ƚ�����Ȧ�_sp�������������CAP�ĵȼ���ȡ�ȼ���С��
if (length(Type_Zeta_sp)>length(Type_CAP_sp))
    Type_sp=Type_Zeta_sp;
else
    Type_sp=Type_CAP_sp;
end
fprintf('������ģ̬ ���շ���Ʒ������ �ȼ�Ϊ��%s��\n',Type_sp);
fprintf('\n');

% ���ẽ�����Ʒ�ʡ�����
%  ��ת����ģ̬Ʒ��Ҫ��������T_r��
fprintf('��Part 7�� �������Ʒ��Ҫ��������\n');
fprintf('\n');

% ��ת����ʱ�䳣��T_rҪ��
fprintf('[7.1] ��ת����ģ̬Ʒ��Ҫ��������T_r����\n');
fprintf('\n');
if ((Flight_phases=='A') || (Flight_phases=='C'))
    if ((strcmp(Airplane_Class,'I')==1) || (strcmp(Airplane_Class,'IV')==1))
        if (T_r<=1.0)
            Type_T_r='I';
        elseif (T_r<=1.4)
            Type_T_r='II';
        elseif (T_r<=10.0)
            Type_T_r='III';
        else
            Type_T_r='Unknown';
        end
    else
        if (T_r<=1.0)
            Type_T_r='I';
        elseif (T_r<=1.4)
            Type_T_r='II';
        elseif (T_r<=10.0)
            Type_T_r='III';
        else
            Type_T_r='Unknown';
        end
    end
else
    if (T_r<=1.4)
        Type_T_r='I';
    elseif (T_r<=3.0)
        Type_T_r='II';
    elseif (T_r<=10.0)
        Type_T_r='III';
    else
        Type_T_r='Unknown';
    end
end
fprintf('��ת����ģ̬ ���շ���Ʒ������ �ȼ�Ϊ��%s��\n',Type_T_r);
fprintf('\n');

% �ẽ�����Ʒ�ʣ�������ģ̬Ʒ��Ҫ����������_d, ��_d*��_d, ��_d��
fprintf('[7.2] ������ģ̬Ʒ��Ҫ����������_d, ��_d*��_d, ��_d����\n');
fprintf('\n');
% �� ����Ȧ�_dҪ�󡢦�_d*��_dҪ����ȻƵ�ʦ�_dҪ��
if (Flight_phases=='A')
    if ((strcmp(Airplane_Class,'I')==1) || (strcmp(Airplane_Class,'IV')==1))
        if ((Zeta_d>=0.19) && (Zeta_d_Omega_d>=0.35) && (Omega_d>=1.0))
            Type_dutch_roll='I';
        elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
            Type_dutch_roll='II';
        elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
            Type_dutch_roll='III';
        else
            Type_dutch_roll='Unknown';
        end
    else
        if ((Zeta_d>=0.19) && (Zeta_d_Omega_d>=0.35) && (Omega_d>=0.4))
            Type_dutch_roll='I';
        elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
            Type_dutch_roll='II';
        elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
            Type_dutch_roll='III';
        else
            Type_dutch_roll='Unknown';
        end
    end
elseif (Flight_phases=='B')
    if ((Zeta_d>=0.08) && (Zeta_d_Omega_d>=0.15) && (Omega_d>=0.4))
        Type_dutch_roll='I';
    elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
        Type_dutch_roll='II';
    elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
        Type_dutch_roll='III';
    else
        Type_dutch_roll='Unknown';
    end
else
    if ((strcmp(Airplane_Class,'I')==1) || (strcmp(Airplane_Class,'II_C_b')==1) || (strcmp(Airplane_Class,'IV')==1))
        if ((Zeta_d>=0.08) && (Zeta_d_Omega_d>=0.15) && (Omega_d>=1.0))
            Type_dutch_roll='I';
        elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
            Type_dutch_roll='II';
        elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
            Type_dutch_roll='III';
        else
            Type_dutch_roll='Unknown';
        end
    else
        if ((Zeta_d>=0.08) && (Zeta_d_Omega_d>=0.15) && (Omega_d>=0.4))
            Type_dutch_roll='I';
        elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
            Type_dutch_roll='II';
        elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
            Type_dutch_roll='III';
        else
            Type_dutch_roll='Unknown';
        end
    end
end
fprintf('������ģ̬ ���շ���Ʒ������ �ȼ�Ϊ��%s��\n',Type_dutch_roll);
fprintf('\n');
