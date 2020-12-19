%Exibe a resposta em frequência do banco de filtros wavelets para vários
%níveis

clear all;
clc;

Wavelet = 'sym8';
level_dec = 3;
Fs = 500;

%obtem os coeficientes do filtro
[Lo, Hi] = wfilters(Wavelet);

fig0 = figure();
fig_loc = 1;

for level = 1:level_dec
       
    %calcula a resposta em frequência
    [H_a,W_a] = freqz(Lo, 1, 128, 'whole', Fs);
    [H_d,W_d] = freqz(Hi, 1, 128, 'whole', Fs);
    
    half_len = ceil(length(W_a)/2);
    
    subplot(level_dec, 1, fig_loc);
    plot(W_a(1:half_len), abs(H_a(1:half_len)), 'k', W_d(1:half_len), abs(H_d(1:half_len)), 'r');
    hold 'on';
    plot(ones(1, Fs/2) * 0.707, 'b');
    %legend('Scaling Filter','Wavelet Filter');
    axis tight;

    %obtêm a resposta ao impulso para o próximo nível
    Hi = conv(upsample(Hi,2),Lo)./sqrt(2);
    Lo = conv(upsample(Lo,2),Lo)./sqrt(2);
    
    fig_loc = fig_loc + 1;
    
end

%insere os títulos nos figuras
titles_plot = {'(a)','(b)','(c)'};
ax = flipdim(findobj(fig0, 'Type', 'Axes'), 1);
for i = 1:length(ax)
    title(ax(i), titles_plot{i}, 'FontWeight' , 'bold', 'FontSize', 10);
    xlabel(ax(i), 'Frequency (Hz)', 'FontSize', 9);
    ylabel(ax(i), 'Magnitude', 'FontSize', 9);
    grid(ax(i));
end

print('frequency_response', '-dpng', '-r300');