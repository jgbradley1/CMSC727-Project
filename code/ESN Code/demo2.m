% A driver program to run an ESN that HAS backpropgation connections from
% output to reservoir.


%{
generate ESN with parameters
gen_esn(inputSize, resSize, outputSize, leakRate, spectral_radius)
%}
disp 'Generating ESN...'
net = gen_esn2(28, 100, 1, 1, 0.5, 'No');

%{
train the ESN with data with parameters
train_esn(esn, dataFile, trainLen, initLen)
%}
disp 'Training ESN...'
net = train_esn2(net, 'data/stocks', 4000, 10);

%{
run the ESN over test data with parameters
test_esn(esn, dataFile, testLen)
%}
disp 'Testing ESN...'
net = test_esn2(net, 'data/stocks', 1000);


disp (['Error Rate: ', num2str(net.mse)]);