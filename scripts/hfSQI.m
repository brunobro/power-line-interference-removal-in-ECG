function [hf] = hfSQI(ecg, Fs, R_peaks)

    %filters the signal
    c = length(ecg);
    y = zeros(1,c);
    j = 3:c;
    y(j) = ecg(j) - 2*ecg(j-1) + ecg(j-2);
    y(1) = ecg(1);
    y(2) = ecg(2);
    c = length(y);
    j = 6:c;
    s = zeros(1,c);
    ya = abs(y);
    s(j) = ya(j) + ya(j-1) + ya(j-2) + ya(j-3) + ya(j-4) + ya(j-5);
    
    %detect R peaks
    if nargin < 3
        R_peaks = dpi_qrs(ecg, Fs, 1000, 5);
    end
    
    %calculates Ra and H
    Ra = [];
    H  = [];
    for i = 1:length(R_peaks)
       Ra = [Ra ecg(R_peaks(i))];
       H  = [H mean(s(R_peaks(i) - 0.28 * Fs : R_peaks(i) - 0.05 * Fs ))];
    end
    
    hf = (1/length(R_peaks)) * sum(Ra / H);
    
end