function s_plotSNR_ave

% This script aims to replicate panel B in Supplementaly Figure 2 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2025) Evaluating the impact of denoising diffusion MRI data
% on tractometry metrics of optic tract abnormalities in glaucoma. Scientific Reports, 15, 25812.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

% Add path to violin plot script
addpath(genpath('../../ExternalTools'));

%% Load left optic radiation SNR data and compute averages
load ../../Data/EstimatedSNR/OR/LOR_EstimatedSNR.mat
x = (all_SNR.SNR1_wo + all_SNR.SNR2_wo)/2;
y = (all_SNR.SNR1_MPPCA + all_SNR.SNR2_MPPCA)/2;
%% Load right optic radiation data, compute combined averages
load ../../Data/EstimatedSNR/OR/ROR_EstimatedSNR.mat
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
    'ylim', [0 60], 'ytick', [0 20 40 60], 'fontsize',15);
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
print(gcf, 'EstimatedSNR_OR.eps', '-depsc', '-painters');
hold off;

end
