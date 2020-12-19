clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\true signals');
addpath('E:\ARTIGOS\Denoising 60Hz ECG\synthetic signals');
addpath('E:\PESQUISAS\Matlab');

%Gera um sinal ECG utilizando um modelo dinâmico de ED

Fs = 500; %frequencia de amostragem
len_sig = 5 * Fs; %tamanho do sinal
t = 0:1/Fs:(len_sig/Fs);
wavelet = 'sym8';

load('ecg6_n.mat');
ecg_noisy = ecg6_n;

[coeffs, pos] = wavedec(ecg_noisy, 3, wavelet);
new_coeffs = zeros(length(coeffs));
new_coeffs(1:pos(1)) = coeffs(1:pos(1));
ecg_denoising = waverec(new_coeffs, pos, wavelet);

fig0 = figure(1);
grid on;
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

titles_plot = {'(a)','(b)','(c)','(d)','(e)'};

ax = flipdim(findobj(fig0, 'Type', 'Axes'), 1);
for i = 1:length(ax)
    title(ax(i), titles_plot{i}, 'FontWeight' , 'bold', 'FontSize', 10);
    xlabel(ax(i), 'Sample', 'FontSize', 9);
    ylabel(ax(i), 'Amplitude', 'FontSize', 9);
    grid(ax(i));
end

print('show_decomposition_synthetic_signal', '-dpng', '-r300');

