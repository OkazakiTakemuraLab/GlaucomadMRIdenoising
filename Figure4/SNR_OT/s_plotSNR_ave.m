function s_plotSNR_ave

% This script aims to replicate a panel B of Figure 4 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2024) Evaluating the impact of
% denoising in diffusion MRI-based tractometry of visual white matter
% tracts in glaucoma patients.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

% Add path to external tools
addpath(genpath('../../ExternalTools'));

%% Load left optic tract SNR data and compute averages
load ../../Data/EstimatedSNR/OT/LOT_EstimatedSNR.mat
x = (all_SNR.SNR1_wo + all_SNR.SNR2_wo)/2;
y = (all_SNR.SNR1_MPPCA + all_SNR.SNR2_MPPCA)/2;
%% Load right optic tract data, compute combined averages
load ../../Data/EstimatedSNR/OT/ROT_EstimatedSNR.mat
x = (x + (all_SNR.SNR1_wo + all_SNR.SNR2_wo)/2 )/2;
y = (y + (all_SNR.SNR1_MPPCA + all_SNR.SNR2_MPPCA)/2 )/2;
% Perform statistical tests
[h, p, ci, stats]=ttest(x, y,'Tail','both');
d = computeCohen_d(x,y, 'paired');
[bf10,pValue] = bf.ttest(x,y,'tail','both');
d, p, stats, bf10

%% Plot SNR comparison
figure('Position', [100, 100, 1100, 600]);
xlim([0.5 2.5]);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0 40], 'ytick', [0 10 20 30 40], 'fontsize',15);
pbaspect([1 1.618 1])
ylabel('SNR (low b-value)','fontsize',16);
hold on
set(gca, 'xtick', 1:2, 'xticklabel', {'Without Denoising', 'With MPPCA'});
% Violin plots
Violin({x}, 1, 'ViolinColor', {[1 0.84 0.2]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({y}, 2, 'ViolinColor', {[0.92 0.6 0.7]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
% Plot individual SNR
for i = 1:30
    plot([1, 2], [x(i), y(i)], '-square','Color','#669CCC');
end
for i = 31:47
    plot([1, 2], [x(i), y(i)], '-o','Color','#C7233B');
end

h = findobj(gca, 'Type', 'Line');
for i = 1:length(h)
    if isequal(h(i).Color, [0.5 0.5 0.5])
        set(h(i), 'Visible', 'off');
    end
end
box on;
print(gcf, 'EstimatedSNR_OT.eps', '-depsc', '-painters');
hold off;

end