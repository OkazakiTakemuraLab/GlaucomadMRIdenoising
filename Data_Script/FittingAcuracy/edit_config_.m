function edit_config

load ROR_fit_AP.mat fit_AP
load ROR_fit_PA.mat fit_PA

all_RicianLL.RicianLL1_wo = fit_AP(:, 1)';
all_RicianLL.RicianLL2_wo = fit_PA(:, 1)';
all_RicianLL.RicianLL1_MPPCA = fit_AP(:, 2)';
all_RicianLL.RicianLL2_MPPCA = fit_PA(:, 2)';
all_RicianLL.RicianLL1_P2S = fit_AP(:, 3)';
all_RicianLL.RicianLL2_P2S = fit_PA(:, 3)';

save('ROR_RicianLL_NODDI.mat', 'all_RicianLL');

end

