%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================

%% Estimation
tic;
rc              = 11;          
tetha           = 3;
start_point     = [rc  tetha];
options                         = optimoptions('fmincon','Display','iter', 'Algorithm','sqp', 'FiniteDifferenceType','central');
[est_params,FVAL,EXITFLAG]      = fmincon('loglikeli',start_point,[],[],[],[], [0 0],[],[],options); % %   FMINSEARCH uses the Nelder-Mead simplex (direct search) method.
toc;

beta                    = 0.9999;
threshold               = 1e-6;  
[loglikeli, fixed_point, pchoice, p_mileage , ~] = estimation(est_params,beta, threshold);
graphs;


 