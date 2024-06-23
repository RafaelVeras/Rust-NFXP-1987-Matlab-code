%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================

function [EV_new ] = fx_point(EV,vf_myopic,trans_mat ,regen_mat, beta)

c  = vf_myopic(:,1);
tr = vf_myopic(:,2);

%% pchoice
p_choice                    = choice_prob(EV, vf_myopic, beta);
% p_choice represents the probability of keeping the current bus engine as a function of accumulated mileage ;
% its complement the probability of replacing a bus engine as a function of accumulated mileage

zmax=max(-c+beta*EV);
ev_maintenace1              =  (exp((-c + beta*EV -zmax)));
ev_replacement1             =  (exp((-tr - c(1,1) + beta*EV(1,1) -zmax)));%.*(1 - p_choice);  -zmax
EV_cost                     = log(ev_maintenace1 + ev_replacement1);
EV_new                      = [(EV_cost.*p_choice)'* trans_mat]' + [(EV_cost.*(1 - p_choice))'* trans_mat]';

end