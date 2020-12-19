%Compara o sinal reconstruído (PQRST) pela Daubechies e Symlet

clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\synthetic signals');
addpath('E:\PESQUISAS\Matlab');

%carrega os sinais
load('ecg8_n.mat');
ecg8_n = ecg8_n(1:2000);
load('ecg8.mat');
ecg8 = ecg8(1:2000);

%remove o ruído
ecg_denoising_db = MyDenoising(ecg8_n, 'db10', 3, 1000);
ecg_denoising_sym = MyDenoising(ecg8_n, 'sym10', 3, 1000);

figure;
plot(ecg8(1690:1940),'r');
hold on;
plot(ecg_denoising_db(1700:1950),'b');
plot(ecg_denoising_sym(1700:1950),'k');
legend('Original ECG','Denoising ECG with Db10','Denoising ECG with Sym10','Location','southwest');
xlabel('Sample');
ylabel('Amplitude (mV)');
xlim([0 250]);
grid();

print('compare_db_sym_s8', '-dpng', '-r300');




