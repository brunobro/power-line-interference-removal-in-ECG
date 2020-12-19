clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG\scripts';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\true signals');

format long;

C = 0.005;
Fs = 500;
B = 5;

recs = {'1007823m_leadII.mat','1034914m_leadIII.mat','1086219m_leadIII.mat','1098605m_leadV1.mat','1105115m_leadV2.mat','1124627m_leadAVL.mat','1138505m_leadI.mat','2209843m_leadI.mat'};

mean_r             = 0;
mean_energySQI_den = 0;
mean_highfSQI_den  = 0;
mean_stdSQI_den    = 0;
mean_eDWT_den      = 0;
mean_power_den     = 0;

for i = 1:length(recs)
    
    disp('------- Register -------');
    disp(char(recs(i)))
    load(char(recs(i)));

    ecg_den = Notch(val, Fs, C, 60, B);

    %computa as medidas
    r = corrcoef(val, ecg_den);
    r = r(2:2);
    mean_r = mean_r + r;
    
    disp('Correlation');
    disp(r);

    energySQI     = eSQI(val, Fs);
    energySQI_den = eSQI(ecg_den, Fs);
    mean_energySQI_den = mean_energySQI_den + energySQI_den;
    
    highfSQI = hfSQI(val, Fs);
    highfSQI_den = hfSQI(ecg_den, Fs);
    mean_highfSQI_den = mean_highfSQI_den + highfSQI_den;
    
    stdsSQI = stdSQI(val, Fs);
    stdSQI_den = stdSQI(ecg_den, Fs);
    mean_stdSQI_den = mean_stdSQI_den + stdSQI_den;
    
    disp('eSQI > Original  - Method');
    disp([energySQI, energySQI_den]);
    
    disp('hfSQI > Original  - Method');
    disp([highfSQI, highfSQI_den]);
    
    disp('stdSQI > Original  - Method');
    disp([stdsSQI, stdSQI_den]);

    %periodogramas
    [pxx1, f1] = pwelch(val, 128, 50, 2048, Fs);
    [pxx2, f2] = pwelch(ecg_den, 128, 50, 2048, Fs);

    %calcula a potência acima de 30Hz
    plog_den = 10*log10(pxx2);
    power_den = sum(plog_den(30:length(pxx2)));
    mean_power_den = mean_power_den + power_den;

    plog = 10*log10(pxx1);
    power = sum(plog(30:length(pxx1)));
    
    disp('PSD > Original  - Method');
    disp([power, power_den]);

end

mean_r             = mean_r/length(recs);
mean_energySQI_den = mean_energySQI_den/length(recs);
mean_highfSQI_den  = mean_highfSQI_den/length(recs);
mean_stdSQI_den    = mean_stdSQI_den/length(recs);
mean_eDWT_den      = mean_eDWT_den/length(recs);
mean_power_den     = mean_power_den/length(recs);
means              = [mean_r, mean_energySQI_den, mean_highfSQI_den, mean_stdSQI_den, mean_eDWT_den, mean_power_den];

disp('Médias: r     eSQI     hfSQI     stdSQI     eDWT     PSD');
disp(means);
