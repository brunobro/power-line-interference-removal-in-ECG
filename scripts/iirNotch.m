function [ signal_den ] = iirNotch( signal_noisy, fs, M, fd, BW)
    %Remove ruído numa frequência específica implementando um método de
    %supressão de transiente
    
    N  = length(signal_noisy);
    if nargin == 1
        fs = 500;
    end
    if nargin == 2
        M  = 15;
    end
    if nargin == 3
        fd = 60;
    end
    if nargin == 4
        BW = 0.8;
    end
    
    %parâmetros do filtro
    w0 = 2 * pi * (fd / fs);
    W  = 2*pi * (BW/fs);
    a1 = 2*cos(w0) / (1 + tan(W/2));
    a2 = (1 - tan(W/2)) / (1 + tan(W/2));

    A = [];
    X = [];

    for i = 0 : M - 1
        X = [X ; signal_noisy(i + 1)];
        A = [A ; [cos(i * w0) sin(i * w0)]];
    end

    P = A * (A' * A)^(-1) * A';
    signal_den = (eye(size(P)) - P) * X;

    %clacula a equação de diferenças
    for n = M + 1 : N
        r = 0.5 * ((1 + a2) * signal_noisy(n) - 2 * a1 * signal_noisy(n - 1) + (1 + a2) * signal_noisy(n - 2)) + a1 * signal_den(n - 1) - a2 * signal_den(n - 2);
        signal_den = [signal_den ; r];
    end
    
    signal_den = signal_den';

end

