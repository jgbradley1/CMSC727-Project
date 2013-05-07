clear('data','col_names','samples','targets','net','tr');
clear('trn_t','trn_s','tst_t','tst_s');
clear('Xs','Xi','Ai','Ts','pred','true','mse');

% load data
load('mackeyglass.mat');
samples = data(:, 1)';
targets = data(:, 2)';

for i = 1:4000
  trn_t(i) = {targets(i)};
  trn_s(i) = {samples(i)}; 
end
for i = 4000:5000
  tst_t(i) = {targets(i)};
  tst_s(i) = {samples(i)}; 
end

% initialize net
net = elmannet(1:2,net_size,'trainrp');

% jordanify
net.layerConnect = [0 1; 1 0];
net.layerWeights{1,2}.delays = 1;

[Xs,Xi,Ai,Ts] = preparets(net,trn_s,trn_t);
%net.trainParam.epochs   = 2000;
%net.trainParam.max_fail = 20;

% train net
[net,tr] = train(net,Xs,Ts,Xi,Ai);

% check performance
%pred = net(samples(4000:5000));
%true = targets(4000:5000);
%mse = mean((pred-true).^2);
mse = tr.best_perf;
mse
