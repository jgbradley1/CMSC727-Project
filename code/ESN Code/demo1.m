% A driver program to run an ESN with NO backpropagation connections from
% output to reservoir.


%{
generate ESN with parameters
gen_esn(inputSize, resSize, outputSize, leakRate, spectral_radius)
%}
disp 'Generating ESN...'
net = gen_esn(1, 100, 1, 1.0, 0.5);

%{
train the ESN with data with parameters
train_esn(esn, dataFile, trainLen, initLen)
%}
disp 'Training ESN...'
net = train_esn(net, 'data/MackeyGlass_t17_single_column', 500, 50);

%{
run the ESN over test data with parameters
test_esn(esn, dataFile, testLen)
%}
disp 'Testing ESN...'
net = test_esn(net, 'data/MackeyGlass_t17_single_column', 500);

disp (['Error Rate: ', num2str(net.mse)]);