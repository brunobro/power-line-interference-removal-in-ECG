clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG\scripts\';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\scripts\synthetic signals');
addpath('E:\PESQUISAS\Matlab');


load('ecg1_n.mat');
load('ecg1.mat');

load('ecg2_n.mat');
load('ecg2.mat');

load('ecg3_n.mat');
load('ecg3.mat');

load('ecg4_n.mat');
load('ecg4.mat');

load('ecg5_n.mat');
load('ecg5.mat');

load('ecg6_n.mat');
load('ecg6.mat');

load('ecg7_n.mat');
load('ecg7.mat');

load('ecg8_n.mat');
load('ecg8.mat');

load('ecg9_n.mat');
load('ecg9.mat');

load('ecg10_n.mat');
load('ecg10.mat');

load('ecg11_n.mat');
load('ecg11.mat');

load('ecg12_n.mat');
load('ecg12.mat');

load('ecg13_n.mat');
load('ecg13.mat');

load('ecg14_n.mat');
load('ecg14.mat');

load('ecg15_n.mat');
load('ecg15.mat');

load('ecg16_n.mat');
load('ecg16.mat');

load('ecg17_n.mat');
load('ecg17.mat');

load('ecg18_n.mat');
load('ecg18.mat');

load('ecg19_n.mat');
load('ecg19.mat');

load('ecg20_n.mat');
load('ecg20.mat');

figure();
subplot(211);
plot(ecg1);
xlim([0 3000]);
title('Synthetic ECG 1');
xlabel('Sample');
ylabel('Amplitude (mV)');
grid 'on';
subplot(212);
plot(ecg1_n);
xlim([0 3000]);
title('Noisy ECG 1');
xlabel('Sample');
ylabel('Amplitude (mV)');
grid 'on';

print('synthetic signals\ecg1_plot', '-dpng', '-r300');
