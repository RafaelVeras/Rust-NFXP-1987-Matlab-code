%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================


function [fixed_point , p_choice_new, value_function] = contraction_mapping(vf_myopic,beta,trans_mat, regen_mat,n_max_lines_state,threshold )

c  = vf_myopic(:,1);
%tr = vf_myopic(:,2);

EV      = zeros(n_max_lines_state, 1); %Common way is to start with EV (x; i) = 0
EV_new  = fx_point(EV, vf_myopic,trans_mat, regen_mat, beta);  

r           = 0;
achieved    = true;

%% Iterations for find fixed_point
disp('begin contraction iterations');
while (max(abs(EV_new - EV )) > threshold) 
EV          =  EV_new;   
EV_new      = fx_point(EV_new, vf_myopic,trans_mat, regen_mat, beta);    
r = r+1;
    if r == 10000
        achieved = false;
        break
    end
end

fixed_point    = EV_new;
value_function =  -c + EV_new;

    if achieved
        disp( ['Fixed point was achieved. Convergence achieved in ' num2str(r)  ' iterations'])
    else
        disp( ['Contraction mapping could not converge! Mean difference ='  num2str(mean(EV_new-EV)) ]);
    end

p_choice_new        = choice_prob(-c +beta*fixed_point, vf_myopic,beta);

end

