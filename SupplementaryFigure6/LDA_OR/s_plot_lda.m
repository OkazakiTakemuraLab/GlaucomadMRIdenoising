function s_plot_lda

% This script aims to replicate a panel in Supplementaly Figure 6 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2024) Evaluating the impact of
% denoising in diffusion MRI-based tractometry of visual white matter
% tracts in glaucoma patients.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

%% Load left optic radiation SNR data and compute averages
load ../../Data/TractProfile/OR/LOR_TractProfile.mat
session1_faP2S_lh = mean(all_profile.fa1_P2S(11:90,:),1);
session2_faP2S_lh = mean(all_profile.fa2_P2S(11:90,:),1);
session1_fawo_lh = mean(all_profile.fa1_wo(11:90,:),1);
session2_fawo_lh = mean(all_profile.fa2_wo(11:90,:),1);
session1_mdP2S_lh = 1000 * mean(all_profile.md1_P2S(11:90,:),1);
session2_mdP2S_lh = 1000 * mean(all_profile.md2_P2S(11:90,:),1);
session1_mdwo_lh = 1000 * mean(all_profile.md1_wo(11:90,:),1);
session2_mdwo_lh = 1000 * mean(all_profile.md2_wo(11:90,:),1);
session1_icvfP2S_lh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_lh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_lh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_lh = mean(all_profile.icvf_2_wo(11:90,:),1);
session1_odiP2S_lh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_lh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_lh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_lh = mean(all_profile.odi_2_wo(11:90,:),1);
clear all_profile

%% Load right optic radiation data, compute combined averages
load ../../Data/TractProfile/OR/ROR_TractProfile.mat
session1_faP2S_rh = mean(all_profile.fa1_P2S(11:90,:),1);
session2_faP2S_rh = mean(all_profile.fa2_P2S(11:90,:),1);
session1_fawo_rh = mean(all_profile.fa1_wo(11:90,:),1);
session2_fawo_rh = mean(all_profile.fa2_wo(11:90,:),1);
session1_mdP2S_rh = 1000 * mean(all_profile.md1_P2S(11:90,:),1);
session2_mdP2S_rh = 1000 * mean(all_profile.md2_P2S(11:90,:),1);
session1_mdwo_rh = 1000 * mean(all_profile.md1_wo(11:90,:),1);
session2_mdwo_rh = 1000 * mean(all_profile.md2_wo(11:90,:),1);
session1_icvfP2S_rh = mean(all_profile.icvf_1_P2S(11:90,:),1);
session2_icvfP2S_rh = mean(all_profile.icvf_2_P2S(11:90,:),1);
session1_icvfwo_rh = mean(all_profile.icvf_1_wo(11:90,:),1);
session2_icvfwo_rh = mean(all_profile.icvf_2_wo(11:90,:),1);
session1_odiP2S_rh = mean(all_profile.odi_1_P2S(11:90,:),1);
session2_odiP2S_rh = mean(all_profile.odi_2_P2S(11:90,:),1);
session1_odiwo_rh = mean(all_profile.odi_1_wo(11:90,:),1);
session2_odiwo_rh = mean(all_profile.odi_2_wo(11:90,:),1);

% Average left and right hemisphere 
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

%% Plot
figure('Position', [100, 100, 900, 900]);
tiledlayout(2, 2)

%% DTI
%% without denoising
nexttile(1)
data = [fawo_avg; mdwo_avg]';

label = zeros(1, 47); 
label(1:30) = 1;      
labels = (label)';
scatter(data(1:30,1), data(1:30,2), 's', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on;
scatter(data(31:47,1), data(31:47,2), 'o', 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
lda = fitcdiscr(data(:,1:2), labels,"DiscrimType", "linear");
ldaClass = resubPredict(lda);
ldaResubErr2 = resubLoss(lda);
% Add decision boundary
xrange = linspace(0.4, 0.8, 2000);
yrange = linspace(0.6, 0.9, 2000);
[X, Y] = meshgrid(xrange, yrange); 
gridX = [X(:), Y(:)];
decisionBoundary = predict(lda, gridX);
decisionBoundary = reshape(decisionBoundary, size(X));
contour(X, Y, decisionBoundary, [0.5 0.5], 'k--', 'LineWidth', 2);
xlabel('FA','fontsize',16);
ylabel('MD', 'fontsize', 16);

axis square;
titletext = ['Without denoising'];
title(titletext,'fontsize',16);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'xlim', [0.4 0.8], 'xtick', [0.4 0.6 0.8], ...
    'ylim', [0.6 0.9], 'ytick', [0.6 0.7 0.8 0.9], 'fontsize',15);

cvlda_wo = crossval(lda, 'Leaveout', 'on');
cvErr_wo = kfoldLoss(cvlda_wo);
resubErr_wo = resubLoss(lda);

M1 = 0.8;
m1 = 0.4;
M2 = 0.9;
m2 = 0.6;
r_resubErr_wo = round(resubErr_wo, 2);
titletext = ['MP = ', num2str(r_resubErr_wo)];
text((M1-m1)*0.61+m1, (M2-m2)*0.07+m2, titletext, 'fontsize', 16);

%% P2S
nexttile(2)
data = [faP2S_avg; mdP2S_avg]';

label = zeros(1, 47); 
label(1:30) = 1;      
labels = (label)';
scatter(data(1:30,1), data(1:30,2), 's', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on;
scatter(data(31:47,1), data(31:47,2), 'o', 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
lda = fitcdiscr(data(:,1:2), labels,"DiscrimType", "linear");
ldaClass = resubPredict(lda);
ldaResubErr1 = resubLoss(lda);
% Add decision boundary
xrange = linspace(0.4, 0.8, 2000);
yrange = linspace(0.6, 0.9, 2000);
[X, Y] = meshgrid(xrange, yrange); 
gridX = [X(:), Y(:)];
decisionBoundary = predict(lda, gridX);
decisionBoundary = reshape(decisionBoundary, size(X));
contour(X, Y, decisionBoundary, [0.5 0.5], 'k--', 'LineWidth', 2);
xlabel('FA','fontsize',16);
ylabel('MD', 'fontsize', 16);
axis square;
titletext = ['With P2S'];
title(titletext,'fontsize',16);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'xlim', [0.4 0.8], 'xtick', [0.4 0.6 0.8], ...
    'ylim', [0.6 0.9], 'ytick', [0.6 0.7 0.8 0.9], 'fontsize',15);

cvlda_P2S = crossval(lda, 'Leaveout', 'on');
cvErr_P2S = kfoldLoss(cvlda_P2S);
resubErr_P2S = resubLoss(lda);

M1 = 0.8;
m1 = 0.4;
M2 = 0.9;
m2 = 0.6;
r_resubErr_P2S = round(resubErr_P2S, 2);
titletext = ['MP = ', num2str(r_resubErr_P2S)];
text((M1-m1)*0.61+m1, (M2-m2)*0.07+m2, titletext, 'fontsize', 16);

%% NODDI
%% without denoising
nexttile(3)
data = [icvfwo_avg; odiwo_avg]';

label = zeros(1, 47); 
label(1:30) = 1;      
labels = (label)';
scatter(data(1:30,1), data(1:30,2), 's', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on;
scatter(data(31:47,1), data(31:47,2), 'o', 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
lda = fitcdiscr(data(:,1:2), labels,"DiscrimType", "linear");
ldaClass = resubPredict(lda);
ldaResubErr2 = resubLoss(lda);
% Add decision boundary
xrange = linspace(0.4, 0.8, 2000);
yrange = linspace(0.1, 0.3, 2000);
[X, Y] = meshgrid(xrange, yrange); 
gridX = [X(:), Y(:)];
decisionBoundary = predict(lda, gridX);
decisionBoundary = reshape(decisionBoundary, size(X));
contour(X, Y, decisionBoundary, [0.5 0.5], 'k--', 'LineWidth', 2);
xlabel('ICVF','fontsize',16);
ylabel('ODI','fontsize',16);
axis square;
titletext = ['Without denoising'];
title(titletext,'fontsize',16);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'xlim', [0.4 0.7], 'xtick', [0.4 0.5 0.6 0.7], ...
    'ylim', [0.1 0.3], 'ytick', [0.1 0.2 0.3], 'fontsize',15);

cvlda_wo = crossval(lda, 'Leaveout', 'on');
cvErr_wo = kfoldLoss(cvlda_wo);
resubErr_wo = resubLoss(lda);

M1 = 0.7;
m1 = 0.4;
M2 = 0.3;
m2 = 0.1;
r_resubErr_wo = round(resubErr_wo, 2);
titletext = ['MP = ', num2str(r_resubErr_wo)];
text((M1-m1)*0.61+m1, (M2-m2)*0.07+m2, titletext, 'fontsize', 16);

%% P2S
nexttile(4)
data = [icvfP2S_avg; odiP2S_avg]';

label = zeros(1, 47); 
label(1:30) = 1;      
labels = (label)';
scatter(data(1:30,1), data(1:30,2), 's', 'MarkerEdgeColor', '#669CCC', 'MarkerFaceColor', '#669CCC');
hold on;
scatter(data(31:47,1), data(31:47,2), 'o', 'MarkerEdgeColor', '#D71317', 'MarkerFaceColor', '#D71317');
lda = fitcdiscr(data(:,1:2), labels,"DiscrimType", "linear");
ldaClass = resubPredict(lda);
ldaResubErr1 = resubLoss(lda);
% Add decision boundary
xrange = linspace(0.4, 0.7, 2000);
yrange = linspace(0.1, 0.3, 2000);
[X, Y] = meshgrid(xrange, yrange); 
gridX = [X(:), Y(:)];
decisionBoundary = predict(lda, gridX);
decisionBoundary = reshape(decisionBoundary, size(X));
contour(X, Y, decisionBoundary, [0.5 0.5], 'k--', 'LineWidth', 2);
xlabel('ICVF','fontsize',16);
ylabel('ODI','fontsize',16);
axis square;
titletext = ['With P2S'];
title(titletext,'fontsize',16);
set(gca, 'tickdir', 'out', ...
    'box', 'off', ...
    'xlim', [0.4 0.7], 'xtick', [0.4 0.5 0.6 0.7], ...
    'ylim', [0.1 0.3], 'ytick', [0.1 0.2 0.3], 'fontsize',15);

cvlda_P2S = crossval(lda, 'Leaveout', 'on');
cvErr_P2S = kfoldLoss(cvlda_P2S);
resubErr_P2S = resubLoss(lda);

M1 = 0.7;
m1 = 0.4;
M2 = 0.3;
m2 = 0.1;
r_resubErr_P2S = round(resubErr_P2S, 2);
titletext = ['MP = ', num2str(r_resubErr_P2S)];
text((M1-m1)*0.61+m1, (M2-m2)*0.07+m2, titletext, 'fontsize', 16);

print(gcf, 'LDA_OR.eps', '-depsc', '-painters');

end