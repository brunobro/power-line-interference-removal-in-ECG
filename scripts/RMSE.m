function [rmse] = RMSE(x, x_hat)
    rmse = sqrt((1/length(x))*sum((x - x_hat).^2));
end

