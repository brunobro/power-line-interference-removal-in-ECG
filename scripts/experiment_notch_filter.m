%implementa um filtro notch para remover ruído de 60 Hz
addpath('E:\ARTIGOS\Denoising 60Hz ECG\scripts\synthetic signals');
load('ecg15_n.mat');

%sinal de entrada
x = ecg15_n;

y = Notch(x, 500, 0.01, 60, 10);

figure();
plot(x, 'b');
title('Filtro de Segunda Ordem');
hold 'on';
plot(y, 'r');



