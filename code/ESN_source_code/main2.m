% A driver program to run an ESN that HAS backpropgation connections from
% output to reservoir.


%{
generate ESN with parameters
gen_esn(inputSize, resSize, outputSize, leakRate, spectral_radius)
%}
disp 'Generating ESN...'
net = gen_esn2(1, 100, 1, 1.0, 0.9);

%{
train the ESN with data with parameters
train_esn(esn, dataFile, trainLen, initLen)
%}
disp 'Training ESN...'
net = train_esn2(net, 'MackeyGlass_t17', 1000, 100);

%{
run the ESN over test data with parameters
test_esn(esn, dataFile, testLen)
%}
disp 'Testing ESN...'
net = test_esn2(net, 'MackeyGlass_t17', 250);


disp (['Error Rate: ', num2str(net.mse)]);