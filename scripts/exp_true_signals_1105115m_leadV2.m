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

RECORD = '1105115m_leadV2';

load(strcat(RECORD, '.mat'));

ecg_den = MyDenoising(val, wavelet, 3, window_len);

figure();
plot(val(4340:4390),'k');grid on;xlim([0, 50]);

print(strcat('qrs_noisy_',RECORD), '-dpng', '-r300');

figure();
plot(ecg_den(4340:4390),'k');grid on;xlim([0, 50]);

print(strcat('qrs_denoised_PM_',RECORD), '-dpng', '-r300');
