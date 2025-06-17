function OT_wo

% This script aims to replicate top panels in Supplementaly Figure 7 of the following
% article:
% Taguma, D., Ogawa, S. & Takemura, H. (2024) Evaluating the impact of
% denoising in diffusion MRI-based tractometry of visual white matter
% tracts in glaucoma patients.
%
% Daiki Taguma, NIPS SCBM/SOKENDAI

%% Load left optic tract data and compute averages
load ../../Data/TractProfile/OT/LOT_TractProfile.mat
for k = 1:47
    if k < 31
    fa_1_control_lh(:,k) = (all_profile.fa1_wo(11:90,k) + all_profile.fa2_wo(11:90,k))./2;    
    md_1_control_lh(:,k) = (all_profile.md1_wo(11:90,k) + all_profile.md2_wo(11:90,k))./2;
    icvf_1_control_lh(:,k) = (all_profile.icvf_1_wo(11:90,k) + all_profile.icvf_2_wo(11:90,k))./2;    
    odi_1_control_lh(:,k) = (all_profile.odi_1_wo(11:90,k) + all_profile.odi_2_wo(11:90,k))./2;
    else
    fa_1_glaucoma_lh(:,k-30) = (all_profile.fa1_wo(11:90,k) + all_profile.fa2_wo(11:90,k))./2;    
    md_1_glaucoma_lh(:,k-30) = (all_profile.md1_wo(11:90,k) + all_profile.md2_wo(11:90,k))./2;
    icvf_1_glaucoma_lh(:,k-30) = (all_profile.icvf_1_wo(11:90,k) + all_profile.icvf_2_wo(11:90,k))./2;
    odi_1_glaucoma_lh(:,k-30) = (all_profile.odi_1_wo(11:90,k) + all_profile.odi_2_wo(11:90,k))./2;
    end
end

%% Load right optic tract data, compute combined averages
load ../../Data/TractProfile/OT/ROT_TractProfile.mat
for k = 1:47
    if k < 31
    fa_1_control_rh(:,k) = (all_profile.fa1_wo(11:90,k) + all_profile.fa2_wo(11:90,k))./2;    
    md_1_control_rh(:,k) = (all_profile.md1_wo(11:90,k) + all_profile.md2_wo(11:90,k))./2;
    icvf_1_control_rh(:,k) = (all_profile.icvf_1_wo(11:90,k) + all_profile.icvf_2_wo(11:90,k))./2;    
    odi_1_control_rh(:,k) = (all_profile.odi_1_wo(11:90,k) + all_profile.odi_2_wo(11:90,k))./2;
    else
    fa_1_glaucoma_rh(:,k-30) = (all_profile.fa1_wo(11:90,k) + all_profile.fa2_wo(11:90,k))./2;    
    md_1_glaucoma_rh(:,k-30) = (all_profile.md1_wo(11:90,k) + all_profile.md2_wo(11:90,k))./2;
    icvf_1_glaucoma_rh(:,k-30) = (all_profile.icvf_1_wo(11:90,k) + all_profile.icvf_2_wo(11:90,k))./2;
    odi_1_glaucoma_rh(:,k-30) = (all_profile.odi_1_wo(11:90,k) + all_profile.odi_2_wo(11:90,k))./2;
    end
end

%% Average left and right hemisphere values
fa_control_avg = (fa_1_control_lh + fa_1_control_rh)./2;
fa_glaucoma_avg = (fa_1_glaucoma_lh + fa_1_glaucoma_rh)./2;
md_control_avg = (md_1_control_lh + md_1_control_rh)./2;
md_glaucoma_avg = (md_1_glaucoma_lh + md_1_glaucoma_rh)./2;
icvf_control_avg = (icvf_1_control_lh + icvf_1_control_rh)./2;
icvf_glaucoma_avg = (icvf_1_glaucoma_lh + icvf_1_glaucoma_rh)./2;
odi_control_avg = (odi_1_control_lh + odi_1_control_rh)./2;
odi_glaucoma_avg = (odi_1_glaucoma_lh + odi_1_glaucoma_rh)./2;

%% Compute mean and std error for group
control_fa_mean = mean(fa_control_avg,1);
control_fa_mean_mean = mean(control_fa_mean);
std_fa_mean = std(control_fa_mean,0,2);
glaucoma_fa_mean = mean(fa_glaucoma_avg,1);
glaucoma_fa_individual = (glaucoma_fa_mean - control_fa_mean_mean)./std_fa_mean;

control_md_mean = mean(md_control_avg,1);
control_md_mean_mean = mean(control_md_mean);
std_md_mean = std(control_md_mean,0,2);
glaucoma_md_mean = mean(md_glaucoma_avg,1);
glaucoma_md_individual = (glaucoma_md_mean - control_md_mean_mean)./std_md_mean;

control_icvf_mean = mean(icvf_control_avg,1);
control_icvf_mean_mean = mean(control_icvf_mean);
std_icvf_mean = std(control_icvf_mean,0,2);
glaucoma_icvf_mean = mean(icvf_glaucoma_avg,1);
glaucoma_icvf_individual = (glaucoma_icvf_mean - control_icvf_mean_mean)./std_icvf_mean;

control_odi_mean = mean(odi_control_avg,1);
control_odi_mean_mean = mean(control_odi_mean);
std_odi_mean = std(control_odi_mean,0,2);
glaucoma_odi_mean = mean(odi_glaucoma_avg,1);
glaucoma_odi_individual = (glaucoma_odi_mean - control_odi_mean_mean)./std_odi_mean;

%% Load visual field test socore data
load ../../Data/VisualFieldTest/Score/Subject_profile.mat
visualfield = (profile.visualfield_lefteye(31:47) + profile.visualfield_righteye(31:47))./2;

% Individual correlation
[r(1,1), p(1,1)] = corr(transpose(glaucoma_fa_individual), transpose(visualfield));
[r(2,1), p(2,1)] = corr(transpose(glaucoma_md_individual), transpose(visualfield));
[r(3,1), p(3,1)] = corr(transpose(glaucoma_icvf_individual), transpose(visualfield));
[r(4,1), p(4,1)] = corr(transpose(glaucoma_odi_individual), transpose(visualfield));

metricNames   = {'FA', 'MD', 'ICVF', 'ODI'};
metricVectors = {glaucoma_fa_individual, glaucoma_md_individual, ...
                 glaucoma_icvf_individual, glaucoma_odi_individual};

figure(); clf
set(gcf,'Position',[100 100 960 960])
Critical = 0.05;                              % 95 % CI
repetition = 1e4;
xticks_plot = [-6 0 6];
yticks_plot = [-30 -20 -10 0 10];
xfig = linspace(xticks_plot(1), xticks_plot(end), 601); % Regression line

for m = 1:4
    subplot(2,2,m); hold on
    xData = metricVectors{m}(:)';
    yData = visualfield(:)';

    % Regression line and CI
    X = [ones(size(xData')) xData'];
    b = regress(yData', X);
    coefBoot = bootstrp(repetition, @regress, yData', X);

    yDown = zeros(size(xfig));
    yUp   = zeros(size(xfig));
    for j = 1:numel(xfig)
        yCand = coefBoot(:,2).*xfig(j) + coefBoot(:,1);
        yCand = sort(yCand);
        yDown(j) = yCand(round(repetition*Critical/2));
        yUp(j)   = yCand(round(repetition*(1-Critical/2)));
    end
    patch([xfig fliplr(xfig)], [yDown fliplr(yUp)], ...
          [1 0.84 0.2], 'EdgeColor','none', 'FaceAlpha',0.4)

    yHat = b(2)*xfig + b(1);
    plot(xfig, yHat, '-', 'LineWidth', 1.5, 'Color', "#C7233B");

    % scatter plot
    scatter(xData, yData, 40, 'o', ...
            'MarkerEdgeColor','#C7233B', 'MarkerFaceColor','none')

    % setting axis
    xlim([xticks_plot(1) xticks_plot(end)])
    ylim([yticks_plot(1) yticks_plot(end)])
    set(gca,'TickDir','out','Box','off', ...
            'XTick',xticks_plot,'YTick',yticks_plot,'FontSize',14)
    axis square

    % label
    xlabel(sprintf('Deviation from control mean\n(with a unit of control SD)', metricNames{m}),'FontSize',14);
    ylabel('Visual field test','FontSize',14);

    % r and p value
    [rVal,pVal] = corr(xData', yData');
    title(sprintf('%s', metricNames{m}),'FontSize',18);
    titletext = ['R = ', num2str(rVal, '%.2f')];
    text(1, -28, titletext, 'fontsize', 20);
    sgtitle('Without Denoising','FontSize',22,'FontWeight','bold');
end
print(gcf, 'VFT_OT_wo.eps', '-depsc', '-painters');
end
