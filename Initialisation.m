clear all;close all; clc;


global ts tf R I m CoM Ai Bp rp Im AE Fv Fs  Xi Xf Z_OFFSET_FIXED_FRAME
    ts = 0.001;
    tf = 10;
    %platform data
    Xi = [0, 0.0, 1.5, 0, 0, 0]'; %initial pose in base frame 
    Xf = [0.2, 0.0, 1.8, 0, 0, pi/8]'; %final pose in base frame
    CoM = 0*[8.64, -0.03, 188.53]' * 1e-3;
    m   = 25.73; %kg
    %Inertia kg*m²
    I = [2176870526.32      -69899831.59       -11268902.91;
        -69899831.59         2389077810.19     -1000235.91;
        -11268902.91        -1000235.91         1889912107.76] * 1e-9;
    rp = .04; %pulley radius (80mm de diamètre)
    Z_OFFSET_FIXED_FRAME = 0.2;
    Bp = [-0.2492,   -0.2483,   -0.2488,   -0.1909,    0.2483,    0.1887,    0.2503,    0.2482;
           0.2021,    0.2021,   -0.2021,   -0.2743,   -0.2021,   -0.2749,    0.2019,    0.2021;
           0.1291,   -0.2112,   -0.2876,    0.2230,    0.2112,   -0.2987,   -0.2090,    0.1291];
    %Ai fully constrained
    % Ai = [-4.18012386167155,	-3.845507759387148,	-3.791318219896986,	-4.10392975470496,	4.10092060599512,	3.779653061521267,	3.780407488047897,	4.09649764452530;
    %       -1.82310484386710,	 -1.367837380000738,	1.324747987699964,	1.76558665087905,	1.78690397515010,	 1.334595543377403,	-1.336999857000712,	 -1.78941411953632;
    %        2.88812529819398-Z_OFFSET_FIXED_FRAME,	0.119457136996449-Z_OFFSET_FIXED_FRAME,	 0.127153685309803-Z_OFFSET_FIXED_FRAME,	2.89863326833304-Z_OFFSET_FIXED_FRAME,	2.90409783215508-Z_OFFSET_FIXED_FRAME,	0.128242662629527-Z_OFFSET_FIXED_FRAME,	0.123602457100741-Z_OFFSET_FIXED_FRAME,	2.88884620949064-Z_OFFSET_FIXED_FRAME];
    Ai = [-4.1801   -3.8455   -3.7913   -4.1039    4.1009    3.7797    3.7804    4.0965;
          -1.8231   -1.3678    1.3247    1.7656    1.7869    1.3346   -1.3370   -1.7894;
           2.6881   -0.0805   -0.0728    2.6986    2.7041   -0.0718   -0.0764    2.6888];
    % %Ai suspended
    % Ai =[-4.1801   -4.6303   -4.5624   -4.1039    4.1009    4.5553    4.5549    4.0965;
    %      -1.8231   -1.3654    1.3216    1.7656    1.7869    1.3345   -1.3394   -1.7894;
    %       2.6881    2.6868    2.6993    2.6986    2.7041    2.6995    2.6917    2.6888];

    %Winch data
    AE = 4.8e5;
    Im = 0.0198*eye(8);%0.0198kg⋅m² %à partir des calculs, m = rho*V
    R  = (sqrt(0.08^2 + 0.005^2/(2*pi))/25)   * eye(8);
    %R  = 0.04   * eye(8);
    Fv = 0;
    Fs = 0;

%%    
    

%Im = 12245154.08*1e-9*eye(8);

%load('FullyconstrainedAB.mat')
%load('SuspendedCDPR_AiBp.mat')


%%
% Logic : MGI(Xi) => li => q, ti... (ti, li) ==>li_0

%%
%Performed off-line to initiate motor positions and tensions

W = WrenchMatrix(Xi);

fg = [0  0  m*9.8]';
g =  [fg; cross(fg, CoM)];

tau_ci = nan(8,1);
fd = -g; %torseur appliqué dans Xi == W_e
Aeq = real(W);
beq = fd;
H = 2*ones(8);
f = zeros(1,8);
tau_ci = quadprog(H, f, [], [], Aeq, beq, 50*ones(8,1), 5000*ones(8,1));


l= MGI_Fconstrained(Xi);


l0 = nan(8,1);

for i=1:8
    l0(i) = (AE * l(i))/(tau_ci(i) + AE);
end
qi = R\l0;



tau_mi = R*tau_ci;
% %tau_mi = round(tau_mi, 3);
% 
% 
% li_0_initial = li_0;
% upp = 1000*ones(8,1);
% low = 10*ones(8,1);