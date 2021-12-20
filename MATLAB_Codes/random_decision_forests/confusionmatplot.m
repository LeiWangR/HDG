function [ output_args ] = confusionmatplot( confusionmatrix, fontsize, labelaction)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
row=size(confusionmatrix);
column=size(confusionmatrix);
for ii=1:row
    sumrow=sum(confusionmatrix(ii, :));
    for jj=1:column
        confusionpercentage(ii, jj)=confusionmatrix(ii, jj)/sumrow;
    end
end
mat=confusionpercentage;
imagesc(mat);
xlabel 'output from algorithm';
ylabel 'ground truth';
colormap(flipud(gray));

textStrings=num2str(mat(:)*100, '%0.1f');
textStrings=strtrim(cellstr(textStrings));

[x, y]=meshgrid(1:row);
% remove all '0'
for ii=1:size(textStrings, 1)
    if(strcmp(textStrings{ii}, '0.0'))
        textStrings{ii}='';
    end
end
% for large confusion matrix, the fontsize should be smaller, such as 6
hStrings=text(x(:), y(:), textStrings(:), 'HorizontalAlignment', 'center',...
    'FontSize', fontsize);

midValue=mean(get(gca, 'Clim'));
textColors=repmat(mat(:)>midValue, 1, 3);

set(hStrings, {'Color'}, num2cell(textColors, 2));
set(gca, 'XTick', 1:row, ...
    'YTick', 1:row, ...
    'TickLength', [0, 0], 'XTickLabel', labelaction, 'YTickLabel', labelaction, ...
    'XTickLabelRotation', 45);

axis equal;
axis tight;
end

