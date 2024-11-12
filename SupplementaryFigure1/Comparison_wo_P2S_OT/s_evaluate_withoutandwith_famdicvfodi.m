function s_evaluate_withoutandwith_famdicvfodi

% This script aims to replicate a panel in Supplementary Figure 1 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2024) Evaluating the impact of
% denoising in diffusion MRI-based tractometry of visual white matter
% tracts in glaucoma patients.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI
 
%% Load left optic tract data and compute averages
load ../../Data/TractProfile/OT/LOT_TractProfile.mat
session1_faP2S_lh = mean(all_profile.fa1_P2S(11:90,:),1);
session2_faP2S_lh = mean(all_profile.fa2_P2S(11:90,:),1);
session1_fawo_lh = mean(all_profile.fa1_wo(11:90,:),1);
session2_fawo_lh = mean(all_profile.fa2_wo(11:90,:),1);
session1_mdP2S_lh = mean(all_profile.md1_P2S(11:90,:),1)*1000;
session2_mdP2S_lh = mean(all_profile.md2_P2S(11:90,:),1)*1000;
session1_mdwo_lh = mean(all_profile.md1_wo(11:90,:),1)*1000;
session2_mdwo_lh = mean(all_profile.md2_wo(11:90,:),1)*1000;
session1_icvfP2S_lh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_lh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_lh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_lh = mean(all_profile.icvf_2_wo(11:90,:),1);
session1_odiP2S_lh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_lh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_lh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_lh = mean(all_profile.odi_2_wo(11:90,:),1);
clear all_profile TractProfile

%% Load right optic tract data and compute averages
load ../../Data/TractProfile/OT/ROT_TractProfile.mat
session1_faP2S_rh = mean(all_profile.fa1_P2S(11:90,:),1);
session2_faP2S_rh = mean(all_profile.fa2_P2S(11:90,:),1);
session1_fawo_rh = mean(all_profile.fa1_wo(11:90,:),1);
session2_fawo_rh = mean(all_profile.fa2_wo(11:90,:),1);
session1_mdP2S_rh = mean(all_profile.md1_P2S(11:90,:),1)*1000;
session2_mdP2S_rh = mean(all_profile.md2_P2S(11:90,:),1)*1000;
session1_mdwo_rh = mean(all_profile.md1_wo(11:90,:),1)*1000;
session2_mdwo_rh = mean(all_profile.md2_wo(11:90,:),1)*1000;
session1_icvfP2S_rh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_rh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_rh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_rh = mean(all_profile.icvf_2_wo(11:90,:),1);
session1_odiP2S_rh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_rh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_rh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_rh = mean(all_profile.odi_2_wo(11:90,:),1);

%% Average left and right hemisphere values
session1_faP2S_avg = (session1_faP2S_lh + session1_faP2S_rh)./2;
session2_faP2S_avg = (session2_faP2S_lh + session2_faP2S_rh)./2;
session1_fawo_avg = (session1_fawo_lh + session1_fawo_rh)./2;
session2_fawo_avg = (session2_fawo_lh + session2_fawo_rh)./2;
faP2S_avg = (session1_faP2S_avg + session2_faP2S_avg)./2;
fawo_avg = (session1_fawo_avg + session2_fawo_avg)./2;
session1_mdP2S_avg = (session1_mdP2S_lh + session1_mdP2S_rh)./2;
session2_mdP2S_avg = (session2_mdP2S_lh + session2_mdP2S_rh)./2;
session1_mdwo_avg = (session1_mdwo_lh + session1_mdwo_rh)./2;
session2_mdwo_avg = (session2_mdwo_lh + session2_mdwo_rh)./2;
mdP2S_avg = (session1_mdP2S_avg + session2_mdP2S_avg)./2;
mdwo_avg = (session1_mdwo_avg + session2_mdwo_avg)./2;
session1_icvfP2S_avg = (session1_icvfP2S_lh + session1_icvfP2S_rh)./2;
session2_icvfP2S_avg = (session2_icvfP2S_lh + session2_icvfP2S_rh)./2;
session1_icvfwo_avg = (session1_icvfwo_lh + session1_icvfwo_rh)./2;
session2_icvfwo_avg = (session2_icvfwo_lh + session2_icvfwo_rh)./2;
icvfP2S_avg = (session1_icvfP2S_avg + session2_icvfP2S_avg)./2;
icvfwo_avg = (session1_icvfwo_avg + session2_icvfwo_avg)./2;
session1_odiP2S_avg = (session1_odiP2S_lh + session1_odiP2S_rh)./2;
session2_odiP2S_avg = (session2_odiP2S_lh + session2_odiP2S_rh)./2;
session1_odiwo_avg = (session1_odiwo_lh + session1_odiwo_rh)./2;
session2_odiwo_avg = (session2_odiwo_lh + session2_odiwo_rh)./2;
odiP2S_avg = (session1_odiP2S_avg + session2_odiP2S_avg)./2;
odiwo_avg = (session1_odiwo_avg + session2_odiwo_avg)./2;

%% Generate scatter plots comparing wothout denoising and Patch2Self
figure('Position', [100, 100, 900, 900]);
tiledlayout(2, 2)
%% FA
nexttile(1)
scatter(fawo_avg(1:30), faP2S_avg(1:30),25,'square','MarkerEdgeColor','#669CCC','MarkerFaceColor','#669CCC');
hold on
scatter(fawo_avg(31:47), faP2S_avg(31:47),25,'MarkerEdgeColor','#D71317','MarkerFaceColor','#D71317');
% Plot x=y line
plot([0.2 0.6], [0.2 0.6], '--k', 'LineWidth', 1.5);
% Fit and plot linear regression line
lm = fitlm(fawo_avg, faP2S_avg);
xFit = linspace(min(fawo_avg), max(fawo_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
[corr_eff_P2S] = corr(transpose(session1_faP2S_avg), transpose(session2_faP2S_avg));
axis square;
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.2 0.6], 'ytick', [0.2 0.4 0.6], ...
    'xlim', [0.2 0.6], 'xtick', [0.2 0.4 0.6], 'fontsize',15);
ylabel('P2S','fontsize',18);
xlabel('Without denoising','fontsize',18);
titletext = ['FA'];
title(titletext,'fontsize',16);

%% MD
nexttile(2)
scatter(mdwo_avg(1:30), mdP2S_avg(1:30),25,'square','MarkerEdgeColor','#669CCC','MarkerFaceColor','#669CCC');
hold on
scatter(mdwo_avg(31:47), mdP2S_avg(31:47),25,'MarkerEdgeColor','#D71317','MarkerFaceColor','#D71317');
plot([0.6 1.2], [0.6 1.2], '--k', 'LineWidth', 1.5);
lm = fitlm(mdwo_avg, mdP2S_avg);
xFit = linspace(min(mdwo_avg), max(mdwo_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.6 1.2], 'ytick', [0.6 0.9 1.2], ...
    'xlim', [0.6 1.2], 'xtick', [0.6 0.9 1.2], 'fontsize',15);
ylabel('P2S','fontsize',18);
xlabel('Without denoising','fontsize',18);
titletext = ['MD'];
title(titletext,'fontsize',16);

%% ICVF
nexttile(3)
scatter(icvfwo_avg(1:30), icvfP2S_avg(1:30),25,'square','MarkerEdgeColor','#669CCC','MarkerFaceColor','#669CCC');
hold on
scatter(icvfwo_avg(31:47), icvfP2S_avg(31:47),25,'MarkerEdgeColor','#D71317','MarkerFaceColor','#D71317');
plot([0.4 1], [0.4 1], '--k', 'LineWidth', 1.5);
lm = fitlm(icvfwo_avg, icvfP2S_avg);
xFit = linspace(min(icvfwo_avg), max(icvfwo_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.4 1], 'ytick', [0.4 0.7 1], ...
    'xlim', [0.4 1], 'xtick', [0.4 0.7 1], 'fontsize',15);
ylabel('P2S','fontsize',18);
xlabel('Without denoising','fontsize',18);
titletext = ['ICVF'];
title(titletext,'fontsize',16);

%% ODI
nexttile(4)
scatter(odiwo_avg(1:30), odiP2S_avg(1:30),25,'square','MarkerEdgeColor','#669CCC','MarkerFaceColor','#669CCC');
hold on
scatter(odiwo_avg(31:47), odiP2S_avg(31:47),25,'MarkerEdgeColor','#D71317','MarkerFaceColor','#D71317');
plot([0.1 0.4], [0.1 0.4], '--k', 'LineWidth', 1.5);
lm = fitlm(odiwo_avg, odiP2S_avg);
xFit = linspace(min(odiwo_avg), max(odiwo_avg), 100);
yFit = predict(lm, xFit');
plot(xFit, yFit, '-k', 'LineWidth', 1.5);
axis square;
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'ylim', [0.1 0.4], 'ytick', [0.1 0.2 0.3 0.4], ...
    'xlim', [0.1 0.4], 'xtick', [0.1 0.2 0.3 0.4], 'fontsize',15);
ylabel('P2S','fontsize',18);
xlabel('Without denoising','fontsize',18);
titletext = ['ODI'];
title(titletext,'fontsize',16);
print(gcf, 'Metrix_Shift.eps', '-depsc', '-painters');

end

