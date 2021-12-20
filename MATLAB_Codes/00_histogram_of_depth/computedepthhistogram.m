function [ depthhistogram ] = computedepthhistogram( subvolume, p, q, t, delta_d, subvolumesize, nd, hismax, hismin )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
% define depth histogram for the whole video sequence
depthhistogram=[];

for ii=1:p
    for jj=1:q
        for kk=1:t
            deltaV=subvolume{ii, jj, kk};
            if(isempty(deltaV))
                subhistogram=zeros(1, nd);
            else
                depthvalue=computequantizeddepth(deltaV, delta_d);
                [N, edges]=histcounts(depthvalue(:),hismin:1:hismax);
                % normalize the histogram by the subvolume size
                subhistogram=N/subvolumesize;
            end
            % concatenate the depth histogram vectors for each subvolume
            depthhistogram=[depthhistogram, subhistogram];
        end
    end
end

end

