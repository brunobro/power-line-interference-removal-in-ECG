function [ energy ] = eSQI( ecg, Fs )
    %eSQI the relative energy in the QRS complex.
    
    %detect R peaks
    R_peaks = dpi_qrs(ecg, Fs, 1000, 5);
       
    %calculate energy
    Ea = sum(ecg .^ 2);
    Er = 0;
    for i = 1:length(R_peaks)
        R_peak = R_peaks(i);
        s = R_peak - (Fs * 0.07);
        e = R_peak + (Fs * 0.08);
        if e > length(ecg)
            e = length(ecg);
        end
        seg = ecg(s:e);
        Er = Er + sum(seg .^ 2);
    end
    
    %return
    energy = Er/Ea;
    
end

