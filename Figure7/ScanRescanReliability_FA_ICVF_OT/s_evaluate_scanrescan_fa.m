function s_evaluate_scanrescan_fa

% This script aims to replicate top panels in Figure 7 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2024) Evaluating the impact of
% denoising in diffusion MRI-based tractometry of visual white matter
% tracts in glaucoma patients.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

%% Load left optic tract data and compute averages
load ../../Data/TractProfile/OT/LOT_TractProfile.mat
session1_faMPPCA_lh = mean(all_profile.fa1_MPPCA(11:90,:),1);
session2_faMPPCA_lh = mean(all_profile.fa2_MPPCA(11:90,:),1);
session1_fawo_lh = mean(all_profile.fa1_wo(11:90,:),1);
session2_fawo_lh = mean(all_profile.fa2_wo(11:90,:),1);
session1_faP2S_lh = mean(all_profile.fa1_P2S(11:90,:),1);
session2_faP2S_lh = mean(all_profile.fa2_P2S(11:90,:),1);
clear all_profile TractProfile

%% Load right optic tract data and compute averages
load ../../Data/TractProfile/OT/ROT_TractProfile.mat
session1_faMPPCA_rh = mean(all_profile.fa1_MPPCA(11:90,:),1);
session2_faMPPCA_rh = mean(all_profile.fa2_MPPCA(11:90,:),1);
session1_fawo_rh = mean(all_profile.fa1_wo(11:90,:),1);
session2_fawo_rh = mean(all_profile.fa2_wo(11:90,:),1);
session1_faP2S_rh = mean(all_profile.fa1_P2S(11:90,:),1);
session2_faP2S_rh = mean(all_profile.fa2_P2S(11:90,:),1);

%% Average left and right hemisphere values
session1_faMPPCA_avg = (session1_faMPPCA_lh + session1_faMPPCA_rh)./2;
session2_faMPPCA_avg = (session2_faMPPCA_lh + session2_faMPPCA_rh)./2;
session1_fawo_avg = (session1_fawo_lh + session1_fawo_rh)./2;
session2_fawo_avg = (session2_fawo_lh + session2_fawo_rh)./2;
session1_faP2S_avg = (session1_faP2S_lh + session1_faP2S_rh)./2;
session2_faP2S_avg = (session2_faP2S_lh + session2_faP2S_rh)./2;

%% Plot scan-rescan scatter plots
figure('Position', [100, 100, 1300, 400]);
tiledlayout(1, 3)

%% without denoising
nexttile(1)
scatter(session1_fawo_avg(1:30), session2_fawo_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_fawo_avg(31:47), session2_fawo_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
% Plot x=y line
plot([0.2 0.6], [0.2 0.6], '--k', 'LineWidth', 1.5);
% Fit and plot linear regression line
lm = fitlm(session1_fawo_avg, session2_fawo_avg);
xFit = linspace(min(session1_fawo_avg), max(session1_fawo_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_wo = corr(transpose(session1_fawo_avg), transpose(session2_fawo_avg));
r_corr_eff_wo = round(corr_eff_wo, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.2 0.6], 'ytick', [0.2 0.4 0.6], ...
    'xlim', [0.2 0.6], 'xtick', [0.2 0.4 0.6], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_wo)];
M = 0.6;
m = 0.2;
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

%% MPPCA
nexttile(2)
scatter(session1_faMPPCA_avg(1:30), session2_faMPPCA_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_faMPPCA_avg(31:47), session2_faMPPCA_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
plot([0.2 0.6], [0.2 0.6], '--k', 'LineWidth', 1.5);
lm = fitlm(session1_faMPPCA_avg, session2_faMPPCA_avg);
xFit = linspace(min(session1_faMPPCA_avg), max(session1_faMPPCA_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_MPPCA = corr(transpose(session1_faMPPCA_avg), transpose(session2_faMPPCA_avg));
r_corr_eff_MPPCA = round(corr_eff_MPPCA, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.2 0.6], 'ytick', [0.2 0.4 0.6], ...
    'xlim', [0.2 0.6], 'xtick', [0.2 0.4 0.6], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_MPPCA)];
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

%% P2S
nexttile(3)
scatter(session1_faP2S_avg(1:30), session2_faP2S_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_faP2S_avg(31:47), session2_faP2S_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
plot([0.2 0.6], [0.2 0.6], '--k', 'LineWidth', 1.5);
lm = fitlm(session1_faP2S_avg, session2_faP2S_avg);
xFit = linspace(min(session1_faP2S_avg), max(session1_faP2S_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
corr_eff_P2S = corr(transpose(session1_faP2S_avg), transpose(session2_faP2S_avg));
r_corr_eff_P2S = round(corr_eff_P2S, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.2 0.6], 'ytick', [0.2 0.4 0.6], ...
    'xlim', [0.2 0.6], 'xtick', [0.2 0.4 0.6], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_P2S)];
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

print(gcf, 'scanrescan_fa.eps', '-depsc', '-painters');

end