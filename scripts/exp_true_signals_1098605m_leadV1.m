clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\true signals');

format long;

wavelet = 'sym8';
Fs = 500;
window_len = Fs;
length_signal = 5000;

RECORD = '1098605m_leadV1';

load(strcat(RECORD, '.mat'));

ecg_den = MyDenoising(val, wavelet, 3, window_len);

figure();
plot(val(640:690),'k');grid on;xlim([0, 50]);

print(strcat('qrs_noisy_',RECORD), '-dpng', '-r300');

figure();
plot(ecg_den(640:690),'k');grid on;xlim([0, 50]);

print(strcat('qrs_denoised_PM_',RECORD), '-dpng', '-r300');
