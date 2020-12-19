clear all;
clc;
close;

cd 'E:\ARTIGOS\Denoising 60Hz ECG\scripts\';
addpath('E:\ARTIGOS\Denoising 60Hz ECG\scripts\true signals');

recs = {'1007823m_leadII.mat','1034914m_leadIII.mat','1086219m_leadIII.mat','1098605m_leadV1.mat','1105115m_leadV2.mat','1124627m_leadAVL.mat','1138505m_leadI.mat','2209843m_leadI.mat'};

for i = 1:length(recs)
    
    disp('------- Register -------');
    disp(char(recs(i)));
    load(char(recs(i)));
    
    title_str = strrep(strrep(char(recs(i)), '.mat',''), 'm_', ' ');

    figure(1);
    plot(val);
    xlim([0 5000]);
    title(strcat('Raw ECG ', ' ', title_str));
    xlabel('Sample');
    ylabel('Amplitude');
    grid 'on';
    

    print(strcat('true signals\', strrep(char(recs(i)), '.mat','') , '_plot'), '-dpng', '-r300');
    close(1);
    
end

