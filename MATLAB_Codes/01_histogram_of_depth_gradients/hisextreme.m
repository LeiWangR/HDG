function [ hismax, hismin ] = hisextreme( dmax, dmin, stepsize )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
hismax=ceil(round((dmax/stepsize)*100)/100);
hismin=ceil(round((dmin/stepsize)*100)/100);

end

