%=============================================================
%   Author: Rafael Veras <rafaelmanoelveras@gmail.com>
%   Created at 06/23/2024
%=============================================================

function [cmf] = cost_function(s, theta)
cmf = 0.001*(1:s)'*theta;
end