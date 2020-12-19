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

ecg{1} = ecgsyn(Fs, 100)';
ecg{1} = ecg{1}(1:len_sig + 1);
ecg_n{1} = ecg{1} + noise50;

ecg{2} = ecgsyn(Fs, 115, 0, 100)';
ecg{2} = ecg{2}(1:len_sig + 1);
ecg_n{2} = ecg{2} + noise60_1 * 0.7;

ecg{3} = ecgsyn(Fs, 115, 0, 45)';
ecg{3} = ecg{3}(1:len_sig + 1);
ecg_n{3} = ecg{3} + noise50_1 * 0.2;

ecg{4} = ecgsyn(Fs, 200, 0, 82)';
ecg{4} = ecg{4}(1:len_sig + 1);
ecg_n{4} = ecg{4} + noise60_2 * 0.4;

ecg{5} = ecgsyn(Fs, 200, 0, 98)';
ecg{5} = ecg{5}(1:len_sig + 1);
ecg_n{5} = ecg{5} + noise50_2 * 0.1;

ecg{6} = ecgsyn(Fs, 230, 0, 142)';
ecg{6} = ecg{6}(1:len_sig + 1);
ecg_n{6} = ecg{6} + noise60 * 2.7;

ecg{7} = ecgsyn(Fs, 110, 0, 90)';
ecg{7} = ecg{7}(1:len_sig + 1);
ecg_n{7} = ecg{7} + noise120 * 0.7;

ecg{8} = ecgsyn(Fs, 120, 0, 132)';
ecg{8} = ecg{8}(1:len_sig + 1);
ecg_n{8} = ecg{8} + noise100 * 1.2;

ecg{9} = ecgsyn(Fs, 150, 0, 71)';
ecg{9} = ecg{9}(1:len_sig + 1);
ecg_n{9} = ecg{9} + noise50_3 * 0.3;

ecg{10} = ecgsyn(Fs, 300, 0, 89)';
ecg{10} = ecg{10}(1:len_sig + 1);
ecg_n{10} = ecg{10} + noise60_3 * 1.5;

%para reduzir a alocação de memória
clearvars noise50 noise60 noise60_1 noise50_1 noise60_2 noise50_2 noise120 noise100 noise60_3 noise50_3 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Remove o ruído para cada daubechies wavelet                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% level_dec = 3;
% 
% errors_db = cell(19, 1);
% 
% for w = 2:20
%     wavelet = strcat('db', num2str(w));
%     for c = 1:10
%         [coeffs, pos] = wavedec(ecg{c}, level_dec, wavelet);
%         new_coeffs = zeros(length(coeffs));
%         new_coeffs(1:pos(1)) = coeffs(1:pos(1));
%         ecg_denoisy = waverec(new_coeffs, pos, wavelet);
%         errors_db{w - 1} = E(ecg{c}, ecg_denoisy);
%     end
% end
% 
% errors_sym = cell(19, 1);
% 
% for w = 2:20
%     wavelet = strcat('sym', num2str(w));
%     for c = 1:10
%         [coeffs, pos] = wavedec(ecg{c}, level_dec, wavelet);
%         new_coeffs = zeros(length(coeffs));
%         new_coeffs(1:pos(1)) = coeffs(1:pos(1));
%         ecg_denoisy = waverec(new_coeffs, pos, wavelet);
%         errors_sym{w - 1} = E(ecg{c}, ecg_denoisy);
%     end
% end
% 
% disp('Pronto');

% [coeffs, pos] = wavedec(ecg_n{1}, level_dec, 'db2');
% new_coeffs = zeros(length(coeffs));
% new_coeffs(1:pos(1)) = coeffs(1:pos(1));
% ecg_denoisy = waverec(new_coeffs, pos, 'db2');
% disp(['Error: ', num2str(E(ecg{c}, ecg_denoisy))]);
