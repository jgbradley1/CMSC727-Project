clear('data','col_names','time','targets','t','tm','net');
clear('Xs','Xi','Ai','Ts','pred','true','mse');

% load data
load('mackeyglass.mat');
input        = data(:, 1)';
targets      = data(:, 2)';

for i = 1:4000
  t(i) = {targets(i)};
  tm(i) = {input(i)}; 
end

% initialize net
net = elmannet(1:2,10,'trainrp');

% jordanify
net.layerConnect = [0 1; 1 0];
net.layerWeights{1,2}.delays = 1;

[Xs,Xi,Ai,Ts] = preparets(net,tm,t);
net.trainParam.epochs   = 2000;
net.trainParam.max_fail = 20;

% train net
net = train(net,Xs,Ts,Xi,Ai);

% check performance
pred = net(input(4000:5000));
true = targets(4000:5000);
mse = mean((pred-true).^2);
mse
