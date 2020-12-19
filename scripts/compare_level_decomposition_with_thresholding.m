clear all;
clc;
close;

cd 'C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG';
addpath('C:\Users\Mauro\Documents\MATLAB\ECG');
addpath('C:\Users\Mauro\Documents\MATLAB\');
addpath('C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG\synthetic signals');

format long;

wavelet = 'sym10';

load('ecg1_n.mat');
ecg1_n = ecg1;
load('ecg1.mat');
error1 = zeros(1, 10);
for i = 1:10
    ecg_den1 = cmddenoise(ecg1_n, wavelet, i, 'h');
    error1(i) = E(ecg1, ecg_den1);
end

load('ecg6_n.mat');
ecg6_n = ecg6;
load('ecg6.mat');
error6 = zeros(1, 10);
for i = 1:10
    ecg_den6 = cmddenoise(ecg6_n, wavelet, i, 'h');
    error6(i) = E(ecg6, ecg_den6);
end

load('ecg7_n.mat');
ecg7_n = ecg7;
load('ecg7.mat');
error7 = zeros(1, 10);
for i = 1:10
    ecg_den7 = cmddenoise(ecg7_n, wavelet, i, 'h');
    error7(i) = E(ecg7, ecg_den7);
end

load('ecg8_n.mat');
ecg8_n = ecg8;
load('ecg8.mat');
error8 = zeros(1, 10);
for i = 1:10
    ecg_den8 = cmddenoise(ecg8_n, wavelet, i, 'h');
    error8(i) = E(ecg8, ecg_den8);
end

load('ecg10_n.mat');
ecg10_n = ecg10;
load('ecg10.mat');
error10 = zeros(1, 10);
for i = 1:10
    ecg_den10 = cmddenoise(ecg10_n, wavelet, i, 'h');
    error10(i) = E(ecg10, ecg_den10);
end

t = 1:10;

figure;
plot(t, error1, '-x', t, error6, '-x', t, error7, '-x', t, error8, '-x', t, error10, '-x');
grid();
ylabel('Error');
xlabel('Decomposition level');
xlim([1,10]);
legend('s_1 (t)','s_6 (t)','s_7 (t)','s_8 (t)','s_{10} (t)');

print('compare_decomposition_level', '-dpng', '-r300');

