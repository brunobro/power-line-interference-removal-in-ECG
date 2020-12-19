function [e] = E(x, x_hat)
    %Calcula o erro
    e = sum(abs(x - x_hat))/length(x);
end

