% load data
load('mackeyglass.mat');
time         = data(:, 1)';
targets      = data(:, 2)';

for i = 1:10000
  t(i) = {targets(i)};
  tm(i) = {time(i)};
end

% initialize net
net = elmannet();
[Xs,Xi,Ai,Ts] = preparets(net,tm,t);
net.trainParam.epochs   = 2000;
net.trainParam.max_fail = 20;
net.trainParam.lr       = 0.07;
net.trainParam.lr_inc   = 1.2;
net.trainParam.lr_dec   = 0.5;
net.trainParam.mc       = 0.9;

% train net
net = train(net,Xs,Ts,Xi,Ai);
