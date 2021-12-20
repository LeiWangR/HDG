function [ magnitude ] = computegradientmagnitude( dx, dy, dt )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

% calculate the gradient magnitude
for kk=1:size(dx, 3)
    for ll=1:size(dx, 1)
        for mm=1:size(dx, 2)
            % save gradient magnitude for one action
            magnitude(ll, mm, kk)=norm([dx(ll, mm, kk), dy(ll, mm, kk), dt(ll, mm, kk)]);
        end
    end
end

end

