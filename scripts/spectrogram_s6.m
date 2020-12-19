clear all;
clc;
close;

cd 'C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG';
addpath('C:\Users\Mauro\Documents\MATLAB\ECG');
addpath('C:\Users\Mauro\Documents\MATLAB\');
addpath('C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG\synthetic signals');

format long;

wavelet = 'sym8';
Fs = 500;
window_len = Fs;
length_signal = 3001;

load('ecg6_n.mat');
load('ecg6.mat');
ecg6_n = ecg6_n(1:length_signal);
ecg6 = ecg6(1:length_signal);

ecg_den6 = MyDenoising(ecg6_n, wavelet, 3, window_len);

%calcula as energias dos sinais
e_s6 = sum(ecg6.*2);
e_s6n = sum(ecg6_n.*2);
e_den6 = sum(ecg_den6.*2);

%%% calcula a energia de cada Cycle do ECG %%%
energies_ecg6 = [];
energies_ecg_den6 = [];
step = 210;
ini = 120;
ciclos = [];
count_ciclos = 1;
for i = 120:length(ecg6)
    if ini + step > length(ecg6)
        break;
    end
    e_ecg6 = sum(ecg6(ini:ini + step).^2);
    e_ecg_den6 = sum(ecg_den6(ini:ini + step).^2);
    energies_ecg6 = [energies_ecg6 e_ecg6];
    energies_ecg_den6 = [energies_ecg_den6 e_ecg_den6];
%     fprintf('Cycle %d\n',count_ciclos);
%     fprintf('Energia ECG original: %f\n', e_ecg6);
%     fprintf('Energia ECG estimado: %f\n', e_ecg_den6);
    ciclos = [ciclos; (ini:ini + step)];
    ini = ini + step;
    count_ciclos = count_ciclos + 1;
end
[l, c] = size(ciclos);
ultimo_ciclo = (max(ciclos(l,:)) + 1:length(ecg6));
e_ecg6 = sum(ecg6(ultimo_ciclo).^2);
e_ecg_den6 = sum(ecg_den6(ultimo_ciclo).^2);
energies_ecg6 = [energies_ecg6 e_ecg6];
energies_ecg_den6 = [energies_ecg_den6 e_ecg_den6];
% fprintf('Cycle %d\n',count_ciclos);
% fprintf('Energia ECG original: %f\n', sum(ecg6(ultimo_ciclo).^2));
% fprintf('Energia ECG estimado: %f\n', sum(ecg_den6(ultimo_ciclo).^2));

energies = [energies_ecg6; energies_ecg_den6];

%calcula a diferença média de energia
diff_energies = mean(energies_ecg6 - energies_ecg_den6);

figbar = figure;
bar(energies);
ylabel('Energy');
grid on;
set(gca,'XTickLabel',{'Original ECG', 'Denoised ECG'});
legend('Cycle 1','Cycle 2','Cycle 3','Cycle 4','Cycle 5','Cycle 6','Cycle 7','Cycle 8','Cycle 9','Cycle 10','Cycle 11','Cycle 12','Cycle 13','Cycle 14')


% t = 1/Fs:1/Fs:length_signal/Fs;
% 
% fig = figure;
% subplot(321);plot(t, ecg6,'k');title('(a)');xlabel('Time (s)');ylabel('Amplitude (mV)');xlim([0 length_signal/Fs]);ylim([-0.5 1.5]);grid on;
% subplot(322);spectrogram(ecg6,128,75,4096,Fs,'yaxis');title('(b)');xlabel('Time (s)');
% subplot(323);plot(t, ecg6_n,'k');title('(c)');xlabel('Time (s)');ylabel('Amplitude (mV)');xlim([0 length_signal/Fs]);grid on;
% subplot(324);spectrogram(ecg6_n,128,75,4096,Fs,'yaxis');title('(d)');xlabel('Time (s)');
% subplot(325);plot(t, ecg_den6,'k');title('(e)');xlabel('Time (s)');ylabel('Amplitude (mV)');xlim([0 length_signal/Fs]);ylim([-0.5 1.5]);grid on;
% subplot(326);spectrogram(ecg_den6,128,75,4096,Fs,'yaxis');title('(f)');xlabel('Time (s)');

