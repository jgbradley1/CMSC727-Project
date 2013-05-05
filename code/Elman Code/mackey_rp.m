% load data
load('mackeyglass.mat');
time         = data(:, 1)';
targets      = data(:, 2)';

% initialize the net
net = fitnet(10, 'trainrp');
%net.trainParam.epochs  = 2000;
%net.trainParam.max_fail = 20;
%net.trainParam.delta0   = 0.07;
%net.trainParam.delt_inc = 1.2;
%net.trainParam.delt_dec = 0.5;

% train the net
net = train(net, time, targets);
