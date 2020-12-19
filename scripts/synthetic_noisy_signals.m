clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG\scripts';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\scripts');
addpath('E:\PESQUISAS\ECG\Synthetic\Matlab');

%Gera um sinal ECG utilizando um modelo dinâmico de ED

Fs = 500; %frequencia de amostragem
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
noise240 = sin(2*pi*t*240);
noise180 = sin(2*pi*t*180);

Anoise = 0.1;

ecg1 = ecgsyn(Fs, 100, Anoise)';
ecg1 = ecg1(1:len_sig + 1);
SNR1 = 10*log10((var(ecg1)/var(noise50)));
disp(['SNR: ', num2str(SNR1)]);
ecg1_n = ecg1 + noise50;

ecg2 = ecgsyn(Fs, 115, Anoise, 100)';
ecg2 = ecg2(1:len_sig + 1);
SNR2 = 10*log10((var(ecg2)/var(noise60_1 * 0.7)));
disp(['SNR: ', num2str(SNR2)]);
ecg2_n = ecg2 + noise60_1 * 0.7;

ecg3 = ecgsyn(Fs, 115, Anoise, 45)';
ecg3 = ecg3(1:len_sig + 1);
SNR3 = 10*log10((var(ecg3)/var(noise50_1 * 0.2)));
disp(['SNR: ', num2str(SNR3)]);
ecg3_n = ecg3 + noise50_1 * 0.2;

ecg4 = ecgsyn(Fs, 200, Anoise, 82)';
ecg4 = ecg4(1:len_sig + 1);
SNR4 = 10*log10((var(ecg4)/var(noise60_2 * 0.4)));
disp(['SNR: ', num2str(SNR4)]);
ecg4_n = ecg4 + noise60_2 * 0.4;

ecg5 = ecgsyn(Fs, 200, Anoise, 98)';
ecg5 = ecg5(1:len_sig + 1);
SNR5 = 10*log10((var(ecg5)/var(noise50_2 * 0.1)));
disp(['SNR: ', num2str(SNR5)]);
ecg5_n = ecg5 + noise50_2 * 0.1;

ecg6 = ecgsyn(Fs, 230, Anoise, 142)';
ecg6 = ecg6(1:len_sig + 1);
SNR6 = 10*log10((var(ecg6)/var(noise60 * 2.7)));
disp(['SNR: ', num2str(SNR6)]);
ecg6_n = ecg6 + noise60 * 2.7;

ecg7 = ecgsyn(Fs, 110, Anoise, 90)';
ecg7 = ecg7(1:len_sig + 1);
SNR7 = 10*log10((var(ecg7)/var(noise120 * 0.7)));
disp(['SNR: ', num2str(SNR7)]);
ecg7_n = ecg7 + noise120 * 0.7;

ecg8 = ecgsyn(Fs, 120, Anoise, 132)';
ecg8 = ecg8(1:len_sig + 1);
SNR8 = 10*log10((var(ecg8)/var(noise100 * 1.2)));
disp(['SNR: ', num2str(SNR8)]);
ecg8_n = ecg8 + noise100 * 1.2;

ecg9 = ecgsyn(Fs, 150, Anoise, 71)';
ecg9 = ecg9(1:len_sig + 1);
SNR9 = 10*log10((var(ecg9)/var(noise50_3 * 0.3)));
disp(['SNR: ', num2str(SNR9)]);
ecg9_n = ecg9 + noise50_3 * 0.3;

ecg10 = ecgsyn(Fs, 300, Anoise, 89)';
ecg10 = ecg10(1:len_sig + 1);
SNR10 = 10*log10((var(ecg10)/var(noise60_3 * 1.5)));
disp(['SNR: ', num2str(SNR10)]);
ecg10_n = ecg10 + noise60_3 * 1.5;

ecg11 = ecgsyn(Fs, 90, Anoise, 112)';
ecg11 = ecg11(1:len_sig + 1);
SNR11 = 10*log10((var(ecg11)/var(noise50_2 * 7.2)));
disp(['SNR: ', num2str(SNR11)]);
ecg11_n = ecg11 + noise50_2 * 7.2;

ecg12 = ecgsyn(Fs, 75, Anoise, 88)';
ecg12 = ecg12(1:len_sig + 1);
SNR12 = 10*log10((var(ecg12)/var(noise180 * 5.8)));
disp(['SNR: ', num2str(SNR12)]);
ecg12_n = ecg12 + noise180 * 5.8;

ecg13 = ecgsyn(Fs, 98, Anoise, 102)';
ecg13 = ecg13(1:len_sig + 1);
SNR13 = 10*log10((var(ecg13)/var(noise240 * 0.8)));
disp(['SNR: ', num2str(SNR13)]);
ecg13_n = ecg13 + noise240 * 0.8;

ecg14 = ecgsyn(Fs, 98, Anoise, 102)';
ecg14 = ecg14(1:len_sig + 1);
SNR14 = 10*log10((var(ecg14)/var(noise60_3 * 1.4)));
disp(['SNR: ', num2str(SNR14)]);
ecg14_n = ecg14 + noise60_3 * 1.4;

ecg15 = ecgsyn(Fs, 114, Anoise, 143)';
ecg15 = ecg15(1:len_sig + 1);
SNR15 = 10*log10((var(ecg15)/var(noise60_2 * 10.4)));
disp(['SNR: ', num2str(SNR15)]);
ecg15_n = ecg15 + noise60_2 * 10.4;

ecg16 = ecgsyn(Fs, 207, Anoise, 48)';
ecg16 = ecg16(1:len_sig + 1);
SNR16 = 10*log10((var(ecg16)/var(noise50_2 * 3.3)));
disp(['SNR: ', num2str(SNR16)]);
ecg16_n = ecg16 + noise50_2 * 3.3;

ecg17 = ecgsyn(Fs, 305, Anoise, 83)';
ecg17 = ecg17(1:len_sig + 1);
SNR17 = 10*log10((var(ecg17)/var(noise240 * 2.7)));
disp(['SNR: ', num2str(SNR17)]);
ecg17_n = ecg17 + noise240 * 2.7;

ecg18 = ecgsyn(Fs, 114, Anoise, 112)';
ecg18 = ecg18(1:len_sig + 1);
SNR18 = 10*log10((var(ecg18)/var(noise100 * 6.9)));
disp(['SNR: ', num2str(SNR18)]);
ecg18_n = ecg18 + noise100 * 6.9;

ecg19 = ecgsyn(Fs, 201, Anoise, 32)';
ecg19 = ecg19(1:len_sig + 1);
SNR19 = 10*log10((var(ecg19)/var(noise60 * 4.7)));
disp(['SNR: ', num2str(SNR19)]);
ecg19_n = ecg19 + noise60 * 4.7;

ecg20 = ecgsyn(Fs, 201, Anoise, 32)';
ecg20 = ecg20(1:len_sig + 1);
SNR20 = 10*log10((var(ecg20)/var(noise50 * 3.1)));
disp(['SNR: ', num2str(SNR20)]);
ecg20_n = ecg20 + noise50 * 3.1;
