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

load('1007823m_leadII.mat');

ecg_den = wden(val, thr_selection_rule, shrinkage_rule, 'mln', level_dec, wavelet);

%computa as medidas
r = corrcoef(val, ecg_den);
r = r(2:2);

energySQI     = eSQI(val, Fs);
energySQI_den = eSQI(ecg_den, Fs);
highfSQI = hfSQI(val, Fs);
highfSQI_den = hfSQI(ecg_den, Fs);
stdSQI = rsdSQI(val, Fs);
stdSQI_den = rsdSQI(ecg_den, Fs);

%periodogramas
[pxx1, f1] = pwelch(val, 128, 50, 2048, Fs);
[pxx2, f2] = pwelch(ecg_den, 128, 50, 2048, Fs);

%calcula a potência acima de 30Hz
plog_den = 10*log10(pxx2);
power_den = sum(plog_den(30:length(pxx2)));

plog = 10*log10(pxx1);
power = sum(plog(30:length(pxx1)));

t = 1/Fs:1/Fs:length_signal/Fs;

fig = figure;
subplot(221);plot(val,'k');title('(a)');xlabel('Time (s)');ylabel('Amplitude (undefined)');grid on;
subplot(222);plot(f1, plog,'k');title('(b)');xlabel('Frequency (Hz)');ylabel('Power (dB)');grid on;
subplot(223);plot(ecg_den,'k');title('(c)');xlabel('Time (s)');ylabel('Amplitude (undefined)');grid on;
subplot(224);plot(f2, plog_den,'k');title('(d)');xlabel('Frequency (Hz)');ylabel('Power (dB)');grid on;
