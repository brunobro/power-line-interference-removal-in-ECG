clear all;
clc;
close;

cd 'C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG';
addpath('C:\Users\Mauro\Documents\MATLAB\ECG');
addpath('C:\Users\Mauro\Documents\MATLAB\');
addpath('C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG\synthetic signals');

format long;

wavelet = 'sym8';

load('ecg1_n.mat');
load('ecg1.mat');

ecg_den1 = MyDenoising(ecg1_n, wavelet, 3, 500);

% r1 = corrcoef(ecg1, ecg1_n);
% r2 = corrcoef(ecg1, ecg_den1);
% 
% %trunca os vetores para melhor visualização
% c_ecg_den1 = ecg_den1(1:2500);
% c_ecg1 = ecg1(1:2500);
% c_ecg1_n = ecg1_n(1:2500);
% 
% figure();
% subplot(121);
% scatter(c_ecg1, c_ecg1_n, 5, 'k');
% grid();
% title(strcat('(a)  ', sprintf('  r = %f',r1(2:2))));
% xlabel('Original ECG');
% ylabel('Noisy ECG');
% subplot(122);
% scatter(c_ecg1, c_ecg_den1, 5, 'k');
% grid();
% title(strcat('(b)  ',sprintf('  r = %f',r2(2:2))));
% xlabel('Original ECG');
% ylabel('Denoised ECG');
% 
% print('scatter_compare', '-dpng', '-r300');

figure();
subplot(121);
hist(normr(ecg1_n), 25);
grid();
title(strcat('(a)  ', sprintf('  k = %f',kurtosis(normr(ecg1_n)))));
xlabel('Range');
ylabel('Frequency');
h = findobj(gca,'Type','patch');
set(h,'FaceColor','k','EdgeColor','w')
subplot(122);
hist(normr(ecg_den1), 25);
grid();
title(strcat('(b)  ',sprintf('  k = %f',kurtosis(normr(ecg_den1)))));
xlabel('Range');
ylabel('Frequency');
h = findobj(gca,'Type','patch');
set(h,'FaceColor','k','EdgeColor','w')

print('hist_compare', '-dpng', '-r300');