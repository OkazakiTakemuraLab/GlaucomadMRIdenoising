function s_graph_RMSE_DTI

% This script aims to replicate a panel A of Figure 5 in the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2025) Evaluating the impact of denoising diffusion MRI data
% on tractometry metrics of optic tract abnormalities in glaucoma. Scientific Reports, 15, 25812.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

% Add path to violin plot script
addpath('../../ExternalTools');

%% Load RMSE data for left optic tract and compute averages
load ../../Data/FittingAcuracy/OT/LOT_RMSE_DTI.mat
x = (all_RMSE.RMSE1_wo + all_RMSE.RMSE2_wo)/2;
y = (all_RMSE.RMSE1_MPPCA + all_RMSE.RMSE2_MPPCA)/2;
z = (all_RMSE.RMSE1_P2S + all_RMSE.RMSE2_P2S)/2;
%% Load right optic tract data and compute combined averages
load ../../Data/FittingAcuracy/OT/ROT_RMSE_DTI.mat
x = (x + (all_RMSE.RMSE1_wo + all_RMSE.RMSE2_wo)/2 )/2;
y = (y + (all_RMSE.RMSE1_MPPCA + all_RMSE.RMSE2_MPPCA)/2 )/2;
z = (z + (all_RMSE.RMSE1_P2S + all_RMSE.RMSE2_P2S)/2 )/2;

%% Statistical comparisons
% Compare without denoising vs MPPCA
d_MPPCA = computeCohen_d(x,y, 'paired');
[bf10_MPPCA,pValue_MPPCA] = bf.ttest(x,y,'tail','both');
[h, p, ci, stats_MPPCA]=ttest(x, y,'Tail','both');
d_MPPCA
bf10_MPPCA
pValue_MPPCA
stats_MPPCA
% Compare without denoising vs P2S
d_P2S = computeCohen_d(x, z, 'paired');
[bf10_P2S,pValue_P2S] = bf.ttest(x, z, 'tail', 'both');
[h, p, ci, stats_P2S]=ttest(x, z,'Tail','both');
d_P2S
bf10_P2S
pValue_P2S
stats_P2S
% Compare MPPCA vs P2S
d = computeCohen_d(y, z, 'paired');
[bf10,pValue] = bf.ttest(y, z, 'tail', 'both');
[h, p, ci, stats]=ttest(y, z,'Tail','both');
d
bf10
pValue
stats

%% Plot RMSE comparison
figure('Position', [100, 100, 1100, 600]);
pbaspect([1 1.618 1]);
xlim([0.5 3.5]);
ylim([12 28]);
ylabel('RMSE', 'fontsize', 16);
hold on
set(gca, 'xtick', 1:3, 'xticklabel', {'Without Denoising', 'With MPPCA', 'With P2S'}, ...
    'ytick', [12 16 20 24 28], 'fontsize',15);
yline(0, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
hold on
% Violin plots for each method
Violin({x}, 1, 'ViolinColor', {[1 0.84 0.2]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({y}, 2, 'ViolinColor', {[0.92 0.6 0.7]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2); 
Violin({z}, 3, 'ViolinColor', {[0.66 0.2 0.55]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);

% Plot individual RMSE
for i = 1:30
    plot([1:3], [x(i), y(i), z(i)], '-square','Color','#669CCC');
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
print(gcf, 'RMSE_DTI_OT.eps', '-depsc', '-painters');
hold off;

end
