%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================


 function [state_mat, trans_mat , regen_mat , dec_mat , n_max_lines_state, mil_mat]= aux_estimation(dados, p_mileage,  n_params)

  % "trans_mat" is the transition matrix in page 16 of rust paper
 
 % make some checks and create matrix for use in others functions
      
%         A statistics workbench used to evaluate the cost parameters underlying 
%         a bus replacement pattern by a forward-looking agent.
     

        dt_choice = dados.dt(:,1);  % the choice
        dt_state  = dados.dt(:,2);  % the state of the bus     

        n_lines_choice = size(dt_choice,1);
        n_lines_state= size(dt_state,1);
        n_max_lines_state = 90;          

        
   %% Checks   
        
   % Check that p is a correct vector of probabilities (i.e. sums to 1)
        if sum(p_mileage) - 1 <0.0001
        else
            error( "The probability of state transitions should add up to 1!")
         end
 
    % Check that the stated number of parameters correspond to the specifications of the maintenance cost function.       
        try
        cost_function(1, zeros(n_params,1)');
        catch
        error("The number of parameters specified does not match the specification of the maintenance cost function!")
        end
 
      
%==============================================================================================
% Matrix indicating the state of each observation
%==============================================================================================        

% (SxN) matrix indicating the state of each observation 

%self.state_mat = np.array([[self.exog[i]==s for i in range(self.N)]  for s in range(self.S)])
    for n=1:n_lines_state
        for s=1:n_max_lines_state
            state_mat(n,s) = dt_state(n,1)==s;
        end
    end
    
  dt_mileage =  dados.dt(:,3);
   for n=1:n_lines_state
       for j=1:length(p_mileage)

           mil_mat(n,j) = dt_mileage(n,1)==j-1;

       end
   end
       
%==============================================================================================
% Matrix of the probability of a bus transitioning
%==============================================================================================
    
% A (SxS) matrix indicating the probability of a bus transitioning from a state s to a state s' 
% (used to compute maintenance utility)
% n_max_lines_state = 10;
        trans_mat = zeros(n_max_lines_state, n_max_lines_state);
        for i=1:n_max_lines_state
            for j=1:length(p_mileage)
                if i + j <= n_max_lines_state-1
                    trans_mat(i+j,i) = p_mileage(j);
                elseif i + j > n_max_lines_state-1
                    temp = i + j - (n_max_lines_state-1);
                    if temp >= 3
                    trans_mat(n_max_lines_state-1,i) = [sum(p_mileage(1:length(p_mileage)))];                        
                    else
                    trans_mat(n_max_lines_state-1,i) = [sum(p_mileage(length(p_mileage)-temp:length(p_mileage)))];
                    end
                end
            end
            %trans_mat = trans_mat';
        end
                    
%==============================================================================================
%% Matrix which regenerates the bus' state to 0
%==============================================================================================

%   A second (SxS) matrix which regenerates the bus' state to 0 with
%   certainty (used to compute the replacement utility)
%   self.regen_mat = np.vstack((np.ones((1, S)),np.zeros((S-1, S))))

%regen_mat = [ones(1, n_max_lines_state) ; zeros(n_max_lines_state-1, n_max_lines_state)]   ;

 regen_mat = [ones(1, n_max_lines_state) ; zeros(n_max_lines_state-1, n_max_lines_state)]   ;
        
 %==============================================================================================
% Matrix of decisions
%==============================================================================================
%         # A (2xN) matrix indicating with a dummy the decision taken by  the agent for each time/bus observation (replace or maintain)
%        self.dec_mat = np.vstack(((1-self.endog), self.endog))    
        
 dec_mat   = [(1- dt_choice) dt_choice ];        
        
end