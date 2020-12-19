close all;
clear all;
clc;
format short;

%% Dados obtidos
eSQI_pm = [0.6505 0.4489 0.3932 0.4680 0.4289 0.5432 0.6766 0.4387];
eSQI_tt = [0.6478 0.4429 0.4044 0.4608 0.4182 0.5300 0.6082 0.4346];
eSQI_nf = [0.6459 0.4282 0.3963 0.4531 0.5001 0.5295 0.4308 0.6023];

stdSQI_pm = [0.2089 0.1925 0.2143 0.3406 0.7853 0.1681 0.3310 0.2630];
stdSQI_tt = [0.2073 0.1923 0.2143 0.3403 0.1352 0.1681 0.3302 0.2645];
stdSQI_nf = [0.2048 0.1922 0.2147 0.3005 0.1319 0.1680 0.3308 0.2630];

PSD_pm = [-2.7714 -3.5316 -2.7164 -3.4256 -57.922 -2.2007 -3.4608 -2.7603];
PSD_tt = [-2.3015 -2.2436 -2.0561 -2.0853 -38.167 -1.9884 -1.7795 -1.9220];
PSD_nf = [-1.5564 -1.2372 -1.3262 -1.3970 2.6819 -1.0888 -1.2614 -1.5738];

%%

%% TESTE t 
alpha = 0.05;

fprintf('\n');
fprintf('Tese-t para variável eSQI.\n');
%comparação proposto e limiar
[h, p, ci, stats] = ttest2(eSQI_pm, eSQI_tt, alpha, 'right', 'unequal');
fprintf('PM vs TT:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

%comparação proposto e notch
[h, p, ci, stats] = ttest2(eSQI_pm, eSQI_nf, alpha, 'right', 'unequal');
fprintf('PM vs NF:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

fprintf('\n');
fprintf('Tese-t para variável stdSQI.\n');
%comparação proposto e limiar
[h, p, ci, stats] = ttest2(stdSQI_pm, stdSQI_tt, alpha, 'right', 'unequal');
fprintf('PM vs TT:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

%comparação proposto e notch
[h, p, ci, stats] = ttest2(stdSQI_pm, stdSQI_nf, alpha, 'right', 'unequal');
fprintf('PM vs NF:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

fprintf('\n');
fprintf('Tese-t para variável PSD.\n');
%comparação proposto e limiar
[h, p, ci, stats] = ttest2(PSD_pm, PSD_tt, alpha, 'left', 'unequal');
fprintf('PM vs TT:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

%comparação proposto e notch
[h, p, ci, stats] = ttest2(PSD_pm, PSD_nf, alpha, 'left', 'unequal');
fprintf('PM vs NF:\n h:%2.4f - p:%2.4f - ci:%2.4f %2.4f', h, p, ci);
fprintf('\n');

%%


