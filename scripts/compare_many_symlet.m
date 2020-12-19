clear all;
clc;
close;

cd 'C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG';
addpath('C:\Users\Mauro\Documents\MATLAB\ECG');
addpath('C:\Users\Mauro\Documents\MATLAB\');
addpath('C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG\errors_symlet');

load('errors_s10.mat');
load('errors_s8.mat');
load('errors_s7.mat');
load('errors_s6.mat');
load('errors_s1.mat');

t = 1:length(errors_s10);

figure;
plot(t, errors_s1, t, errors_s6, t, errors_s7, t, errors_s8, t, errors_s10);
grid();
ylabel('Error');
xlabel('Symlet wavelet');
xlim([2,30]);
legend('s_1 (t)','s_6 (t)','s_7 (t)','s_8 (t)','s_{10} (t)');

print('compare_many_symlet', '-dpng', '-r300');
