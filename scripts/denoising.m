%Apenas para visualização dos resultados. Gera os gráficos

clear all;
clc;
close;

cd 'C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG';
addpath('C:\Users\Mauro\Documents\MATLAB\ECG');
addpath('C:\Users\Mauro\Documents\MATLAB\');
addpath('C:\Users\Mauro\Documents\ARTIGOS\Denosing ECG\synthetic signals');

%% Parametros %%
Fs = 360;
len_sig = 5 * Fs;
t = 1/Fs:1/Fs:(len_sig/Fs);
wavelet = 'sym22';

%% Carrega os sinais %%
load('ecg2_n.mat');
ecg_noisy = ecg2(1:len_sig);
load('ecg2.mat');
ecg = ecg2(1:len_sig);

%% Remove o ruído %%

%ecg_denoising = MyDenoising(ecg_noisy, wavelet, 3);
[coeffs, pos] = wavedec(ecg_noisy, 3, wavelet);
new_coeffs = zeros(length(coeffs));
new_coeffs(1:pos(1)) = coeffs(1:pos(1));
ecg_denoising = waverec(new_coeffs, pos, wavelet);

%% Exibe os resultados %%

%Resultado da Decomposição
titles_plot = {'(a)','(b)','(c)','(d)','(e)'};

fig0 = figure(1);
subplot(511);
plot(ecg_noisy, 'k');
xlim([0 length(ecg_noisy)]);
subplot(512);
plot(coeffs(1:pos(1)),'k');
xlim([0 length(coeffs(1:pos(1)))]);
subplot(513);
plot(coeffs(pos(2):pos(3)),'k');
xlim([0 length(coeffs(pos(2):pos(3)))]);
subplot(514);
plot(coeffs(pos(3):pos(4)),'k');
xlim([0 length(coeffs(pos(3):pos(4)))]);
subplot(515);
plot(coeffs(pos(4):pos(5)),'k');
xlim([0 length(coeffs(pos(4):pos(5)))]);

ax = flipdim(findobj(fig0, 'Type', 'Axes'), 1);
for i = 1:length(ax)
    title(ax(i), titles_plot{i}, 'FontWeight' , 'bold', 'FontSize', 10);
    xlabel(ax(i), 'Sample', 'FontSize', 9);
    ylabel(ax(i), 'Amplitude', 'FontSize', 9);
    grid(ax(i));
end

print('decomposition', '-dpng', '-r300');

%Resultado da remoção do Ruído

%periodogramas
[pxx1, w1] = periodogram(ecg, [], length(ecg), Fs);
[pxx2, w2] = periodogram(ecg_noisy, [], length(ecg_noisy), Fs);
[pxx3, w3] = periodogram(ecg_denoising, [], length(ecg_denoising), Fs);

%titles_plot = {'Original ECG'; 'Periodogram Original ECG'; 'Noisy ECG'; 'Periodogram Noisy ECG'; 'Denoisy ECG'; 'Periodogram Denoisy ECG'};
titles_plot{1,6} = {'(f)'};

fig1 = figure(2);
subplot(321);
p1 = plot(t, ecg, 'k');
subplot(322);
p2 = plot(w1, 10*log10(pxx1), 'k');
subplot(323);
p3 = plot(t, ecg_noisy, 'k');
subplot(324);
p4 = plot(w2, 10*log10(pxx2), 'k');
subplot(325);
p5 = plot(t, ecg_denoising, 'k');
subplot(326);
p6 = plot(w3, 10*log10(pxx3), 'k');

ax = flipdim(findobj(fig1, 'Type', 'Axes'), 1);
for i = 1:length(ax)
    title(ax(i), titles_plot{i}, 'FontWeight' , 'bold', 'FontSize', 10);
    if rem(i, 2) == 0
        tx = 'Frequency (Hz)';
        ty = 'Power (dB)';
        xlim(ax(i), [0 Fs/2]);
    else
        tx = 'Time (sec)';
        ty = 'Amplitude (mV)';
        xlim(ax(i), [0 max(t)]);
    end
    xlabel(ax(i), tx, 'FontSize', 9);
    ylabel(ax(i), ty, 'FontSize', 9);
    %ylim(ax(i), [min(ecg), max(ecg)]);
    grid(ax(i));
end 

plots_set = [p1, p2, p3, p4, p5, p6];
for i = 1:length(plots_set)
   set(plots_set(i), 'LineWidth', 1);
end

print('results', '-dpng', '-r300');