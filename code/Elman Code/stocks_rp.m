clear('data','col_names','samples','samples_time','targets','t','s','net');
clear('Xs','Xi','Ai','Ts','pred','true','mse');

% load data
load('stocks.mat');
samples      = data(:, 2:29)';
samples_time = data(:, 1:29)';
targets      = data(:, 30)';

% initialize net
net = fitnet(10,'trainrp');
net.trainParam.epochs   = 2000;
net.trainParam.max_fail = 20;

% train net
net = train(net,samples(1:4000),targets(1:4000));

% check performance
pred = net(samples(4000:5000));
true = targets(4000:5000);
mse = mean((pred-true).^2);
mse
