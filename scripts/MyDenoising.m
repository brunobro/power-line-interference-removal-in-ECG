function [ signal_den ] = MyDenoising(signal_noisy, wavelet, level_dec, window_len)
    
    %acrescentas amostras nulas nas bordas do sinal
    half_window = ceil(window_len/2);
    null_samples = zeros(1, half_window);
    signal_noisy = [null_samples signal_noisy null_samples];
    first_length_signal = length(signal_noisy);
    
    %aumenta o tamanho do sinal para que possa ser janelado corretamente
    n_add = 0;
    while rem(length(signal_noisy), window_len) ~= 0
        signal_noisy = [signal_noisy 0];
        n_add = n_add + 1;
    end
    
    second_length_signal = length(signal_noisy);
    
    w_hann     = hanning(window_len);
    sup        = ceil(0.5 * window_len); %sobreposição de 50%
    n          = 1 + sup;
    signal_den = zeros(1, second_length_signal);
    
    while n + sup <= second_length_signal
        
        ind = n - sup + (0 : window_len - 1);
        frame = signal_noisy(ind) .* w_hann';
        
        [coeffs, pos] = wavedec(frame, level_dec, wavelet);
        new_coeffs = zeros(length(coeffs));
        new_coeffs(1:pos(1)) = coeffs(1:pos(1));
        frame_den = waverec(new_coeffs, pos, wavelet);
        
        signal_den(ind) = signal_den(ind) + frame_den;
        
        n = n + sup;
        
    end
    
    signal_den = signal_den(1 : second_length_signal - n_add);
    signal_den = signal_den(half_window + 1 : first_length_signal - half_window);
    
end

