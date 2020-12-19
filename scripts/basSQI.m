function [sqi] = basSQI(x, fs)
%Calculates the relative power in the baseline
    sqi_ps = pwelch(x);
    sqi_psd = dspdata.psd(sqi_ps, 'Fs', fs);
    sqi = 1 - (avgpower(sqi_psd, [0, 1]) / avgpower(sqi_psd, [0, 40]) );
end
