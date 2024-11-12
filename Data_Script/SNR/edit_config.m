function edit_config

load LOR.mat b0SNR


field1 = b0SNR(:, 1)';
field2 = b0SNR(:, 2)';
field3 = b0SNR(:, 3)';
field4 = b0SNR(:, 4)';

all_SNR = struct('SNR1_wo', field1, 'SNR2_wo', field2, 'SNR1_MPPCA', field3, 'SNR2_MPPCA', field4);

save('LOR_EstimatedSNR.mat', 'all_SNR');

end

