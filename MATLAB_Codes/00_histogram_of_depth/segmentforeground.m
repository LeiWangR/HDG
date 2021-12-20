function [ resultmin, resultmax ] = segmentforeground( image )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
mask=false(size(image));
rowsize=size(image, 1);
colsize=size(image, 2);
mask(1:rowsize, 1:colsize)=true;
% visboundaries(mask, 'color', 'b');

bw=activecontour(image, mask, 100, 'Chan-Vese');
% visboundaries(bw, 'color', 'r');

% imshow(bw)
% scan left side
leftrow=[];
leftcol=[];
for ii=1:rowsize
    for jj=1:colsize
        if(bw(ii, jj)==1)
            leftrow=[leftrow, ii];
            leftcol=[leftcol, jj];
            break;
        end
    end
end
% scan right side
rightrow=[];
rightcol=[];
for kk=1:rowsize
    for ll=colsize:-1:1
        if(bw(kk, ll)==1)
            rightrow=[rightrow, kk];
            rightcol=[rightcol, ll];
            break;
        end
    end
end
row=[leftrow, rightrow];
col=[leftcol, rightcol];
maxrow=max(row);
minrow=min(row);
maxcol=max(col);
mincol=min(col);

resultmin=[minrow, mincol];
resultmax=[maxrow, maxcol];
end

