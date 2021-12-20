function [ output_args ] = plotgrid( ax )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

xvec=ax(1):1:ax(2);
yvec=ax(3):1:ax(4);

for ii=2:length(xvec)-1
    plot([xvec(ii), xvec(ii)], [ax(3), ax(4)], ':k');
end
for jj=2:length(yvec)-1
    plot([ax(1), ax(2)], [yvec(jj), yvec(jj)], ':k');
end
end

