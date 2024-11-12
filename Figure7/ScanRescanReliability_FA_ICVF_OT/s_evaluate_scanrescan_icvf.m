function s_evaluate_scanrescan_icvf

% This script aims to replicate a panel in Figure 7 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2024) Evaluating the impact of
% denoising in diffusion MRI-based tractometry of visual white matter
% tracts in glaucoma patients.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

%% Load left optic tract data and compute averages
load ../../Data/TractProfile/OT/LOT_TractProfile.mat
session1_icvfMPPCA_lh = mean(all_profile.icvf_1_MPPCA(11:90,:),1);
session2_icvfMPPCA_lh = mean(all_profile.icvf_2_MPPCA(11:90,:),1);
session1_icvfP2S_lh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_lh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_lh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_lh = mean(all_profile.icvf_2_wo(11:90,:),1);
clear all_profile TractProfile

%% Load right optic tract data and compute averages
load ../../Data/TractProfile/OT/ROT_TractProfile.mat
session1_icvfMPPCA_rh = mean(all_profile.icvf_1_MPPCA(11:90,:),1);
session2_icvfMPPCA_rh = mean(all_profile.icvf_2_MPPCA(11:90,:),1);
session1_icvfP2S_rh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_rh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_rh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_rh = mean(all_profile.icvf_2_wo(11:90,:),1);

%% Average left and right hemisphere values
session1_icvfMPPCA_avg = (session1_icvfMPPCA_lh + session1_icvfMPPCA_rh)./2;
session2_icvfMPPCA_avg = (session2_icvfMPPCA_lh + session2_icvfMPPCA_rh)./2;
session1_icvfP2S_avg = (session1_icvfP2S_lh + session1_icvfP2S_rh)./2;
session2_icvfP2S_avg = (session2_icvfP2S_lh + session2_icvfP2S_rh)./2;
session1_icvfwo_avg = (session1_icvfwo_lh + session1_icvfwo_rh)./2;
session2_icvfwo_avg = (session2_icvfwo_lh + session2_icvfwo_rh)./2;

%% Plot scan-rescan scatter plots
figure('Position', [100, 100, 1300, 400]);
tiledlayout(1, 3)

%% without denoising
nexttile(1)
scatter(session1_icvfwo_avg(1:30), session2_icvfwo_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_icvfwo_avg(31:47), session2_icvfwo_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
% Plot x=y line
plot([0.4 1.0], [0.4 1.0], '--k', 'LineWidth', 1.5);
% Fit and plot linear regression line
lm = fitlm(session1_icvfwo_avg, session2_icvfwo_avg);
xFit = linspace(min(session1_icvfwo_avg), max(session1_icvfwo_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_wo = corr(transpose(session1_icvfwo_avg), transpose(session2_icvfwo_avg));
r_corr_eff_wo = round(corr_eff_wo, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.4 1.0], 'ytick', [0.4 0.7 1.0], ...
    'xlim', [0.4 1.0], 'xtick', [0.4 0.7 1.0], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_wo)];
M = 1.0;
m = 0.4;
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

%% MPPCA
nexttile(2)
scatter(session1_icvfMPPCA_avg(1:30), session2_icvfMPPCA_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_icvfMPPCA_avg(31:47), session2_icvfMPPCA_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
plot([0.4 1.0], [0.4 1.0], '--k', 'LineWidth', 1.5);
lm = fitlm(session1_icvfMPPCA_avg, session2_icvfMPPCA_avg);
xFit = linspace(min(session1_icvfMPPCA_avg), max(session1_icvfMPPCA_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_MPPCA = corr(transpose(session1_icvfMPPCA_avg), transpose(session2_icvfMPPCA_avg));
r_corr_eff_MPPCA = round(corr_eff_MPPCA, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.4 1.0], 'ytick', [0.4 0.7 1.0], ...
    'xlim', [0.4 1.0], 'xtick', [0.4 0.7 1.0], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_MPPCA)];
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

%% P2S
nexttile(3)
scatter(session1_icvfP2S_avg(1:30), session2_icvfP2S_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_icvfP2S_avg(31:47), session2_icvfP2S_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
plot([0.4 1.0], [0.4 1.0], '--k', 'LineWidth', 1.5);
lm = fitlm(session1_icvfP2S_avg, session2_icvfP2S_avg);
xFit = linspace(min(session1_icvfP2S_avg), max(session1_icvfP2S_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_P2S = corr(transpose(session1_icvfP2S_avg), transpose(session2_icvfP2S_avg));
r_corr_eff_P2S = round(corr_eff_P2S, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.4 1.0], 'ytick', [0.4 0.7 1.0], ...
    'xlim', [0.4 1.0], 'xtick', [0.4 0.7 1.0], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_P2S)];
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

print(gcf, 'scanrescan_icvf.eps', '-depsc', '-painters');

end

