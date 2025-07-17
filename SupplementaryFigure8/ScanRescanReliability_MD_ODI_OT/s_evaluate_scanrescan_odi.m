function s_evaluate_scanrescan_odi

% This script aims to replicate bottom panels in Supplementaly Figure 8 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2025) Evaluating the impact of denoising diffusion MRI data
% on tractometry metrics of optic tract abnormalities in glaucoma. Scientific Reports, 15, 25812.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

%% Load left optic tract data and compute averages
load ../../Data/TractProfile/OT/LOT_TractProfile.mat
session1_odiMPPCA_lh = mean(all_profile.odi_1_MPPCA(11:90,:),1);
session2_odiMPPCA_lh = mean(all_profile.odi_2_MPPCA(11:90,:),1);
session1_odiP2S_lh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_lh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_lh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_lh = mean(all_profile.odi_2_wo(11:90,:),1);
clear all_profile TractProfile

%% Load right optic tract data, compute combined averages
load ../../Data/TractProfile/OT/ROT_TractProfile.mat
session1_odiMPPCA_rh = mean(all_profile.odi_1_MPPCA(11:90,:),1);
session2_odiMPPCA_rh = mean(all_profile.odi_2_MPPCA(11:90,:),1);
session1_odiP2S_rh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_rh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_rh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_rh = mean(all_profile.odi_2_wo(11:90,:),1);

%% Average left and right hemisphere values
session1_odiMPPCA_avg = (session1_odiMPPCA_lh + session1_odiMPPCA_rh)./2;
session2_odiMPPCA_avg = (session2_odiMPPCA_lh + session2_odiMPPCA_rh)./2;
session1_odiP2S_avg = (session1_odiP2S_lh + session1_odiP2S_rh)./2;
session2_odiP2S_avg = (session2_odiP2S_lh + session2_odiP2S_rh)./2;
session1_odiwo_avg = (session1_odiwo_lh + session1_odiwo_rh)./2;
session2_odiwo_avg = (session2_odiwo_lh + session2_odiwo_rh)./2;

%% Plot scan-rescan scatter plots
figure('Position', [100, 100, 1300, 400]);
tiledlayout(1, 3)

%% without denoising
nexttile(1)
scatter(session1_odiwo_avg(1:30), session2_odiwo_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_odiwo_avg(31:47), session2_odiwo_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
% Plot x=y line
plot([0.1 0.4], [0.1 0.4], '--k', 'LineWidth', 1.5); % x=y line
% Fit and plot linear regression line
lm = fitlm(session1_odiwo_avg, session2_odiwo_avg);
xFit = linspace(min(session1_odiwo_avg), max(session1_odiwo_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5); % Linear regression line
axis square;
corr_eff_wo = corr(transpose(session1_odiwo_avg), transpose(session2_odiwo_avg));
r_corr_eff_wo = round(corr_eff_wo, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.1 0.4], 'ytick', [0.1 0.2 0.3 0.4], ...
    'xlim', [0.1 0.4], 'xtick', [0.1 0.2 0.3 0.4], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_wo)];
M = 0.4;
m = 0.1;
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

%% MPPCA
nexttile(2)
scatter(session1_odiMPPCA_avg(1:30), session2_odiMPPCA_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_odiMPPCA_avg(31:47), session2_odiMPPCA_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
% Plot x=y line
plot([0.1 0.4], [0.1 0.4], '--k', 'LineWidth', 1.5); % x=y line
% Fit and plot linear regression line
lm = fitlm(session1_odiMPPCA_avg, session2_odiMPPCA_avg);
xFit = linspace(min(session1_odiMPPCA_avg), max(session1_odiMPPCA_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5); % Linear regression line
axis square;
corr_eff_MPPCA = corr(transpose(session1_odiMPPCA_avg), transpose(session2_odiMPPCA_avg));
r_corr_eff_MPPCA = round(corr_eff_MPPCA, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.1 0.4], 'ytick', [0.1 0.2 0.3 0.4], ...
    'xlim', [0.1 0.4], 'xtick', [0.1 0.2 0.3 0.4], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_MPPCA)];
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

% P2S
nexttile(3)
scatter(session1_odiP2S_avg(1:30), session2_odiP2S_avg(1:30), 25, 'square', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on
scatter(session1_odiP2S_avg(31:47), session2_odiP2S_avg(31:47), 25, 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
% Plot x=y line
plot([0.1 0.4], [0.1 0.4], '--k', 'LineWidth', 1.5); % x=y line
% Fit and plot linear regression line
lm = fitlm(session1_odiP2S_avg, session2_odiP2S_avg);
xFit = linspace(min(session1_odiP2S_avg), max(session1_odiP2S_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5); % Linear regression line
axis square;
corr_eff_P2S = corr(transpose(session1_odiP2S_avg), transpose(session2_odiP2S_avg));
r_corr_eff_P2S = round(corr_eff_P2S, 2);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.1 0.4], 'ytick', [0.1 0.2 0.3 0.4], ...
    'xlim', [0.1 0.4], 'xtick', [0.1 0.2 0.3 0.4], 'fontsize',15);
ylabel('Run 2 (PA)','fontsize',18);
xlabel('Run 1 (AP)','fontsize',18);
titletext = ['R = ', num2str(r_corr_eff_P2S)];
text((M-m)*0.62+m, (M-m)*0.07+m, titletext, 'fontsize', 18);

print(gcf, 'scanrescan_odi.eps', '-depsc', '-painters');
end
