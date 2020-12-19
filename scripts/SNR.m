function [ snr ] = SNR(x, r)
    snr = 10*log10(var(x)/var(r));
end

