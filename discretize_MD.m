    function [dt] =   discretize_MD(dt , max_odometer, n_fxp)

            ov1 = dt(:,6); % odometer at replacement
            ov2 = dt(:,9); % odometer at replacement
            n_bus  = size(dt,1); 
            n_col   = size(dt,2);

 %% dtc
%   - Choice ( 1 or 0 ) 
 % It is the choice (1 or 0) - 1 if the bus engine was replaced in month t when the bus's state was x(t), and 0 otherwise

    dtc = [];
    for ii=1:size(dt(:,12:n_col),1)
    dtc = [dtc;(ov1(ii)>0)&(dt(ii,12:n_col)>=ov1(ii)) + (ov2(ii)>0)&(dt(ii,12:n_col)>=ov2(ii))] ;
    end

            
    %% mil    
    % -  It is the monthly mileage variable mil=[x(t)-x(t-1)]
    % giving the change in the bus odometer reading during month t
       
     mil = dt(:,13:n_col) - dt(:,12:n_col-1);

  %% "minimum, maximum, mean monthly mileage";;
   %   'The minimum change in the bus odometer reading between months per bus:'
    [dt(:,1) min(mil')']
    
   % 'The maximum change in the bus odometer reading between months per bus'
    [dt(:,1) max(mil')']
    
   % 'The mean change in the bus odometer reading between months per bus'
    [dt(:,1) mean(mil')']

    
%% discretizing data  

disp("begin discretizing data ... ");   
 


%% dtx (save the discretized state of bus) 

% It  is the state variable x(t) which specifies a mileage range which contains 
% the bus's true odometer reading during month t


%         dtx =   dt[12:n_bus,.] + ...
%                 ov1.*dtc.*(dtc-2)
%                 -.5*ov2.*dtc.*(dtc-1);
%         

         dtx = dt(:,12:n_col) + ...
               ov1.*dtc.*(dtc-2) - ...
                -.5*ov2.*dtc.*(dtc-1);               
%    

% n_fxp = dimension of fixed point dimension `n'
%n_fxp                = 90;

% max_odometer
%max_odometer  = 450000;

% implied size of discrete mileage range
range_discrete_mileage = max_odometer/n_fxp; 

% dtx guarda o estado discretizado (de 1:90)
dtx = ceil(dtx*(n_fxp/max_odometer));
%dtx = floor(dtx*(n_fxp/max_odometer));

%         
%         
%         dtc = (dtc[2:n_bus-11,.]-dtc[1:n_bus-12,.])|zeros(1,m);

% Cria variável de escolha
dtc = [ ...
        (dtc(:,2:n_col-11) - ...
        dtc(:,1:n_col-12)) ...
        zeros(1,n_bus)'
        ];

%         
%         
%         mil = (dtx[2:n_bus-11,.]-dtx[1:n_bus-12,.])+  dtx[1:n_bus-12,.].*dtc[1:n_bus-12,.];
 
% Milhagem por mês (discretizada)
mil =  [ (dtx(:,2:n_col-11) - dtx(:,1:n_col-12)) + dtx(:,1:n_col-12).*dtc(:,1:n_col-12)  zeros(size(dtx,1),1)];

% Empilhando os dados dos onibus em uma só coluna 
dt= [reshape(dtc,[],1) reshape(dtx,[],1) reshape(mil,[],1)];



    end
    