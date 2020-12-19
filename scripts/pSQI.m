function [sqi] = pSQI(x, fs)
%Calculates the relative power in the QRS complex
    sqi_ps = pwelch(x);
    sqi_psd = dspdata.psd(sqi_ps, 'Fs', fs);
    sqi = avgpower(sqi_psd, [5, 15]) / avgpower(sqi_psd, [5, 40]);
end

