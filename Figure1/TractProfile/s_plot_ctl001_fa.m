function s_plot_ctl001_fa

% This script aims to replicate a panel in Figure 1 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2025) Evaluating the impact of denoising diffusion MRI data
% on tractometry metrics of optic tract abnormalities in glaucoma. Scientific Reports, 15, 25812.

%
% Daiki Taguma, NIPS SCBM/SOKENDAI

%% Load tract profile data from left optic tract
load ../../Data/TractProfile/OT/LOT_TractProfile.mat

% Average data between first scan and second scan
fa_wo_lh = (all_profile.fa1_wo(11:90,1) + all_profile.fa2_wo(11:90,1))./2; % Without denoising
fa_MPPCA_lh = (all_profile.fa1_MPPCA(11:90,1) + all_profile.fa2_MPPCA(11:90,1))./2; % With MPPCA
fa_P2S_lh = (all_profile.fa1_P2S(11:90,1) + all_profile.fa2_P2S(11:90,1))./2; % With Patch2Self

%% Load tract profile data from right optic tract
load ../../Data/TractProfile/OT/ROT_TractProfile.mat

% Average data between first scan and second scan
fa_wo_rh = (all_profile.fa1_wo(11:90,1) + all_profile.fa2_wo(11:90,1))./2;
fa_MPPCA_rh = (all_profile.fa1_MPPCA(11:90,1) + all_profile.fa2_MPPCA(11:90,1))./2;
fa_P2S_rh = (all_profile.fa1_P2S(11:90,1) + all_profile.fa2_P2S(11:90,1))./2;

%% Average left and right hemisphere
fa_wo_avg = (fa_wo_lh + fa_wo_rh)./2;
fa_MPPCA_avg = (fa_MPPCA_lh + fa_MPPCA_rh)./2;
fa_P2S_avg = (fa_P2S_lh + fa_P2S_rh)./2;

%% Plot the tract profile of a single subject and calculate the mean FA
plot([1:1:80],fa_wo_avg,'color','#FFD600','LineWidth',3);
hold on
plot([1:1:80],fa_MPPCA_avg,'color','#CE7E8B','LineWidth',3);
plot([1:1:80],fa_P2S_avg,'color','#962676','LineWidth',3);
mean_fa_wo = mean(fa_wo_avg);
mean_fa_MPPCA = mean(fa_MPPCA_avg);
mean_fa_P2S = mean(fa_P2S_avg);
mean_fa_wo
mean_fa_MPPCA
mean_fa_P2S

% Set up plot appearance
set(gca,'tickdir','out', ...
    'box','off', ...
    'ylim',[0.3 0.7],'ytick',[0.3 0.5 0.7])
ylabel('FA','fontsize',16);
xlabel('Position','fontsize',16);
