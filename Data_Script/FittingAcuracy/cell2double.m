function cell2double


data = load('ROR_RMSE_DTI.mat');


structVar = data.all_RMSE;

fieldNames = fieldnames(structVar);

for i = 1:numel(fieldNames)
    fieldName = fieldNames{i};
    cellArray = structVar.(fieldName);
    numericArray = cellfun(@double, cellArray);
    structVar.(fieldName) = numericArray;
    all_RMSE.(fieldName) = numericArray;
end

save('newfile.mat', 'all_RMSE');


end

