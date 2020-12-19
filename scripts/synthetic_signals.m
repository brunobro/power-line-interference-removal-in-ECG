clear all;
clc;
close;

cd 'C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG';
addpath('C:\Users\Mauro\Documents\MATLAB\ECG');
addpath('C:\Users\Mauro\Documents\MATLAB\');

%Gera um sinal ECG utilizando um modelo dinâmico de ED

Fs = 360; %frequencia de amostragem
len_sig = 60 * Fs; %tamanho do sinal
t = 0:1/Fs:(len_sig/Fs);

noise50 = sin(2*pi*t*50); %50 Hz
noise60 = sin(2*pi*t*60); %60 Hz
noise60_1 = sin(2*pi*t*60 + 45);
noise50_1 = sin(2*pi*t*50 + 120);
noise60_2 = sin(2*pi*t*60 + 11);
noise50_2 = sin(2*pi*t*50 - 37);
noise120 = sin(2*pi*t*120);
noise100 = sin(2*pi*t*100);
noise60_3 = sin(2*pi*t*60 - 228);
noise50_3 = sin(2*pi*t*50 + 189);

Anoise = 0.1;

ecg1 = ecgsyn(Fs, 100, Anoise)';
ecg1 = ecg1(1:len_sig + 1);

ecg2 = ecgsyn(Fs, 115, Anoise, 100)';
ecg2 = ecg2(1:len_sig + 1);

ecg3 = ecgsyn(Fs, 115, Anoise, 45)';
ecg3 = ecg3(1:len_sig + 1);

ecg4 = ecgsyn(Fs, 200, Anoise, 82)';
ecg4 = ecg4(1:len_sig + 1);

ecg5 = ecgsyn(Fs, 200, Anoise, 98)';
ecg5 = ecg5(1:len_sig + 1);

ecg6 = ecgsyn(Fs, 230, Anoise, 142)';
ecg6 = ecg6(1:len_sig + 1);

ecg7 = ecgsyn(Fs, 110, Anoise, 90)';
ecg7 = ecg7(1:len_sig + 1);

ecg8 = ecgsyn(Fs, 120, Anoise, 132)';
ecg8 = ecg8(1:len_sig + 1);

ecg9 = ecgsyn(Fs, 150, Anoise, 71)';
ecg9 = ecg9(1:len_sig + 1);

ecg10 = ecgsyn(Fs, 300, Anoise, 89)';
ecg10 = ecg10(1:len_sig + 1);

ecg11 = ecgsyn(Fs, 90, Anoise, 112)';
ecg11 = ecg11(1:len_sig + 1);
