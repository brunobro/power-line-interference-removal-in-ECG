clear all;
clc;
close;

cd 'C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG';
addpath('C:\Users\Mauro\Documents\MATLAB\ECG');
addpath('C:\Users\Mauro\Documents\MATLAB\');

%Gera um sinal ECG utilizando um modelo dinâmico de ED

Fs = 500; %frequencia de amostragem
len_sig = 5 * Fs; %tamanho do sinal
t = 0:1/Fs:(len_sig/Fs);

ecg = ecgsyn(Fs, 100, 0.05)';
ecg = ecg(1:len_sig + 1);

plot(t, ecg, 'k');
xlabel('Time (s)');
ylabel('Amplitude (mV)');
xlim([0 5]);
grid on;

print('exp_synthetic_signal', '-dpng', '-r300');

