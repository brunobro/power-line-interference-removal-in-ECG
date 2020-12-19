close all;
clear all;
clc;
format short;

%% Dados obtidos
error_pm = [0.0027 0.0028 0.0007 0.0012 0.0027 0.0071 0.0021 0.0077 0.0015 0.0020 0.0169 0.0019 0.0031 0.0030 0.0072 0.0072 0.0017 0.0200 0.0005 0.0069];
error_tt = [0.0036 0.0037 0.0008 0.0016 0.0039 0.0094 0.0001 0.0038 0.0020 0.0028 0.0238 0.0028 0.0001 0.0041 0.0099 0.0102 0.0001 0.0202 0.0011 0.0099];
error_nf = [0.0069 0.0069 0.0054 0.0046 0.0061 0.0135 0.0066 0.0094 0.0057 0.0087 0.0292 0.0235 0.0069 0.0085 0.0415 0.0140 0.0119 0.0276 0.0190 0.0130];

rmse_pm = [0.0075 0.0080 0.0049 0.0040 0.0075 0.0190 0.0062 0.0148 0.0043 0.0067 0.0259 0.0060 0.0100 0.0089 0.0208 0.0125 0.0056 0.0245 0.0122 0.0148];
rmse_tt = [0.0098 0.0103 0.0018 0.0053 0.0103 0.0292 0.0015 0.0059 0.0048 0.0088 0.0472 0.0152 0.0003 0.0113 0.0371 0.0207 0.0010 0.0312 0.0385 0.0304];
rmse_nf = [0.0189 0.0149 0.0086 0.0094 0.0099 0.0474 0.0143 0.0228 0.0100 0.0281 0.1282 0.0986 0.0105 0.0265 0.1793 0.0589 0.0375 0.1182 0.0806 0.0534];

snrimp_pm = [39.5135 35.8650 29.1643 36.9897 19.4379 40.0431 37.9753 35.1591 33.8243 44.0353 45.8751 56.7105 35.0189 40.9507 50.9574 45.3992 50.6373 45.9789 48.6787 43.3985];
snrimp_tt = [37.1723 33.6532 38.0101 34.5251 16.7149 36.3182 50.1589 43.2127 32.8589 41.6684 40.6579 48.6041 65.0196 38.8206 45.9358 41.0428 65.5897 43.8886 38.7278 37.1499];
snrimp_nf = [31.4736 30.4104 24.3344 29.5679 17.0817 32.1079 30.7739 31.4330 26.4913 31.5227 31.9784 32.3823 34.6267 31.4428 32.2579 31.9638 34.1308 32.3125 32.3051 32.2712];

r_pm = [0.9994 0.9995 0.9997 0.9998 0.9995 0.9963 0.9997 0.9979 0.9998 0.9996 0.9941 0.9997 0.9992 0.9993 0.9955 0.9982 0.9997 0.9950 0.9978 0.9969];
r_tt = [0.9991 0.9991 1.0000 0.9996 0.9991 0.9913 1.0000 0.9997 0.9998 0.9993 0.9809 0.9980 1.0000 0.9989 0.9859 0.9951 1.0000 0.9920 0.9788 0.9870];
r_nf = [0.9972 0.9988 0.9998 0.9991 0.9997 0.9802 0.9989 0.9972 0.9996 0.9941 0.8867 0.9306 0.9998 0.9949 0.7850 0.9655 0.9891 0.9065 0.9204 0.9646];
%%

%% TESTE t 
alpha = 0.05;

fprintf('Tese-t para variável Error.\n');
%comparação proposto e limiar
[h, p, ci, stats] = ttest2(error_pm, error_tt, alpha, 'left', 'unequal');
fprintf('PM vs TT:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

%comparação proposto e notch
[h, p, ci, stats] = ttest2(error_pm, error_nf, alpha, 'left', 'unequal');
fprintf('PM vs NF:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

fprintf('Tese-t para variável RMSE.\n');
%comparação proposto e limiar
[h, p, ci, stats] = ttest2(rmse_pm, rmse_tt, alpha, 'left', 'unequal');
fprintf('PM vs TT:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

%comparação proposto e notch
[h, p, ci, stats] = ttest2(rmse_pm, rmse_nf, alpha, 'left', 'unequal');
fprintf('PM vs NF:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

fprintf('Tese-t para variável SNRimp.\n');
%comparação proposto e limiar
[h, p, ci, stats] = ttest2(snrimp_pm, snrimp_tt, alpha, 'right', 'unequal');
fprintf('PM vs TT:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

%comparação proposto e notch
[h, p, ci, stats] = ttest2(snrimp_pm, snrimp_nf, alpha, 'right', 'unequal');
fprintf('PM vs NF:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

fprintf('Tese-t para variável R.\n');
%comparação proposto e limiar
[h, p, ci, stats] = ttest2(r_pm, r_tt, alpha, 'right', 'unequal');
fprintf('PM vs TT:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

%comparação proposto e notch
[h, p, ci, stats] = ttest2(r_pm, r_nf, alpha, 'right', 'unequal');
fprintf('PM vs NF:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');
%%


