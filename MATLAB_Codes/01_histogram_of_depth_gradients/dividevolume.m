function [ Subvolume, D1result, D2result, D3result ] = dividevolume( depth, p, q, t )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% size of the depth video
P=size(depth, 1);
Q=size(depth, 2);
T=size(depth, 3);

delta_p=ceil(P/p);
delta_q=ceil(Q/q);
delta_t=ceil(T/t);

if(mod(P, p)~=0)
    D1=ones(1, p-1)*delta_p;
    D1result=[D1, P-delta_p*(p-1)];
else
    D1result=ones(1, p)*delta_p;
end

if(mod(Q, q)~=0)
    D2=ones(1, q-1)*delta_q;
    D2result=[D2, Q-delta_q*(q-1)];
else
    D2result=ones(1, q)*delta_q;
end

if(mod(T, t)~=0)
    D3=ones(1, t-1)*delta_t;
    D3result=[D3, T-delta_t*(t-1)];
else
    D3result=ones(1, t)*delta_t;
end

Subvolume=mat2cell(depth, D1result, D2result, D3result);

end

