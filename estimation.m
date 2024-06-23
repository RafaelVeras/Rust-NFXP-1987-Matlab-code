%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================

function [loglikeli, fixed_point, pchoice, p_mileage, beta] = estimation(params,beta, threshold)

% 1)Outer loop: search over diferent parameter values theta_hat.

% 2)Inner loop: For theta_hat, we need to compute the value function V(x; theta_hat). 
%After V (x; theta_hat) is obtained, we can compute the log-likelihood. 


%% Settings
n_params  =1;
 

%% Data

dados = load('dataframe\dados_estimacao_1_2_3_8.mat');


%% Change state probability (discretized in three)
theta31 = size(find(dados.dt(:,3)==0),1) /size(dados.dt(:,3),1);
theta32 = size(find(dados.dt(:,3)==1),1) /size(dados.dt(:,3),1);
theta33 = size(find(dados.dt(:,3)==2),1) /size(dados.dt(:,3),1);

p_mileage =   [theta31 theta32 theta33];


%% auxiliaries matrices 

[state_mat, trans_mat , regen_mat, dec_mat , n_max_lines_state, ~]   = aux_estimation(dados, p_mileage,  n_params);


%% Contraction mapping

disp('Generating the fixed point in contraction mapping')

vf_myopic                      = [cost_function(n_max_lines_state, params(2)) repmat(params(1),n_max_lines_state,1)];
[fixed_point , pchoice, ~]     = contraction_mapping(vf_myopic,beta, trans_mat, regen_mat,n_max_lines_state,threshold );

%% Likelihood

         logprob_rc      =( (1-pchoice)'* state_mat') ;         
         loglikeli_rc    =  -sum(  log(  logprob_rc' + (1-2*logprob_rc').*dec_mat(:,1)  )  )  ;...
         loglikeli       = loglikeli_rc;
     
 end