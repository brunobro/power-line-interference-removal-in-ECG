clear all;
clc;


cd 'E:\ARTIGOS\Denoising 60Hz ECG\scripts';
addpath('E:\PESQUISAS\ECG\Synthetic\Matlab');

%Gera um sinal ECG utilizando um modelo dinâmico de ED

Fs = 500; %frequencia de amostragem
len_sig = 2 * Fs; %tamanho do sinal
t = 0:1/Fs:(len_sig/Fs);

ti = [-70 -15 0 15 100];
ai = [1.2 -5 30 -7.5 0.75];
bi = [0.25 0.1 0.1 0.1 0.4];

ecg = ecgsyn(Fs, 115, 0, 100, 1, 0.5, Fs, ti, ai, bi)';
ecg = ecg(1:len_sig + 1);

figure();
plot(ecg);
grid 'on';

