clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG\scripts';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\scripts\synthetic signals');

format long;

wavelet = 'sym8';
Fs = 500;
window_len = 1000;
length_signal = 3001;

%load ECG signal
load('ecg15_n.mat');
load('ecg15.mat');
ecg15_n = ecg15_n(1:length_signal);
ecg15 = ecg15(1:length_signal);

%Denoising proposed method
ecg_den15 = MyDenoising(ecg15_n, wavelet, 3, window_len);

%Denoising by notch filter
ecg_den15_NF = Notch(ecg15_n, Fs, 0.005, 60, 5);

%Denoising by thresholding
level_dec = 3;
shrinkage_rule = 'h'; % s, h
thr_selection_rule = 'sqtwolog'; % rigrsure, sqtwolog, heursure, minimaxi

ecg_den15_TT = wden(ecg15_n, thr_selection_rule, shrinkage_rule, 'mln', level_dec, wavelet);

%calcula as energias dos sinais
fprintf('Energy - raw ECG: %f\n', sum(ecg15.^2));
fprintf('Energy - noisy ECG: %f\n', sum(ecg15_n.^2));
fprintf('Energy - denoised PM ECG: %f\n', sum(ecg_den15.^2));
fprintf('Energy - denoised TT ECG: %f\n', sum(ecg_den15_TT.^2));
fprintf('Energy - denoised NF ECG: %f\n\n', sum(ecg_den15_NF.^2));

%% calcula a energia de cada Cycle do ECG %%%
energies_ecg15 = [];
energies_ecg_den15 = [];
energies_ecg_den15_TT = [];
energies_ecg_den15_NF = [];

spec_cycle_PM = [];
spec_cycle_TT = [];
spec_cycle_NF = [];

step = 210;
ini = 94;
ciclos = [];
count_ciclos = 1;
for i = 120:length(ecg15)
    if ini + step > length(ecg15)
        break;
    end
    
    e_ecg15 = sum(ecg15(ini:ini + step).^2);
    e_ecg_den15 = sum(ecg_den15(ini:ini + step).^2);
    e_ecg_den15_TT = sum(ecg_den15_TT(ini:ini + step).^2);
    e_ecg_den15_NF = sum(ecg_den15_NF(ini:ini + step).^2);
    
    [pxx1, f1] = pwelch(ecg_den15(ini:ini + step), 128, 50, 2048, Fs);
    power_den_PM = sum(10*log10(pxx1(50:70)));
    
    [pxx2, f2]  = pwelch(ecg_den15_TT(ini:ini + step), 128, 50, 2048, Fs);
    power_den_TT = sum(10*log10(pxx2(50:70)));
    
    [pxx3, f3]  = pwelch(ecg_den15_NF(ini:ini + step), 128, 50, 2048, Fs);
    power_den_NF = sum(10*log10(pxx3(50:70)));
    
    energies_ecg15 = [energies_ecg15 e_ecg15];
    energies_ecg_den15 = [energies_ecg_den15 e_ecg_den15];
    energies_ecg_den15_TT = [energies_ecg_den15_TT e_ecg_den15_TT];
    energies_ecg_den15_NF = [energies_ecg_den15_NF e_ecg_den15_NF];
    
    spec_cycle_PM = [spec_cycle_PM power_den_PM];
    spec_cycle_TT = [spec_cycle_TT power_den_TT];
    spec_cycle_NF = [spec_cycle_NF power_den_NF];
    
    fprintf('Cycle %d\n',count_ciclos);
    fprintf('Energia ECG original: %f\n', e_ecg15);
    fprintf('Energia ECG estimado PM: %f\n', e_ecg_den15);
    fprintf('Energia ECG estimado TT: %f\n', e_ecg_den15_TT);
    fprintf('Energia ECG estimado NF: %f\n\n', e_ecg_den15_NF);
    fprintf('Energia (50-60)Hz ECG estimado PM: %f\n', e_ecg_den15);
    fprintf('Energia (50-60)Hz ECG estimado TT: %f\n', e_ecg_den15_TT);
    fprintf('Energia (50-60)Hz ECG estimado NF: %f\n', e_ecg_den15_NF);
    
    ciclos = [ciclos; (ini:ini + step)];
    ini = ini + step;
    count_ciclos = count_ciclos + 1;
end
% [l, c] = size(ciclos);
% ultimo_ciclo = (max(ciclos(l,:)) + 1:length(ecg15));
% 
% e_ecg15 = sum(ecg15(ultimo_ciclo).^2);
% e_ecg_den15 = sum(ecg_den15(ultimo_ciclo).^2);
% e_ecg_den15_TT = sum(ecg_den15_TT(ultimo_ciclo).^2);
% 
% energies_ecg15 = [energies_ecg15];
% energies_ecg_den15 = [energies_ecg_den15];
% energies_ecg_den15_TT = [energies_ecg_den15_TT];
% 
% 
% fprintf('Cycle %d\n',count_ciclos);
% fprintf('Energia ECG original: %f\n', sum(ecg15(ultimo_ciclo).^2));
% fprintf('Energia ECG estimado PM: %f\n', sum(ecg_den15(ultimo_ciclo).^2));
% fprintf('Energia ECG estimado TT: %f\n\n', sum(ecg_den15_TT(ultimo_ciclo).^2));

energies = [energies_ecg15; energies_ecg_den15];

%calcula a diferença média de energia
fprintf('Difference of energy - Cycle PM: %f\n', mean(energies_ecg15 - energies_ecg_den15));
fprintf('Difference of energy - Cycle TT: %f\n', mean(energies_ecg15 - energies_ecg_den15_TT));
fprintf('Difference of energy - Cycle NF: %f\n', mean(energies_ecg15 - energies_ecg_den15_NF));

% figbar = figure;
% bar(energies);
% ylabel('Energy');
% grid on;
% set(gca,'XTickLabel',{'Original ECG', 'Denoised ECG'});
% legend('Cycle 1','Cycle 2','Cycle 3','Cycle 4','Cycle 5','Cycle 15','Cycle 7','Cycle 8','Cycle 9','Cycle 10','Cycle 11','Cycle 12','Cycle 13','Location','eastoutside','Orientation','vertical');
% 
% print('cycles', '-dpng', '-r300');


t = 1/Fs:1/Fs:length_signal/Fs;

%periodogramas
[pxx1, f1] = pwelch(ecg15, 128, 50, 2048, Fs);
[pxx2, f2] = pwelch(ecg15_n, 128, 50, 2048, Fs);
[pxx3, f3] = pwelch(ecg_den15, 128, 50, 2048, Fs);
[pxx4, f4] = pwelch(ecg_den15_TT, 128, 50, 2048, Fs);
[pxx5, f5] = pwelch(ecg_den15_NF, 128, 50, 2048, Fs);

%calcula a potência acima de 30Hz
plog = 10*log10(pxx1);
plog_n = 10*log10(pxx2);
plog_den = 10*log10(pxx3);
plog_den_TT = 10*log10(pxx4);
plog_den_NF = 10*log10(pxx5);


max_freq = 100;
max_time = 2;

% fig = figure;
% subplot(531);plot(t, ecg15,'k');xlabel('Time (s)','FontSize',9);ylabel('Amplitude (mV)','FontSize',9);xlim([0 max_time]);ylim([-0.5 1.5]);grid on;title('(a)');
% subplot(532);spectrogram(ecg15,128,75,1024,Fs,'yaxis');title('(b)');colorbar();xlabel('Time (s)','FontSize',9);ylabel('Frequency (Hz)','FontSize',9);ylim([0, max_freq]);xlim([0 max_time]);
% subplot(533);plot(f1, plog,'k');title('(c)');xlabel('Frequency (Hz)','FontSize',9);ylabel('Power (dB)','FontSize',9);grid on;xlim([0, max_freq]);
% 
% subplot(534);plot(t, ecg15_n,'k');xlabel('Time (s)','FontSize',9);ylabel('Amplitude (mV)','FontSize',9);xlim([0 max_time]);grid on;title('(d)');
% subplot(535);spectrogram(ecg15_n,128,75,1024,Fs,'yaxis');title('(e)');colorbar();xlabel('Time (s)','FontSize',9);ylabel('Frequency (Hz)','FontSize',9);ylim([0, max_freq]);xlim([0 max_time]);
% subplot(536);plot(f2, plog_n,'k');title('(f)');xlabel('Frequency (Hz)','FontSize',9);ylabel('Power (dB)','FontSize',9);grid on;xlim([0, max_freq]);
% 
% subplot(537);plot(t, ecg_den15,'k');xlabel('Time (s)','FontSize',9);ylabel('Amplitude (mV)','FontSize',9);xlim([0 max_time]);ylim([-0.5 1.5]);grid on;title('(g)');
% subplot(538);spectrogram(ecg_den15,128,75,1024,Fs,'yaxis');title('(h)');colorbar();xlabel('Time (s)','FontSize',9);ylabel('Frequency (Hz)','FontSize',9);ylim([0, max_freq]);xlim([0 max_time]);
% subplot(539);plot(f3, plog_den,'k');title('(i)');xlabel('Frequency (Hz)','FontSize',9);ylabel('Power (dB)','FontSize',9);grid on;xlim([0, max_freq]);
% 
% subplot(5,3,10);plot(t, ecg_den15_TT,'k');xlabel('Time (s)','FontSize',9);ylabel('Amplitude (mV)','FontSize',9);xlim([0 max_time]);ylim([-0.5 1.5]);grid on;title('(j)');
% subplot(5,3,11);spectrogram(ecg_den15_TT,128,75,1024,Fs,'yaxis');title('(l)');colorbar();xlabel('Time (s)','FontSize',9);ylabel('Frequency (Hz)','FontSize',9);ylim([0, max_freq]);xlim([0 max_time]);
% subplot(5,3,12);plot(f4, plog_den_TT,'k');title('(m)');xlabel('Frequency (Hz)','FontSize',9);ylabel('Power (dB)','FontSize',9);grid on;xlim([0, max_freq]);
% 
% subplot(5,3,13);plot(t, ecg_den15_NF,'k');xlabel('Time (s)','FontSize',9);ylabel('Amplitude (mV)','FontSize',9);xlim([0 max_time]);ylim([-0.5 1.5]);grid on;title('(n)');
% subplot(5,3,14);spectrogram(ecg_den15_NF,128,75,1024,Fs,'yaxis');title('(o)');colorbar();xlabel('Time (s)','FontSize',9);ylabel('Frequency (Hz)','FontSize',9);ylim([0, max_freq]);xlim([0 max_time]);
% subplot(5,3,15);plot(f5, plog_den_NF,'k');title('(p)');xlabel('Frequency (Hz)','FontSize',9);ylabel('Power (dB)','FontSize',9);grid on;xlim([0, max_freq]);

%titles_plot = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(h)','(i)','(j)','(l)','(m)'};
%ax = flipdim(findobj(fig, 'Type', 'Axes'), 1);
%for i = 1:length(ax)
%    title(ax(i), titles_plot{i}, 'FontWeight' , 'bold', 'FontSize', 10);
    %xlabel(ax(i), 'Time (s)', 'FontSize', 9);
    %ylabel(ax(i), 'Amplitude (mV)', 'FontSize', 9);
%end

figure(1);
subplot(521);plot(t, ecg15,'k');title('(a)');grid on;xlim([0 max_time]);ylim([-0.5 1.5]);
subplot(522);spectrogram(ecg15,128,75,1024,Fs,'yaxis');title('(b)');colorbar();ylim([0, max_freq]);xlim([0 max_time]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');

subplot(523);plot(t, ecg15_n,'k');title('(c)');grid on;xlim([0 max_time]);
subplot(524);spectrogram(ecg15_n,128,75,1024,Fs,'yaxis');title('(d)');colorbar();ylim([0, max_freq]);xlim([0 max_time]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');

subplot(525);plot(t, ecg_den15,'k');title('(e)');grid on;xlim([0 max_time]);ylim([-0.5 1.5]);
subplot(526);spectrogram(ecg_den15,128,75,1024,Fs,'yaxis');title('(f)');colorbar();ylim([0, max_freq]);xlim([0 max_time]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');

subplot(527);plot(t, ecg_den15_TT,'k');title('(g)');grid on;xlim([0 max_time]);ylim([-0.5 1.5]);
subplot(528);spectrogram(ecg_den15_TT,128,75,1024,Fs,'yaxis');title('(h)');colorbar();ylim([0, max_freq]);xlim([0 max_time]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');

subplot(529);plot(t, ecg_den15_NF,'k');title('(i)');grid on;xlim([0 max_time]);ylim([-0.5 1.5]);
text(-0.6, 5.76, 'Amplitude (mV)', 'Rotation', 90, 'FontSize', 11);
text(2.2, 5.76, 'Frequency (Hz)', 'Rotation', 90, 'FontSize', 11);
text(2, -2.10, 'Time (s)', 'FontSize', 11);

subplot(5,2,10);spectrogram(ecg_den15_NF,128,75,1024,Fs,'yaxis');title('(j)');colorbar();ylim([0, max_freq]);xlim([0 max_time]);
set(get(gca, 'Ylabel'), 'Visible', 'off');
set(get(gca, 'Xlabel'), 'Visible', 'off');

print('spectrogram_s15', '-dpng', '-r600');

% s = 120;
% e = 321;
% t = s/Fs:1/Fs:e/Fs;
% 
% fig1 = figure;
% %legend('Original QRS', 'Denoised QRS proposed method', 'Denoised QRS thresholding technique');
% 
% subplot(311);
% plot(t, ecg15(s:e), 'k');
% title('(a)');
% xlabel('Time (s)');
% ylabel('Amplitude (mV)');
% xlim([min(t) max(t)]);
% grid on;
% 
% subplot(312);
% plot(t, ecg_den15(s:e), 'k');
% title('(b)');
% xlabel('Time (s)');
% ylabel('Amplitude (mV)');
% xlim([min(t) max(t)]);
% grid on;
% 
% subplot(313);
% plot(t, ecg_den15_TT(s:e), 'k');
% title('(c)');
% xlabel('Time (s)');
% ylabel('Amplitude (mV)');
% xlim([min(t) max(t)]);
% grid on;
% 
% print('compare_QRS_s15', '-dpng', '-r300');

