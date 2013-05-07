clear('data','col_names','samples','targets','net');
clear('trn_t','trn_s','tst_t','tst_s');
clear('pred','true','mse');

% load data
load('mackeyglass.mat');
samples = data(:, 1)';
targets = data(:, 2)';

trn_s = samples(1:4000);
trn_t = targets(1:4000);
tst_s = samples(4000:5000);
tst_t = targets(4000:5000);

% initialize net
net = fitnet(net_size,'trainrp');
net.trainParam.epochs   = 2000;
net.trainParam.max_fail = 20;

% train net
net = train(net,trn_s,trn_t);

% check performance
pred = net(tst_s);
true = tst_t;
mse = mean((pred-true).^2);
mse
