function s_graph_RicianLL_NODDI

% This script aims to replicate a panel in Figure 5 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2024) Evaluating the impact of
% denoising in diffusion MRI-based tractometry of visual white matter
% tracts in glaucoma patients.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

% Add path to violin plot script
addpath('../../ExternalTools/Violinplot-Matlab-master');

%% Load left optic tract data and compute averages
load ../../Data/FittingAcuracy/OT/LOT_RicianLL_NODDI.mat
x = (all_RicianLL.RicianLL1_wo + all_RicianLL.RicianLL2_wo) / 2; % Without denoising
y = (all_RicianLL.RicianLL1_MPPCA + all_RicianLL.RicianLL2_MPPCA) / 2; % With MPPCA
z = (all_RicianLL.RicianLL1_P2S + all_RicianLL.RicianLL2_P2S) / 2; % With P2S

%% Load right optic tract data and compute combined averages
load ../../Data/FittingAcuracy/OT/ROT_RicianLL_NODDI.mat
x = (x + (all_RicianLL.RicianLL1_wo + all_RicianLL.RicianLL2_wo) / 2) / 2;
y = (y + (all_RicianLL.RicianLL1_MPPCA + all_RicianLL.RicianLL2_MPPCA) / 2) / 2;
z = (z + (all_RicianLL.RicianLL1_P2S + all_RicianLL.RicianLL2_P2S) / 2) / 2;

%% Statistical comparisons
% Compare without denoising vs MPPCA
d_MPPCA = computeCohen_d(x, y, 'paired');
[bf10_MPPCA, pValue_MPPCA] = bf.ttest(x, y, 'tail', 'both');
[h, p, ci, stats_MPPCA] = ttest(x, y, 'Tail', 'both');
d_MPPCA, bf10_MPPCA, pValue_MPPCA, stats_MPPCA

% Compare without denoising vs P2S
d_P2S = computeCohen_d(x, z, 'paired');
[bf10_P2S, pValue_P2S] = bf.ttest(x, z, 'tail', 'both');
[h, p, ci, stats_P2S] = ttest(x, z, 'Tail', 'both');
d_P2S, bf10_P2S, pValue_P2S, stats_P2S

% Compare MPPCA vs P2S
d = computeCohen_d(y, z, 'paired');
[bf10, pValue] = bf.ttest(y, z, 'tail', 'both');
[h, p, ci, stats] = ttest(y, z, 'Tail', 'both');
d, bf10, pValue, stats

%% Plot Rician log-likelihood comparison
figure('Position', [100, 100, 1100, 600]);
pbaspect([1 1.618 1]);
xlim([0.5 3.5]); ylim([-480 -380]);
ylabel('Rician log-likelihood', 'fontsize', 16);
set(gca, 'xtick', 1:3, 'xticklabel', {'Without Denoising', 'With MPPCA', 'With P2S'}, ...
    'ytick', [-480 -460 -440 -420 -400 -380], 'fontsize', 15);
yline(0, 'Color', [0.5 0.5 0.5], 'LineWidth', 1);
hold on

% Violin plots for each method
Violin({x}, 1, 'ViolinColor', {[1 0.84 0.2]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({y}, 2, 'ViolinColor', {[0.92 0.6 0.7]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2); 
Violin({z}, 3, 'ViolinColor', {[0.66 0.2 0.55]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);

% Plot individual values
for i = 1:30
    plot([1:3], [x(i), y(i), z(i)], '-square', 'Color', '#669CCC');
end
for i = 31:47
    plot([1:3], [x(i), y(i), z(i)], '-o', 'Color', '#C7233B');
end

h = findobj(gca, 'Type', 'Line');
for i = 1:length(h)
    if isequal(h(i).Color, [0.5 0.5 0.5])
        set(h(i), 'Visible', 'off');
    end
end
box on;
print(gcf, 'RicianLL_NODDI_OT.eps', '-depsc', '-painters');
hold off;

end
