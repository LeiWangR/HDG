function [ jointmotionV ] = computejointsubvolumehist( jointsubvolume, nnx, nny, nnd, njointb, drangemax, drangemin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
jointmotionV=[];
for ii=1:nnx
    for jj=1:nny
        for kk=1:nnd
            dV=jointsubvolume{ii, jj, kk};
            if(isempty(dV) || (drangemax-drangemin==0))
                N=zeros(1, njointb);
            else
                [N, edges]=histcounts(dV(:), drangemin:(drangemax-drangemin)/njointb:drangemax);
            end
            jointmotionV=[jointmotionV, N];
        end
    end
end

end

