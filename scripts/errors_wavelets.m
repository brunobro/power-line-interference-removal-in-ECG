clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\synthetic signals');
addpath('E:\ARTIGOS\Denoising 60Hz ECG\errors_symlet');
addpath('E:\PESQUISAS\Matlab');

Fs = 500;
window_len = 1000;

ecg_n = {};
ST = load('ecg6_n.mat');
ecg_n{1} = ST.ecg6_n;
ST = load('ecg8_n.mat');
ecg_n{2} = ST.ecg8_n;
ST = load('ecg11_n.mat');
ecg_n{3} = ST.ecg11_n;
ST = load('ecg12_n.mat');
ecg_n{4} = ST.ecg12_n;
ST = load('ecg13_n.mat');
ecg_n{5} = ST.ecg13_n;
ST = load('ecg15_n.mat');
ecg_n{6} = ST.ecg15_n;
ST = load('ecg16_n.mat');
ecg_n{7} = ST.ecg16_n;
ST = load('ecg17_n.mat');
ecg_n{8} = ST.ecg17_n;
ST = load('ecg19_n.mat');
ecg_n{9} = ST.ecg19_n;
ST = load('ecg20_n.mat');
ecg_n{10} = ST.ecg20_n;

clearvars ecg6_n ecg8_n ecg11_n ecg12_n ecg13_n ecg15_n ecg16_n ecg17_n ecg19_n ecg20_n;

ecg = {};
ST = load('ecg6.mat');
ecg{1} = ST.ecg6;
ST = load('ecg8.mat');
ecg{2} = ST.ecg8;
ST = load('ecg11.mat');
ecg{3} = ST.ecg11;
ST = load('ecg12.mat');
ecg{4} = ST.ecg12;
ST = load('ecg13.mat');
ecg{5} = ST.ecg13;
ST = load('ecg15.mat');
ecg{6} = ST.ecg15;
ST = load('ecg16.mat');
ecg{7} = ST.ecg16;
ST = load('ecg17.mat');
ecg{8} = ST.ecg17;
ST = load('ecg19.mat');
ecg{9} = ST.ecg19;
ST = load('ecg20.mat');
ecg{10} = ST.ecg20;

clearvars ecg6 ecg8 ecg11 ecg12 ecg13 ecg15 ecg16 ecg17 ecg19 ecg20;

%ordem das wavelets (momentos nulos)
nw = 16;

%vetor das medidas de erro e tempo
errors = zeros(10, nw);
times  = zeros(10, nw);
errors_order = zeros(nw, 10);
times_order  = zeros(nw, 10);

%vetor com as medidas de erro e tempo para wavelts com ordem acima de 6
over6_error = zeros(1, nw - 6);
over6_time  = zeros(1, nw - 6);

k = 1;
for s = [1,2,3,4,5,6,7,8,9,10]
    fprintf('Signal s_%d \n', s);
    for i = 2:nw
        wavelet = strcat('sym', num2str(i));
        tic;
        ecg_den = MyDenoising(ecg_n{s}, wavelet, 3, window_len);
        vt = toc;
        ve = E(ecg{s}, ecg_den);
        
        times(k, i)        = vt;
        times_order(i, k)  = vt;
        errors_order(i, k) = ve;
        errors(k, i)       = ve;
         
        fprintf('%s - Error: %f  , Time: %f \n', wavelet, errors(k, i), times(k, i));
        
        if i >= 6
           over6_error(1, i - 5) = errors(k, i);
           over6_time(1, i - 5)  = times(k, i);
        end
    end
    fprintf('Mean - ordem acima de 6: \n Error: %f , Time: %f', mean(over6_error), mean(over6_time));
    fprintf('---------------------------------------\n');
    k = k + 1;
end

%plota os resultados
t = 2:nw;
T = [t; t; t; t; t; t; t; t; t; t];

figure();
plot3(T', errors(:,2:nw)', times(:,2:nw)');
xlabel('Symlet order wavelet');
ylabel('Error');
zlabel('Time (s)');
grid on;
legend('s_6 (t)','s_8 (t)','s_{11} (t)','s_{12} (t)','s_{13} (t)','s_{15} (t)','s_{16} (t)','s_{17} (t)','s_{19} (t)','s_{20} (t)');

print('erros_wavelets', '-dpng', '-r300');

%boxplot
labels = {'2','3','4','5','6','7','8','9','10','11','12','13','14','15','16'};

%labels = cellstr(labels);

c_errors_order = errors_order';
c_times_order = times_order';

figure();
boxplot(c_errors_order(:,2:nw),'Labels',labels);
grid on;
xlabel('Symlet order wavelet');
ylabel('Error');

print('boxplot_erros_wavelets', '-dpng', '-r300');

figure();
boxplot(c_times_order(:,2:nw),'Labels',labels);
grid on;
xlabel('Symlet order wavelet');
ylabel('Time (s)');

print('boxplot_times_wavelets', '-dpng', '-r300');