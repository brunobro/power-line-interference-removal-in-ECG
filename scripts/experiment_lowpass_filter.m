%implementa um filtro notch para remover ruído de 60 Hz
load('ecg15_n.mat');

ecg = ecg15_n;
fs = 500;
T = 1/fs;
wd1 = 2 * pi * 0.25;
wd2 = 2 * pi * 40;
wa1 = (2/T) * tan(wd1 * T/2);
wa2 = (2/T) * tan(wd2 * T/2);
[B, A] = lp2bp(1.4314, [1 1.4652 1.5162], sqrt(wa1 * wa2), wa2 - wa1);
[b, a] = bilinear(B, A, fs);

ecg_den = filter(b, a, ecg);

plot(ecg, 'b');
hold 'on';
plot(ecg_den, 'r');

