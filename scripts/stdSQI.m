function [rsd] = stdSQI(ecg, Fs, R_peaks)
    %detect R peaks
    if nargin < 3
        R_peaks = dpi_qrs(ecg, Fs, 1000, 5);
    end
    
    %calculates Ra and H
    sigma_r = [];
    sigma_a = [];
    for i = 1:length(R_peaks)
       sigma_r  = [sigma_r std(ecg(R_peaks(i) - 0.07 * Fs : R_peaks(i) + 0.08 * Fs ))];
       sigma_a  = [sigma_a std(ecg(R_peaks(i) - 0.2 * Fs : R_peaks(i) + 0.2 * Fs ))];
    end
    
    rsd = (1/length(R_peaks)) * sum(sigma_r / sigma_a * 2);
end

