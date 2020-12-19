function [ Hpsd ] = purSQI( ecg, Fs, cycles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    Hpsd = dspdata.psd(ecg,'Fs',Fs);
end

