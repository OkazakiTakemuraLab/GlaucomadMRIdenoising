function s_plot_combine_violin

% This script aims to replicate Figure 6 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2025) Evaluating the impact of denoising diffusion MRI data
% on tractometry metrics of optic tract abnormalities in glaucoma. Scientific Reports, 15, 25812. 
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

% Add path to violin plot script
addpath('../../ExternalTools');
%% Load left optic tract data and calculate means
load ../../Data/TractProfile/OT/LOT_TractProfile.mat
session1_faMPPCA_lh = mean(all_profile.fa1_MPPCA(11:90,:),1);
session2_faMPPCA_lh = mean(all_profile.fa2_MPPCA(11:90,:),1);
session1_faP2S_lh = mean(all_profile.fa1_P2S(11:90,:),1);
session2_faP2S_lh = mean(all_profile.fa2_P2S(11:90,:),1);
session1_fawo_lh = mean(all_profile.fa1_wo(11:90,:),1);
session2_fawo_lh = mean(all_profile.fa2_wo(11:90,:),1);
session1_mdMPPCA_lh = mean(all_profile.md1_MPPCA(11:90,:),1);
session2_mdMPPCA_lh = mean(all_profile.md2_MPPCA(11:90,:),1);
session1_mdP2S_lh = mean(all_profile.md1_P2S(11:90,:),1);
session2_mdP2S_lh = mean(all_profile.md2_P2S(11:90,:),1);
session1_mdwo_lh = mean(all_profile.md1_wo(11:90,:),1);
session2_mdwo_lh = mean(all_profile.md2_wo(11:90,:),1);
session1_icvfMPPCA_lh = mean(all_profile.icvf_1_MPPCA(11:90,:),1);
session2_icvfMPPCA_lh = mean(all_profile.icvf_2_MPPCA(11:90,:),1);
session1_icvfP2S_lh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_lh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_lh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_lh = mean(all_profile.icvf_2_wo(11:90,:),1);
session1_odiMPPCA_lh = mean(all_profile.odi_1_MPPCA(11:90,:),1);
session2_odiMPPCA_lh = mean(all_profile.odi_2_MPPCA(11:90,:),1);
session1_odiP2S_lh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_lh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_lh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_lh = mean(all_profile.odi_2_wo(11:90,:),1);
clear all_profile

%% Load right optic tract data and calculate means
load ../../Data/TractProfile/OT/ROT_TractProfile.mat
session1_faMPPCA_rh = mean(all_profile.fa1_MPPCA(11:90,:),1);
session2_faMPPCA_rh = mean(all_profile.fa2_MPPCA(11:90,:),1);
session1_faP2S_rh = mean(all_profile.fa1_P2S(11:90,:),1);
session2_faP2S_rh = mean(all_profile.fa2_P2S(11:90,:),1);
session1_fawo_rh = mean(all_profile.fa1_wo(11:90,:),1);
session2_fawo_rh = mean(all_profile.fa2_wo(11:90,:),1);
session1_mdMPPCA_rh = mean(all_profile.md1_MPPCA(11:90,:),1);
session2_mdMPPCA_rh = mean(all_profile.md2_MPPCA(11:90,:),1);
session1_mdP2S_rh = mean(all_profile.md1_P2S(11:90,:),1);
session2_mdP2S_rh = mean(all_profile.md2_P2S(11:90,:),1);
session1_mdwo_rh = mean(all_profile.md1_wo(11:90,:),1);
session2_mdwo_rh = mean(all_profile.md2_wo(11:90,:),1);
session1_icvfMPPCA_rh = mean(all_profile.icvf_1_MPPCA(11:90,:),1);
session2_icvfMPPCA_rh = mean(all_profile.icvf_2_MPPCA(11:90,:),1);
session1_icvfP2S_rh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_rh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_rh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_rh = mean(all_profile.icvf_2_wo(11:90,:),1);
session1_odiMPPCA_rh = mean(all_profile.odi_1_MPPCA(11:90,:),1);
session2_odiMPPCA_rh = mean(all_profile.odi_2_MPPCA(11:90,:),1);
session1_odiP2S_rh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_rh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_rh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_rh = mean(all_profile.odi_2_wo(11:90,:),1);

%% Average left and right hemisphere FA
session1_faMPPCA_avg = (session1_faMPPCA_lh + session1_faMPPCA_rh)./2;
session2_faMPPCA_avg = (session2_faMPPCA_lh + session2_faMPPCA_rh)./2;
session1_faP2S_avg = (session1_faP2S_lh + session1_faP2S_rh)./2;
session2_faP2S_avg = (session2_faP2S_lh + session2_faP2S_rh)./2;
session1_fawo_avg = (session1_fawo_lh + session1_fawo_rh)./2;
session2_fawo_avg = (session2_fawo_lh + session2_fawo_rh)./2;
% Calculate average values of two scans
faMPPCA_avg = (session1_faMPPCA_avg + session2_faMPPCA_avg)./2;
faP2S_avg = (session1_faP2S_avg + session2_faP2S_avg)./2;
fawo_avg = (session1_fawo_avg + session2_fawo_avg)./2;
% Calculate control means
faMPPCA_c_ave = mean(faMPPCA_avg(1,1:30));
faP2S_c_ave = mean(faP2S_avg(1,1:30));
fawo_c_ave = mean(fawo_avg(1,1:30));
% Calculate control standard deviations
faMPPCA_c_stdev = std(faMPPCA_avg(1,1:30));
faP2S_c_stdev = std(faP2S_avg(1,1:30));
fawo_c_stdev = std(fawo_avg(1,1:30));
% Calculate deviation from control
faMPPCA_var = (faMPPCA_avg(1,31:47) - faMPPCA_c_ave)./faMPPCA_c_stdev;
faP2S_var = (faP2S_avg(1,31:47) - faP2S_c_ave)./faP2S_c_stdev;
fawo_var = (fawo_avg(1,31:47) - fawo_c_ave)./fawo_c_stdev;

%% MD
session1_mdMPPCA_avg = (session1_mdMPPCA_lh + session1_mdMPPCA_rh)./2;
session2_mdMPPCA_avg = (session2_mdMPPCA_lh + session2_mdMPPCA_rh)./2;
session1_mdP2S_avg = (session1_mdP2S_lh + session1_mdP2S_rh)./2;
session2_mdP2S_avg = (session2_mdP2S_lh + session2_mdP2S_rh)./2;
session1_mdwo_avg = (session1_mdwo_lh + session1_mdwo_rh)./2;
session2_mdwo_avg = (session2_mdwo_lh + session2_mdwo_rh)./2;
mdMPPCA_avg = (session1_mdMPPCA_avg + session2_mdMPPCA_avg)./2;
mdP2S_avg = (session1_mdP2S_avg + session2_mdP2S_avg)./2;
mdwo_avg = (session1_mdwo_avg + session2_mdwo_avg)./2;
mdMPPCA_c_ave = mean(mdMPPCA_avg(1,1:30));
mdP2S_c_ave = mean(mdP2S_avg(1,1:30));
mdwo_c_ave = mean(mdwo_avg(1,1:30));
mdMPPCA_c_stdev = std(mdMPPCA_avg(1,1:30));
mdP2S_c_stdev = std(mdP2S_avg(1,1:30));
mdwo_c_stdev = std(mdwo_avg(1,1:30));
mdMPPCA_var = (mdMPPCA_avg(1,31:47) - mdMPPCA_c_ave)./mdMPPCA_c_stdev;
mdP2S_var = (mdP2S_avg(1,31:47) - mdP2S_c_ave)./mdP2S_c_stdev;
mdwo_var = (mdwo_avg(1,31:47) - mdwo_c_ave)./mdwo_c_stdev;

%% ICVF
session1_icvfMPPCA_avg = (session1_icvfMPPCA_lh + session1_icvfMPPCA_rh)./2;
session2_icvfMPPCA_avg = (session2_icvfMPPCA_lh + session2_icvfMPPCA_rh)./2;
session1_icvfP2S_avg = (session1_icvfP2S_lh + session1_icvfP2S_rh)./2;
session2_icvfP2S_avg = (session2_icvfP2S_lh + session2_icvfP2S_rh)./2;
session1_icvfwo_avg = (session1_icvfwo_lh + session1_icvfwo_rh)./2;
session2_icvfwo_avg = (session2_icvfwo_lh + session2_icvfwo_rh)./2;
icvfMPPCA_avg = (session1_icvfMPPCA_avg + session2_icvfMPPCA_avg)./2;
icvfP2S_avg = (session1_icvfP2S_avg + session2_icvfP2S_avg)./2;
icvfwo_avg = (session1_icvfwo_avg + session2_icvfwo_avg)./2;
icvfMPPCA_c_ave = mean(icvfMPPCA_avg(1,1:30));
icvfP2S_c_ave = mean(icvfP2S_avg(1,1:30));
icvfwo_c_ave = mean(icvfwo_avg(1,1:30));
icvfMPPCA_c_stdev = std(icvfMPPCA_avg(1,1:30));
icvfP2S_c_stdev = std(icvfP2S_avg(1,1:30));
icvfwo_c_stdev = std(icvfwo_avg(1,1:30));
icvfMPPCA_var = (icvfMPPCA_avg(1,31:47) - icvfMPPCA_c_ave)./icvfMPPCA_c_stdev;
icvfP2S_var = (icvfP2S_avg(1,31:47) - icvfP2S_c_ave)./icvfP2S_c_stdev;
icvfwo_var = (icvfwo_avg(1,31:47) - icvfwo_c_ave)./icvfwo_c_stdev;

%% ODI
session1_odiMPPCA_avg = (session1_odiMPPCA_lh + session1_odiMPPCA_rh)./2;
session2_odiMPPCA_avg = (session2_odiMPPCA_lh + session2_odiMPPCA_rh)./2;
session1_odiP2S_avg = (session1_odiP2S_lh + session1_odiP2S_rh)./2;
session2_odiP2S_avg = (session2_odiP2S_lh + session2_odiP2S_rh)./2;
session1_odiwo_avg = (session1_odiwo_lh + session1_odiwo_rh)./2;
session2_odiwo_avg = (session2_odiwo_lh + session2_odiwo_rh)./2;
odiMPPCA_avg = (session1_odiMPPCA_avg + session2_odiMPPCA_avg)./2;
odiP2S_avg = (session1_odiP2S_avg + session2_odiP2S_avg)./2;
odiwo_avg = (session1_odiwo_avg + session2_odiwo_avg)./2;
odiMPPCA_c_ave = mean(odiMPPCA_avg(1,1:30));
odiP2S_c_ave = mean(odiP2S_avg(1,1:30));
odiwo_c_ave = mean(odiwo_avg(1,1:30));
odiMPPCA_c_stdev = std(odiMPPCA_avg(1,1:30));
odiP2S_c_stdev = std(odiP2S_avg(1,1:30));
odiwo_c_stdev = std(odiwo_avg(1,1:30));
odiMPPCA_var = (odiMPPCA_avg(1,31:47) - odiMPPCA_c_ave)./odiMPPCA_c_stdev;
odiP2S_var = (odiP2S_avg(1,31:47) - odiP2S_c_ave)./odiP2S_c_stdev;
odiwo_var = (odiwo_avg(1,31:47) - odiwo_c_ave)./odiwo_c_stdev;

%% Plot violin plots
figure('Position', [100, 100, 1100, 600]);
xlim([0.5 12.5]);
yline(0, 'Color', [0.5 0.5 0.5], 'LineWidth', 1); 
hold on
set(gca, 'xtick', 1:12, 'xticklabel', {'Without Denoising', 'With MPPCA', 'With P2S', 'Without Denoising', 'With MPPCA', 'With P2S', ...
    'Without Denoising', 'With MPPCA', 'With P2S', 'Without Denoising', 'With MPPCA', 'With P2S'});
hold on
Violin({fawo_var}, 1, 'ViolinColor', {[1 0.84 0.2]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({faMPPCA_var}, 2, 'ViolinColor', {[0.92 0.6 0.7]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2); 
Violin({faP2S_var}, 3, 'ViolinColor', {[0.66 0.2 0.55]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({mdwo_var}, 4, 'ViolinColor', {[1 0.84 0.2]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({mdMPPCA_var}, 5, 'ViolinColor', {[0.92 0.6 0.7]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2); 
Violin({mdP2S_var}, 6, 'ViolinColor', {[0.66 0.2 0.55]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({icvfwo_var}, 7, 'ViolinColor', {[1 0.84 0.2]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({icvfMPPCA_var}, 8, 'ViolinColor', {[0.92 0.6 0.7]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2); 
Violin({icvfP2S_var}, 9, 'ViolinColor', {[0.66 0.2 0.55]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({odiwo_var}, 10, 'ViolinColor', {[1 0.84 0.2]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
Violin({odiMPPCA_var}, 11, 'ViolinColor', {[0.92 0.6 0.7]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2); 
Violin({odiP2S_var}, 12, 'ViolinColor', {[0.66 0.2 0.55]}, 'ShowData', false, 'ShowMedian', false, 'ShowBox', false, 'QuartileStyle', 'none', 'ShowMean', true, 'EdgeColor', [1 1 1], 'LineWidth', 2);
% Plot individual values
for i = 1:length(fawo_var)
    plot([1:3], [fawo_var(i), faMPPCA_var(i), faP2S_var(i)], '-o', 'Color', '#C7233B');
end
for i = 1:length(mdwo_var)
    plot([4:6], [mdwo_var(i), mdMPPCA_var(i), mdP2S_var(i)], '-o', 'Color', '#C7233B');
end
for i = 1:length(icvfwo_var)
    plot([7:9], [icvfwo_var(i), icvfMPPCA_var(i), icvfP2S_var(i)], '-o', 'Color', '#C7233B');
end
for i = 1:length(odiwo_var)
    plot([10:12], [odiwo_var(i), odiMPPCA_var(i), odiP2S_var(i)], '-o', 'Color', '#C7233B');
end

ylim ([-6 6]);

h = findobj(gca, 'Type', 'Line');
for i = 1:length(h)
    if isequal(h(i).Color, [0.5 0.5 0.5])
        set(h(i), 'Visible', 'off');
    end
end
print(gcf, 'combine_violin.eps', '-depsc', '-painters');
hold off;

%% Statistical comparisons
props = {'fa', 'md', 'icvf', 'odi'};
for i = 1:length(props)
    prop = props{i};
    props{i}
    x = eval([prop, 'wo_var']);
    y = eval([prop, 'MPPCA_var']);
    z = eval([prop, 'P2S_var']);
    
    d_MPPCA = computeCohen_d(x,y, 'paired');
    [bf10_MPPCA,pValue_MPPCA] = bf.ttest(x,y,'tail','both');
    [h, p, ci, stats_MPPCA]=ttest(x, y,'Tail','both');
    d_MPPCA
    bf10_MPPCA
    pValue_MPPCA
    stats_MPPCA
    
    d_P2S = computeCohen_d(x, z, 'paired');
    [bf10_P2S,pValue_P2S] = bf.ttest(x, z, 'tail', 'both');
    [h, p, ci, stats_P2S]=ttest(x, z,'Tail','both');
    d_P2S
    bf10_P2S
    pValue_P2S
    stats_P2S
    
    d = computeCohen_d(y, z, 'paired');
    [bf10,pValue] = bf.ttest(y, z, 'tail', 'both');
    [h, p, ci, stats]=ttest(y, z,'Tail','both');
    d
    bf10
    pValue
    stats
end

end


