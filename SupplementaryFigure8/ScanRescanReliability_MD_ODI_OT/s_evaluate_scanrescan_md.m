function s_evaluate_scanrescan_md

% This script aims to replicate top panels in Supplementaly Figure 8 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2024) Evaluating the impact of
% denoising in diffusion MRI-based tractometry of visual white matter
% tracts in glaucoma patients.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

%% Load left optic tract data and compute averages
load ../../Data/TractProfile/OT/LOT_TractProfile.mat
session1_mdMPPCA_lh = 1000*mean(all_profile.md1_MPPCA(11:90,:),1);
session2_mdMPPCA_lh = 1000*mean(all_profile.md2_MPPCA(11:90,:),1);
session1_mdwo_lh = 1000*mean(all_profile.md1_wo(11:90,:),1);
session2_mdwo_lh = 1000*mean(all_profile.md2_wo(11:90,:),1);
session1_mdP2S_lh = 1000*mean(all_profile.md1_P2S(11:90,:),1);
session2_mdP2S_lh = 1000*mean(all_profile.md2_P2S(11:90,:),1);
clear all_profile TractProfile

%% Load right optic tract data, compute combined averages
load ../../Data/TractProfile/OT/ROT_TractProfile.mat
session1_mdMPPCA_rh = 1000*mean(all_profile.md1_MPPCA(11:90,:),1);
session2_mdMPPCA_rh = 1000*mean(all_profile.md2_MPPCA(11:90,:),1);
session1_mdwo_rh = 1000*mean(all_profile.md1_wo(11:90,:),1);
session2_mdwo_rh = 1000*mean(all_profile.md2_wo(11:90,:),1);
session1_mdP2S_rh = 1000*mean(all_profile.md1_P2S(11:90,:),1);
session2_mdP2S_rh = 1000*mean(all_profile.md2_P2S(11:90,:),1);

%% Average left and right hemisphere values
session1_mdMPPCA_avg = (session1_mdMPPCA_lh + session1_mdMPPCA_rh)./2;
session2_mdMPPCA_avg = (session2_mdMPPCA_lh + session2_mdMPPCA_rh)./2;
session1_mdwo_avg = (session1_mdwo_lh + session1_mdwo_rh)./2;
session2_mdwo_avg = (session2_mdwo_lh + session2_mdwo_rh)./2;
session1_mdP2S_avg = (session1_mdP2S_lh + session1_mdP2S_rh)./2;
session2_mdP2S_avg = (session2_mdP2S_lh + session2_mdP2S_rh)./2;

%% Plot scan-rescan scatter plots
figure('Position', [100, 100, 1300, 400]);
tiledlayout(1, 3)

%% without denoising
nexttile(1)
scatter(session1_mdwo_avg(1:30), session2_mdwo_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_mdwo_avg(31:47), session2_mdwo_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
% Plot x=y line
plot([0.6 1.2], [0.6 1.2], '--k', 'LineWidth', 1.5);
% Fit and plot linear regression line
lm = fitlm(session1_mdwo_avg, session2_mdwo_avg);
xFit = linspace(min(session1_mdwo_avg), max(session1_mdwo_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_wo = corr(transpose(session1_mdwo_avg), transpose(session2_mdwo_avg));
r_corr_eff_wo = round(corr_eff_wo, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.6 1.2], 'ytick', [0.6 0.9 1.2], ...
    'xlim', [0.6 1.2], 'xtick', [0.6 0.9 1.2], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_wo)];
M = 1.2;
m = 0.6;
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

%% MPPCA
nexttile(2)
scatter(session1_mdMPPCA_avg(1:30), session2_mdMPPCA_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_mdMPPCA_avg(31:47), session2_mdMPPCA_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
% Plot x=y line
plot([0.6 1.2], [0.6 1.2], '--k', 'LineWidth', 1.5);
% Fit and plot linear regression line
lm = fitlm(session1_mdMPPCA_avg, session2_mdMPPCA_avg);
xFit = linspace(min(session1_mdMPPCA_avg), max(session1_mdMPPCA_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_MPPCA = corr(transpose(session1_mdMPPCA_avg), transpose(session2_mdMPPCA_avg));
r_corr_eff_MPPCA = round(corr_eff_MPPCA, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.6 1.2], 'ytick', [0.6 0.9 1.2], ...
    'xlim', [0.6 1.2], 'xtick', [0.6 0.9 1.2], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_MPPCA)];
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

%% P2S
nexttile(3)
scatter(session1_mdP2S_avg(1:30), session2_mdP2S_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_mdP2S_avg(31:47), session2_mdP2S_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
% Plot x=y line
plot([0.6 1.2], [0.6 1.2], '--k', 'LineWidth', 1.5);
% Fit and plot linear regression line
lm = fitlm(session1_mdP2S_avg, session2_mdP2S_avg);
xFit = linspace(min(session1_mdP2S_avg), max(session1_mdP2S_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_P2S = corr(transpose(session1_mdP2S_avg), transpose(session2_mdP2S_avg));
r_corr_eff_P2S = round(corr_eff_P2S, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.6 1.2], 'ytick', [0.6 0.9 1.2], ...
    'xlim', [0.6 1.2], 'xtick', [0.6 0.9 1.2], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_P2S)];
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

print(gcf, 'scanrescan_md.eps', '-depsc', '-painters');
end