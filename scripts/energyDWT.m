function [e] = energyDWT(ecg, level, wavelet)
    [coeffs, pos] = wavedec(ecg, level, wavelet);
    e = sum(coeffs(pos(2):pos(length(pos))) .^ 2);
end

