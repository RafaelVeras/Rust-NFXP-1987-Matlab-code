%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================

function [loglikeli] = loglikeli(params)

%% Settings
beta            = 0.9999;
threshold       = 1e-12;  

disp(['Parameters: ' newline 'RC =' num2str(params(1)) ' e beta =' num2str(params(2))]);
%[params(1)  params(2)]

disp(['beta = ' num2str(beta)]);
disp(['threshold = ' num2str(threshold)]);

%% Estimation
[loglikeli, ~, ~] = estimation(params,beta, threshold);

disp('Generated new likelihood for the selected parameters');

 end