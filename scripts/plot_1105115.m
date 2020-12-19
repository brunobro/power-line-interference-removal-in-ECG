clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG\scripts';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\true signals');

format long;

wavelet = 'sym8';
level_dec = 3;
shrinkage_rule = 'h'; % s, h
thr_selection_rule = 'sqtwolog'; % rigrsure, sqtwolog, heursure, minimaxi
Fs = 500;
length_signal = 5000;
window_len = 1000;

RECORD = '1105115m_leadV2';

load(strcat(RECORD, '.mat'));

val = val/max(abs(val));

ecg_den_thr = wden(val, thr_selection_rule, shrinkage_rule, 'mln', level_dec, wavelet);
ecg_den_my  = MyDenoising(val, 'sym8', 3, window_len);
ecg_den_nf  = Notch(val, Fs, 0.01, 60, 10);

xmin = 900;
xmax = 1600;
xminf = 0;
xmaxf = 2;
max_freq = 200;
t = 1/Fs:1/Fs:4 + 1/Fs;

figure(1);
subplot(421);plot(t, val(3000:5000),'k');xlim([xminf, xmaxf]);title('(a)');grid on;
subplot(422);spectrogram(val(3000:5000),128,75,1024,Fs,'yaxis');title('(b)');colorbar();ylim([0, max_freq]);xlim([xminf xmaxf]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');

subplot(423);plot(t, ecg_den_my(3000:5000),'k');xlim([xminf, xmaxf]);title('(c)');grid on;
subplot(424);spectrogram(ecg_den_my(3000:5000),128,75,1024,Fs,'yaxis');title('(d)');colorbar();ylim([0, max_freq]);xlim([xminf xmaxf]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');

subplot(425);plot(t, ecg_den_thr(3000:5000),'k');xlim([xminf, xmaxf]);title('(e)');grid on;
subplot(426);spectrogram(ecg_den_thr(3000:5000),128,75,1024,Fs,'yaxis');title('(f)');colorbar();ylim([0, max_freq]);xlim([xminf xmaxf]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');

subplot(427);plot(t, ecg_den_nf(3000:5000),'k');xlim([xminf, xmaxf]);title('(g)');grid on;
text(-0.6, 0.16, 'Amplitude (mV)', 'Rotation', 90, 'FontSize', 11);
text(2.2, 0.16, 'Frequency (Hz)', 'Rotation', 90, 'FontSize', 11);
text(2, -0.11, 'Time (s)', 'FontSize', 11);

subplot(428);spectrogram(ecg_den_nf(3000:5000),128,75,1024,Fs,'yaxis');title('(h)');colorbar();ylim([0, max_freq]);xlim([xminf xmaxf]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');


print('1105115_plot', '-dpng', '-r500');
