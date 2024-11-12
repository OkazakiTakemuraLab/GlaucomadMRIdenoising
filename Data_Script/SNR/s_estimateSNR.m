function s_estimateSNR

% Estimate SNR of b=0 image by using a method proposed by Kida et al.
% (2016).

%% Set up path to toolboxes
addpath(genpath('/home/dtaguma/git/spm8'));
addpath(genpath('/home/dtaguma/git/vistasoft'));
addpath(genpath('/home/dtaguma/git/AFQ'));

baseDir = '/fileserver/project/proj_taguma/GlaucomaData';

%% A list of subject ID 
subjDir{1,47} = {};
l = 1;
for i = 1:30
    n = sprintf('%03d', i);
    subjDir{1,l} = append('Ctl-', n);
    l = l + 1;
end
for i = 1:17
    n = sprintf('%03d', i);
    subjDir{1,l} = append('Glc-', n);
    l = l + 1;
end

for i = 1:length(subjDir)
    
    % Load OT ROI
    l_ot_ap = niftiRead(fullfile(baseDir, subjDir{i}, 'dwi', 'fibers','OT_orig','L_OT_AP.nii.gz'));
    r_ot_ap = niftiRead(fullfile(baseDir, subjDir{i}, 'dwi', 'fibers','OT_orig','R_OT_AP.nii.gz'));
    l_ot_pa = niftiRead(fullfile(baseDir, subjDir{i}, 'dwi', 'fibers','OT_orig','L_OT_PA.nii.gz'));
    r_ot_pa = niftiRead(fullfile(baseDir, subjDir{i}, 'dwi', 'fibers','OT_orig','R_OT_PA.nii.gz'));
 
    ot_roi_ap = l_ot_ap.data + r_ot_ap.data;
    ot_roi_pa = l_ot_pa.data + r_ot_pa.data;

    % Path to DWI data
    %subjDir = fullfile(dataDir, subjDir{i},'dt6');
    dwi_wodenoise_AP = niftiRead(fullfile(baseDir,subjDir{i}, 'dwi_wodenoise','dwi_aligned','dwi_AP','dwi_AP_eddy_unwarped_images_aligned_trilin_noMEC.nii.gz'));
    dwi_wodenoise_PA = niftiRead(fullfile(baseDir,subjDir{i}, 'dwi_wodenoise','dwi_aligned','dwi_PA','dwi_PA_eddy_unwarped_images_aligned_trilin_noMEC.nii.gz'));

    dwi_dwidenoise_AP = niftiRead(fullfile(baseDir,subjDir{i}, 'dwi','preprocessed_AP','dwi_AP','dwi_AP_eddy_unwarped_images_aligned_trilin_noMEC.nii.gz'));
    dwi_dwidenoise_PA = niftiRead(fullfile(baseDir,subjDir{i}, 'dwi','preprocessed_PA','dwi_PA','dwi_PA_eddy_unwarped_images_aligned_trilin_noMEC.nii.gz'));

    bval_wodenoise_AP = dlmread(fullfile(baseDir,subjDir{i}, 'dwi_wodenoise','dwi_aligned','dwi_AP','dwi_AP_eddy_unwarped_images_aligned_trilin_noMEC.bvals'));
    bval_wodenoise_PA = dlmread(fullfile(baseDir,subjDir{i}, 'dwi_wodenoise','dwi_aligned','dwi_PA','dwi_PA_eddy_unwarped_images_aligned_trilin_noMEC.bvals'));

    bval_dwidenoise_AP = dlmread(fullfile(baseDir,subjDir{i}, 'dwi','preprocessed_AP','dwi_AP','dwi_AP_eddy_unwarped_images_aligned_trilin_noMEC.bvals'));
    bval_dwidenoise_PA = dlmread(fullfile(baseDir,subjDir{i}, 'dwi','preprocessed_PA','dwi_PA','dwi_PA_eddy_unwarped_images_aligned_trilin_noMEC.bvals'));
    
    % Find b = 0 file
    b0ind_wodenoise_AP{i} = find(bval_wodenoise_AP == 0);
    b0ind_wodenoise_PA{i} = find(bval_wodenoise_PA == 0);
    b0ind_dwidenoise_AP{i} = find(bval_dwidenoise_AP == 0);
    b0ind_dwidenoise_PA{i} = find(bval_dwidenoise_PA == 0);  

    % Find indiced for b = 0
    ind1(i,1) = b0ind_wodenoise_AP{i}(1);
    ind2(i,1) = b0ind_wodenoise_AP{i}(2);
    ind1(i,2) = b0ind_wodenoise_PA{i}(1);
    ind2(i,2) = b0ind_wodenoise_PA{i}(2);   
    ind1(i,3) = b0ind_dwidenoise_AP{i}(1);
    ind2(i,3) = b0ind_dwidenoise_AP{i}(2);
    ind1(i,4) = b0ind_dwidenoise_PA{i}(1);
    ind2(i,4) = b0ind_dwidenoise_PA{i}(2);   
    
    %% Start calculating b = 0 SNR, without denoising data, AP
    
    % Extract b = 0 images
    b0_1 = dwi_wodenoise_AP;
    b0_1.data = dwi_wodenoise_AP.data(:,:,:,ind1(i,1));
    b0_1_fname = 'b0_1';
    
    b0_2 = dwi_wodenoise_AP;
    b0_2.data = dwi_wodenoise_AP.data(:,:,:,ind2(i,1));
    b0_2_fname = 'b0_2';
    
    % Substraction between two images
    b0_subs.data = b0_1.data - b0_2.data;
        
    % Find OT voxels
    [r,c,v] = ind2sub(size(ot_roi_ap), find(ot_roi_ap==1));
    
    for k = 1:length(r)
        signalintensity(k) = b0_1.data(r(k),c(k),v(k));
        substraction(k) = b0_subs.data(r(k),c(k),v(k));
    end
    
    % SNR estimation following a formula from Kida et al. (2016)
    mean_signal = mean(signalintensity);
    sd_subs = std(single(substraction),0,2);
    b0SNR(i,1) = sqrt(2)*mean_signal/sd_subs;

    clear signalintensity mean_subs substraction r c v k b0_subs b0_1 b0_2

    %% Start calculating b = 0 SNR, without denoising data, PA
    
    % Extract b = 0 images
    b0_1 = dwi_wodenoise_PA;
    b0_1.data = dwi_wodenoise_PA.data(:,:,:,ind1(i,2));
    b0_1_fname = 'b0_1';
    
    b0_2 = dwi_wodenoise_PA;
    b0_2.data = dwi_wodenoise_PA.data(:,:,:,ind2(i,2));
    b0_2_fname = 'b0_2';
    
    % Substraction between two images
    b0_subs.data = b0_1.data - b0_2.data;
        
    % Find OT voxels
    [r,c,v] = ind2sub(size(ot_roi_pa), find(ot_roi_pa==1));
    
    for k = 1:length(r)
        signalintensity(k) = b0_1.data(r(k),c(k),v(k));
        substraction(k) = b0_subs.data(r(k),c(k),v(k));
    end
    
    % SNR estimation following a formula from Kida et al. (2016)
    mean_signal = mean(signalintensity);
    sd_subs = std(single(substraction),0,2);
    b0SNR(i,2) = sqrt(2)*mean_signal/sd_subs;

    clear signalintensity mean_subs substraction r c v k b0_subs b0_1 b0_2

    %% Start calculating b = 0 SNR, with dwidenoise, AP
    
    % Extract b = 0 images
    b0_1 = dwi_dwidenoise_AP;
    b0_1.data = dwi_dwidenoise_AP.data(:,:,:,ind1(i,3));
    b0_1_fname = 'b0_1';
    
    b0_2 = dwi_dwidenoise_AP;
    b0_2.data = dwi_dwidenoise_AP.data(:,:,:,ind2(i,3));
    b0_2_fname = 'b0_2';
    
    % Substraction between two images
    b0_subs.data = b0_1.data - b0_2.data;
        
    % Find OT voxels
    [r,c,v] = ind2sub(size(ot_roi_ap), find(ot_roi_ap==1));
    
    for k = 1:length(r)
        signalintensity(k) = b0_1.data(r(k),c(k),v(k));
        substraction(k) = b0_subs.data(r(k),c(k),v(k));
    end
    
    % SNR estimation following a formula from Kida et al. (2016)
    mean_signal = mean(signalintensity);
    sd_subs = std(single(substraction),0,2);
    b0SNR(i,3) = sqrt(2)*mean_signal/sd_subs;

    clear signalintensity mean_subs substraction r c v k b0_subs b0_1 b0_2

    %% Start calculating b = 0 SNR, with dwidenoise, PA
    
    % Extract b = 0 images
    b0_1 = dwi_dwidenoise_PA;
    b0_1.data = dwi_dwidenoise_PA.data(:,:,:,ind1(i,4));
    b0_1_fname = 'b0_1';
    
    b0_2 = dwi_dwidenoise_PA;
    b0_2.data = dwi_dwidenoise_PA.data(:,:,:,ind2(i,4));
    b0_2_fname = 'b0_2';
    
    % Substraction between two images
    b0_subs.data = b0_1.data - b0_2.data;
        
    % Find OT voxels
    [r,c,v] = ind2sub(size(ot_roi_pa), find(ot_roi_pa==1));
    
    for k = 1:length(r)
        signalintensity(k) = b0_1.data(r(k),c(k),v(k));
        substraction(k) = b0_subs.data(r(k),c(k),v(k));
    end
    
    % SNR estimation following a formula from Kida et al. (2016)
    mean_signal = mean(signalintensity);
    sd_subs = std(single(substraction),0,2);
    b0SNR(i,4) = sqrt(2)*mean_signal/sd_subs;

    clear signalintensity mean_subs substraction r c v k b0_subs b0_1 b0_2        
     
end
savefilename = 'b0SNR_estimate.mat';
save(savefilename, 'b0SNR');
    keyboard


%%
figure
h = histogram(b0SNR)
hold on
plot(mean(b0SNR),max(h.Values)+5,'v','MarkerSize',14) 
hold off
box off
xlim([10 25]);
ylim([0 50])
set(gca,'xtick',[10 17.5 25],'FontSize',15);
set(gca,'ytick',[0 25 50],'FontSize',15);
xlabel('SNR','FontSize',18,'FontName','Helvetica')
ylabel('Number of Subject','FontSize',18,'FontName','Helvetica')

mean(b0SNR)
%save('b0SNR','b0SNR')

