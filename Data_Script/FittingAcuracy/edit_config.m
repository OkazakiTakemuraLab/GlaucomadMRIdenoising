function edit_config

load rmse_ROR.mat rmse_ROR

all_RMSE.RMSE1_wo = rmse_ROR(:, 1)';
all_RMSE.RMSE2_wo = rmse_ROR(:, 2)';
all_RMSE.RMSE1_MPPCA = rmse_ROR(:, 3)';
all_RMSE.RMSE2_MPPCA = rmse_ROR(:, 4)';
all_RMSE.RMSE1_P2S = rmse_ROR(:, 5)';
all_RMSE.RMSE2_P2S = rmse_ROR(:, 6)';

save('ROR_RMSE_DTI.mat', 'all_RMSE');

end

