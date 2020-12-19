clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\true signals');

format long;

wavelet = 'sym8';
level_dec = 3;
shrinkage_rule = 'h'; % s, h
thr_selection_rule = 'sqtwolog'; % rigrsure, sqtwolog, heursure, minimaxi
Fs = 500;
length_signal = 5000;

RECORD = '1138505m_leadI';

load(strcat(RECORD, '.mat'));

ecg_den = wden(val, thr_selection_rule, shrinkage_rule, 'mln', level_dec, wavelet);

figure();
plot(ecg_den(1150:1200),'k');grid on;xlim([0, 50]);

print(strcat('qrs_denoised_TT_',RECORD), '-dpng', '-r300');
