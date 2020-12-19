function [ signal_den ] = Notch( signal_noisy, fs, C, fnom, B)
    %Remove ruído numa frequência específica implementando um método de
    %supressão de transiente
    
    N  = length(signal_noisy);
    if nargin == 1
        fs = 500;
    end
    if nargin == 2
        C  = 0.01;
    end
    if nargin == 3
        fnom = 60;
    end
    if nargin == 4
        B = 10;
    end
    
    %parâmetros do filtro
    theta = 2 * pi * fnom / fs;
    a1 = -2 * (1 - pi * B * C / fs) * cos(theta);
    a2 = (1 - pi * B * C / fs) ^ 2;
    a3 = 2 * (1 - pi * B / fs) * cos(theta);
    a4 = -1 * (1 - pi * B / fs) ^ 2;
    
    signal_den = [signal_noisy(1) signal_noisy(2)];
    for k = 3 : N
       r = signal_noisy(k) + a1 * signal_noisy(k - 1) + a2 * signal_noisy(k - 2) + a3 * signal_den(k - 1) + a4 * signal_den(k - 2);
       signal_den = [signal_den r]; 
    end

end

