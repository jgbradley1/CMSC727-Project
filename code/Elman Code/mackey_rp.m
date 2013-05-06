clear('data','col_names','time','targets','t','tm','net');
clear('Xs','Xi','Ai','Ts','pred','true','mse');

% load data
load('mackeyglass.mat');
input        = data(:, 1)';
targets      = data(:, 2)';

% initialize net
net = fitnet(10,'trainrp');
net.trainParam.epochs   = 2000;
net.trainParam.max_fail = 20;

% train net
net = train(net,input(1:4000),targets(1:4000));

% check performance
pred = net(input(4000:5000));
true = targets(4000:5000);
mse = mean((pred-true).^2);
mse
