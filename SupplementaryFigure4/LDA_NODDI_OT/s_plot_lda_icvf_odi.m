function s_plot_lda_icvf_odi

% This script aims to replicate Supplementaly Figure 4 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2025) Evaluating the impact of denoising diffusion MRI data
% on tractometry metrics of optic tract abnormalities in glaucoma. Scientific Reports, 15, 25812.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI
% 

% Add path to external toolbox
addpath(genpath('../../ExternalTools'));

%% Load left optic tract data and compute averages
load ../../Data/TractProfile/OT/LOT_TractProfile.mat
session1_icvfP2S_lh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_lh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_lh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_lh = mean(all_profile.icvf_2_wo(11:90,:),1);
session1_odiP2S_lh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_lh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_lh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_lh = mean(all_profile.odi_2_wo(11:90,:),1);
clear all_profile

%% Load right optic tract data and compute averages
load ../../Data/TractProfile/OT/ROT_TractProfile.mat
session1_icvfP2S_rh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_rh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_rh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_rh = mean(all_profile.icvf_2_wo(11:90,:),1);
session1_odiP2S_rh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_rh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_rh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_rh = mean(all_profile.odi_2_wo(11:90,:),1);

% Average left and right hemisphere 
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

%% Plot
figure('Position', [100, 100, 900, 500]);
tiledlayout(1, 2)

%% without denoising
nexttile(1)
data = [icvfwo_avg; odiwo_avg]';
label = zeros(1, 47); 
label(1:30) = 1;      
labels = (label)';
scatter(data(1:30,1), data(1:30,2), 's', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on;
scatter(data(31:47,1), data(31:47,2), 'o', 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
lda_wo = fitcdiscr(data(:,1:2), labels,"DiscrimType", "linear");
ldaClass_wo = resubPredict(lda_wo);

% Add decision boundary
xrange = linspace(0.4, 1.0, 2000);
yrange = linspace(0.1, 0.4, 2000);
[X, Y] = meshgrid(xrange, yrange); 
gridX = [X(:), Y(:)];
decisionBoundary = predict(lda_wo, gridX);
decisionBoundary = reshape(decisionBoundary, size(X));
contour(X, Y, decisionBoundary, [0.5 0.5], 'k--', 'LineWidth', 2);
xlabel('ICVF','fontsize',16);
ylabel('ODI','fontsize',16);
axis square;
titletext = ['Without denoising'];
title(titletext,'fontsize',16);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'xlim', [0.4 1.0], 'xtick', [0.4 0.7 1.0], ...
    'ylim', [0.1 0.4], 'ytick', [0.1 0.2 0.3 0.4], 'fontsize',15);

resubErr_wo = resubLoss(lda_wo);

M1 = 1.0;
m1 = 0.4;
M2 = 0.4;
m2 = 0.1;
r_resubErr_wo = round(resubErr_wo, 2);
titletext = ['MP = ', num2str(r_resubErr_wo)];
text((M1-m1)*0.61+m1, (M2-m2)*0.07+m2, titletext, 'fontsize', 16);

%% P2S
nexttile(2)
data = [icvfP2S_avg; odiP2S_avg]';

label = zeros(1, 47); 
label(1:30) = 1;      
labels = (label)';
scatter(data(1:30,1), data(1:30,2), 's', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on;
scatter(data(31:47,1), data(31:47,2), 'o', 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
lda_P2S = fitcdiscr(data(:,1:2), labels,"DiscrimType", "linear");
ldaClass_P2S = resubPredict(lda_P2S);

% Add decision boundary
xrange = linspace(0.4, 1.0, 2000);
yrange = linspace(0.1, 0.4, 2000);
[X, Y] = meshgrid(xrange, yrange); 
gridX = [X(:), Y(:)];
decisionBoundary = predict(lda_P2S, gridX);
decisionBoundary = reshape(decisionBoundary, size(X));
contour(X, Y, decisionBoundary, [0.5 0.5], 'k--', 'LineWidth', 2);
xlabel('ICVF','fontsize',16);
ylabel('ODI','fontsize',16);
axis square;
titletext = ['With P2S'];
title(titletext,'fontsize',16);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'xlim', [0.4 1.0], 'xtick', [0.4 0.7 1.0], ...
    'ylim', [0.1 0.4], 'ytick', [0.1 0.2 0.3 0.4], 'fontsize',15);

resubErr_P2S = resubLoss(lda_P2S);

M1 = 1.0;
m1 = 0.4;
M2 = 0.4;
m2 = 0.1;
r_resubErr_P2S = round(resubErr_P2S, 2);
titletext = ['MP = ', num2str(r_resubErr_P2S)];
text((M1-m1)*0.61+m1, (M2-m2)*0.07+m2, titletext, 'fontsize', 16);

print(gcf, 'LDA_OT.eps', '-depsc', '-painters');

%% Create contingency table
% True label: labels
% Predicted by Without denoising: ldaClass_wo
% Predicted by With P2S: ldaClass_P2S

% Calculate the contingency table
a = sum((ldaClass_wo == labels) & (ldaClass_P2S == labels)); % Both correct
b = sum((ldaClass_wo == labels) & (ldaClass_P2S ~= labels)); % wo correct, P2S incorrect
c = sum((ldaClass_wo ~= labels) & (ldaClass_P2S == labels)); % wo incorrect, P2S correct
d = sum((ldaClass_wo ~= labels) & (ldaClass_P2S ~= labels)); % Both incorrect

contingency_table = [a b; c d];

%% Perform McNemar's test
disp('Contingency Table:');
disp(contingency_table);
mcnemar(contingency_table, 0.05); % Alpha = 0.05
end
