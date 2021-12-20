function [ gradientfeature ] = gradienthistogram( dsubvolume, p, q, t, drange, nbin, dmax, dmin)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
gradientfeature=[];

for ii=1:p
    for jj=1:q
        for kk=1:t
            dV=dsubvolume{ii, jj, kk};
            if(isempty(dV))
                N=zeros(1, nbin);
            else
                [derivativevalue, stepsize]=computedepthderivative(dV, drange, nbin);
                [ hismax, hismin ] = hisextreme( dmax, dmin, stepsize );
                % concatenate the depth histogram vectors for each subvolume
                [N, xedges]=histcounts(derivativevalue(:), hismin:1:hismax);
            end
            gradientfeature=[gradientfeature, N];
        end
    end
end

end

