%% �����ж���ѧ�����£��γ̴���ҵ
%% N0.1���ɻ��ݺẽ���ᾲ�ȶ��ԡ�������Ч�ʷ���
%% ��������
% �Ը��ݱ�1���2�е��������ݣ����Ʒɻ��ݺẽ���ᾲ�ȶ��ԡ�������Ч��
% ��߶���������ı仯���ߣ��������߱仯���Ƽ���ɸ����Ƶ�ԭ����з�����

%% ������Ϣ
% �ڿ���ʦ��������ʦ
% ���������
% ѧ�ţ�2017300281
% ѧԺ������ѧԺ
% ���ʱ�䣺2020��5��1��

%% �����ʼ�������ݵ���
% �����ʼ��
clear all
clc
format short;
fprintf('��������Ϣ��\n');
fprintf('�����ж���ѧ�����£��γ̴���ҵ\n');
fprintf('���������\n');
fprintf('ѧ�ţ�2017300281\n');
fprintf('ѧԺ������ѧԺ\n');
fprintf('\n');
fprintf('��Problem 1�� �ɻ����ȶ��ԡ�������Ч�ʷ����������н��\n');
fprintf('\n');
fprintf('ͼ�ο��ӻ������ͼ�� Figure 1 ~ 6��\n');
fprintf('\n');
fprintf('ͼ1.1���ɻ������ȶ����������Ma�ı仯���ߣ���ͬ���θ߶�H��\n');
fprintf('ͼ1.2���ɻ����������Ч���������Ma�ı仯���ߣ���ͬ���θ߶�H��\n');
fprintf('ͼ2.1���ɻ������ȶ����������Ma�ı仯���ߣ���ͬ���θ߶�H��\n');
fprintf('ͼ2.2���ɻ����������Ч���������Ma�ı仯���ߣ���ͬ���θ߶�H��\n');
fprintf('ͼ3.1���ɻ������ȶ����������Ma�ı仯���ߣ���ͬ���θ߶�H��\n');
fprintf('ͼ3.2���ɻ����������Ч���������Ma�ı仯���ߣ���ͬ���θ߶�H��\n');
fprintf('\n');

% ����ɻ�������ẽ����������
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
LAD_num=length(LAD);
LDAD_num=length(LDAD);

%% ����ģ���-->���ȶ��Է����������ȶ�������������棨������Elevator��Ч�ʻ�ͼ����
%% ����һ����ȡ���������ȶ��������������Ч�ʲ�������
% Ԥ����и߶�H��ȡֵ����
Long_H_set=[0,3,5,8,10];
Long_Ma_Sta_Mat=zeros(5,7); % �趨��Ӧ״̬���������
Long_Sta_Mat=zeros(5,7); % �趨�����ȶ���״̬����
Long_Ctrl_Mat=zeros(5,7); % �趨��Ӧ״̬���������Ч�ʾ���
Long_Mat_num=zeros(1,5);
for i=1:LAD_num
    k=find(Long_H_set==LAD(i,1)); % ��¼�ɻ���ǰ���ں��θ߶ȵĶ�Ӧ״̬���
    Long_Mat_num(1,k)=Long_Mat_num(1,k)+1; % ��������1
    Long_Sta_Mat(k,Long_Mat_num(1,k))=LAD(i,9); % ��¼C_m_alfa
    Long_Ma_Sta_Mat(k,Long_Mat_num(1,k))=LAD(i,2); % ��¼��ӦMa
    Long_Ctrl_Mat(k,Long_Mat_num(1,k))=LAD(i,5); % ��¼��ӦC_m_det_e
end

%% ����������Ʒɻ������ȶ�����������ı仯���ߣ���5���߶ȣ�
plot(Long_Ma_Sta_Mat',Long_Sta_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('�����\itMa'),ylabel('C_{m\alpha}'),title('ͼ1.1���ɻ������ȶ���C_{m\alpha}�������Ma�ı仯���ߣ���ͬ���θ߶�H��');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','H = 10 km','FontName','Times New Roman');
grid on;
box on;

% ����Y���귶Χ
ylim(gca,[-0.012 0]);

% ��Y����ת
set(gca,'YDir','reverse');

%% �����������Ʒɻ����������Ч����������ı仯���ߣ���5���߶ȣ�
figure;
plot(Long_Ma_Sta_Mat',Long_Ctrl_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('�����\itMa'),ylabel('C_{m\delta{e}}'),title('ͼ1.2���ɻ���������棨�����棩Ч��C_{m\delta{e}}�������Ma�ı仯���ߣ���ͬ���θ߶�H��');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','H = 10 km','FontName','Times New Roman');
grid on;
box on;
% ��Y����ת
set(gca,'YDir','reverse');
% ����Y���귶Χ
ylim(gca,[-0.010 -0.004]);

%% ����ģ���-->���ȶ��Է����������ȶ����뺽������棨�����Rudder��Ч�ʻ�ͼ����
%% ����һ����ȡ���������ȶ����뺽�������Ч�ʲ�������
Dir_H_set=[0,3,5,8];
Dir_Ma_Sta_Mat=zeros(4,7); % �趨��Ӧ״̬���������
Dir_Sta_Mat=zeros(4,7); % �趨�����ȶ���״̬����
Dir_Ctrl_Mat=zeros(4,7); % �趨��Ӧ״̬��������Ч�ʾ���
Dir_Mat_num=zeros(1,4);
for i=1:LDAD_num
    k=find(Dir_H_set==LDAD(i,1)); % ��¼�ɻ���ǰ���ں��θ߶ȵĶ�Ӧ״̬���
    Dir_Mat_num(1,k)=Dir_Mat_num(1,k)+1; % ��������1
    Dir_Ma_Sta_Mat(k,Dir_Mat_num(1,k))=LDAD(i,2); % ��¼��ӦMa
    Dir_Sta_Mat(k,Dir_Mat_num(1,k))=LDAD(i,5); % ��¼C_l_beta
    Dir_Ctrl_Mat(k,Dir_Mat_num(1,k))=LDAD(i,8); % ��¼��ӦC_n_det_r
end

%% ����������Ʒɻ������ȶ�����������ı仯���ߣ���4���߶ȣ�
figure;
plot(Dir_Ma_Sta_Mat',Dir_Sta_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('�����\itMa'),ylabel('C_{n\beta}'),title('ͼ2.1���ɻ������ȶ���C_{n\beta}�������Ma�ı仯���ߣ���ͬ���θ߶�H��');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','FontName','Times New Roman');
grid on;
box on;

%% �����������Ʒɻ����������Ч����������ı仯���ߣ���4���߶ȣ�
figure;
plot(Dir_Ma_Sta_Mat',Dir_Ctrl_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('�����\itMa'),ylabel('C_{n\delta{r}}'),title('ͼ2.2���ɻ���������棨����棩Ч��C_{n\delta{r}}�������Ma�ı仯���ߣ���ͬ���θ߶�H��');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','FontName','Times New Roman');
grid on;
box on;
% ��Y����ת
set(gca,'YDir','reverse');

%% ����ģ���-->���ȶ��Է����������ȶ������������棨����Ailron��Ч�ʻ�ͼ����
%% ����һ����ȡ���������ȶ�������������Ч�ʲ�������
Lat_H_set=[0,3,5,8];
Lat_Ma_Sta_Mat=zeros(4,7); % �趨��Ӧ״̬���������
Lat_Sta_Mat=zeros(4,7); % �趨�����ȶ���״̬����
Lat_Ctrl_Mat=zeros(4,7); % �趨��Ӧ״̬��������Ч�ʾ���
Lat_Mat_num=zeros(1,4);
for i=1:LDAD_num
    k=find(Lat_H_set==LDAD(i,1)); % ��¼�ɻ���ǰ���ں��θ߶ȵĶ�Ӧ״̬���
    Lat_Mat_num(1,k)=Lat_Mat_num(1,k)+1; % ��������1
    Lat_Ma_Sta_Mat(k,Lat_Mat_num(1,k))=LDAD(i,2); % ��¼��ӦMa
    Lat_Sta_Mat(k,Lat_Mat_num(1,k))=LDAD(i,4); % ��¼C_n_beta
    Lat_Ctrl_Mat(k,Lat_Mat_num(1,k))=LDAD(i,9); % ��¼��ӦC_l_det_a
end

%% ����������Ʒɻ������ȶ�����������ı仯���ߣ���4���߶ȣ�
figure;
plot(Lat_Ma_Sta_Mat',Lat_Sta_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('�����\itMa'),ylabel('C_{l\beta}'),title('ͼ3.1���ɻ������ȶ���C_{l\beta}�������Ma�ı仯���ߣ���ͬ���θ߶�H��');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','FontName','Times New Roman');
grid on;
box on;
% ��Y����ת
set(gca,'YDir','reverse');
% ����Y���귶Χ
ylim(gca,[-0.0018 0]);

%% �����������Ʒɻ����������Ч����������ı仯���ߣ���4���߶ȣ�
figure;
plot(Lat_Ma_Sta_Mat',Lat_Ctrl_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('�����\itMa'),ylabel('C_{l\delta{a}}'),title('ͼ3.2���ɻ���������棨����棩Ч��C_{l\delta{a}}�������Ma�ı仯���ߣ���ͬ���θ߶�H��');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','FontName','Times New Roman');
grid on;
box on;
% ��Y����ת
set(gca,'YDir','reverse');
% ����Y���귶Χ
ylim(gca,[-0.0014 0]);
