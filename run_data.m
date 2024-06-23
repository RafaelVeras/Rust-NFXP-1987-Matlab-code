
%% Data reading 

% STORDAT.GPR: creates bus data file BDT.DAT for use by NFXP.GPR
% Version 8, October, 2000. By John Rust, Yale University
% 
% This program prepares bus data from the Madison Metro Bus Co
% for estimation using the nested fixed point algorithm. 
% 
% The program reads the raw bus data files (*.FMT) producing an output file BDT.DAT
% with fixed point dimension `n' selected by the user. 

% BDT.DAT consists of either 3 or 4 columns of binary data, depending on the options
% chosen below. 

% 1) --> The first column, dtc, is the dependent variable i(t) which equals 1 if 
% the bus engine was replaced in month t when the bus's state was x(t), and 0 otherwise. 

% 2) --> The second column, dtx, is the state variable x(t) which specifies a 
% mileage range which contains the bus's true odometer reading during month t. 

% 3) --> The third column, mil, is the monthly mileage variable mil=[x(t)-x(t-1)] giving the change
% in the bus odometer reading during month t. 

% You also have the option to include the lagged dependent variable i(t-1) in the data set. 
% This allows you to conduct a specification test of the assumption that un-
% observed state variables are serially independent given {x(t)}. 


%% Settings
max_odometer         =  450000;  % implied size of discrete mileage range;
n_fxp                = 90;          % n_fxp = dimension of fixed point dimension `n';
sel_grupos           = [ 1 2 3 8];
dt                   = [];

%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================


%% Data 

    for i=1:length(sel_grupos)

        switch sel_grupos(i)

            case  1
            disp(" ");              
            disp("Grupo selecionado:");    
            disp("Bus group 1: 1983 Grumman model 870 buses (15 buses total)");       
            disp(" "); 
            dt_temp = load('dat\g870.asc');
            dt_temp = reshape(dt_temp,[size(dt_temp,1)/15],15)';
            dt = [dt ;discretize_MD(dt_temp, max_odometer, n_fxp)];       

            case  2
            disp(" ");              
            disp("Grupo selecionado:");    
            disp("Bus group 2: 1981 Chance RT-50 buses (4 buses total)");       
            disp(" ");             
            dt_temp = load('dat\rt50.asc');
            dt_temp = reshape(dt_temp,[size(dt_temp,1)/4],4)';
             dt = [dt ;discretize_MD(dt_temp, max_odometer, n_fxp)];        

            case  3 
            disp(" ");              
            disp("Grupo selecionado:");    
            disp("Bus group 3: 1979 GMC model t8h203 buses (48 buses total)");       
            disp(" "); 
            dt_temp = load('dat\t8h203.asc');
            dt_temp = reshape(dt_temp,[size(dt_temp,1)/48],48)';   
            dt = [dt ;discretize_MD(dt_temp, max_odometer, n_fxp)];   
            
            case  4  
            disp(" ");              
            disp("Grupo selecionado:");    
            disp("Bus group 6: 1972 GMC model a4523 buses (18 buses total))");  
            disp(" ");  
            dt_temp = load('dat\a452372.asc');
            dt_temp = reshape(dt_temp,[size(dt_temp,1)/18],18)';        
            dt = [dt ;discretize_MD(dt_temp, max_odometer, n_fxp)];              
  
            case  5
            disp(" ");              
            disp("Grupo selecionado:");    
            disp("Bus group 7: 1974 GMC model a4523 buses (10 buses total)");  
            disp(" "); 
            dt_temp = load('dat\a452374.asc');
            dt_temp = reshape(dt_temp,[size(dt_temp,1)/10],10)';      
            dt = [dt ;discretize_MD(dt_temp, max_odometer, n_fxp)];             
            
            case  6
            disp(" ");              
            disp("Grupo selecionado:");    
            disp("Bus group 5: 1972 GMC model a5308 buses (18 buses total)");  
            disp(" ");  
            dt_temp = load('dat\a530872.asc');
            dt_temp = reshape(dt_temp,[size(dt_temp,1)/18],18)';     
            dt = [dt ;discretize_MD(dt_temp, max_odometer, n_fxp)];  
            
            case  7
            disp(" ");              
            disp("Grupo selecionado:");    
            disp("Bus group 8: 1974 GMC model a5308 buses (12 buses total)");  
            disp(" ");     
            dt_temp = load('dat\a530874.asc');
            dt_temp = reshape(dt_temp,[size(dt_temp,1)/12],12)';
            dt = [dt ;discretize_MD(dt_temp, max_odometer, n_fxp)]; 
            
            case  8
            disp(" ");              
            disp("Grupo selecionado:");    
            disp("Bus group 4: 1975 GMC model a5308 buses (37 buses total)");  
            disp(" ");   
            dt_temp = load('dat\a530875.asc');
            dt_temp = reshape(dt_temp,[size(dt_temp,1)/37],37)';
            dt = [dt ;discretize_MD(dt_temp, max_odometer, n_fxp)];      
            
             
        end

    end

    
%% Save 
    if  isfolder('dataframe')
save('dataframe\dados_estimacao_1_2_3_8', 'dt');
    end