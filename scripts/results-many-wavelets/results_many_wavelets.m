clear all;
close all;
clc;

%%
figure();
hold on;

load('db6-RMSE');
plot(RMSEs, 'k', 'DisplayName', 'db6');

load('db8-RMSE');
plot(RMSEs, 'g', 'DisplayName', 'db8');

load('db10-RMSE');
plot(RMSEs, 'r', 'DisplayName', 'db10');

load('db12-RMSE');
plot(RMSEs, 'b', 'DisplayName', 'db12');

xlim([1, 20]);
xlabel('Signal');
ylabel('RMSE');
grid 'on';
legend('show');
print('many_wavelets_db', '-dpng', '-r300');


%%
figure();
hold on;

load('coif2-RMSE');
plot(RMSEs, 'r', 'DisplayName', 'coif2');

load('coif4-RMSE');
plot(RMSEs, 'b', 'DisplayName', 'coif4');

load('dmey-RMSE');
plot(RMSEs, 'g', 'DisplayName', 'dmey');

xlim([1, 20]);
xlabel('Signal');
ylabel('RMSE');
grid 'on';
legend('show');
print('many_wavelets_coif', '-dpng', '-r300');

%%
figure();
hold on;

load('bior13-RMSE');
plot(RMSEs, 'r', 'DisplayName', 'bior1.3');

load('bior24-RMSE');
plot(RMSEs, 'b', 'DisplayName', 'bior2.4');

load('bior31-RMSE');
plot(RMSEs, 'g', 'DisplayName', 'bior3.1');

load('bior44-RMSE');
plot(RMSEs, 'k', 'DisplayName', 'bior4.4');

xlim([1, 20]);
xlabel('Signal');
ylabel('RMSE');
grid 'on';
legend('show');
print('many_wavelets_bior', '-dpng', '-r300');

%%
figure();
hold on;

load('sym6-RMSE');
plot(RMSEs, 'k', 'DisplayName', 'sym6');

load('sym8-RMSE');
plot(RMSEs, 'g', 'DisplayName', 'sym8');

load('sym10-RMSE');
plot(RMSEs, 'r', 'DisplayName', 'sym10');

load('sym12-RMSE');
plot(RMSEs, 'b', 'DisplayName', 'sym12');

xlim([1, 20]);
xlabel('Signal');
ylabel('RMSE');
grid 'on';
legend('show');
print('many_wavelets_sym', '-dpng', '-r300');