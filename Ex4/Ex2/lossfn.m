function [ lossval ] = lossfn(trueim, restoredim )
lossval = (numel(find(trueim ~= restoredim)));
fprintf('Error percentage = %f \n', (lossval/numel(trueim)) * 100);
lossval = lossval/ numel(trueim);
end