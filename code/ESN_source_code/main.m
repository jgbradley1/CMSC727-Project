% A driver program to run an ESN with NO backpropagation connections from
% output to reservoir.


%{
generate ESN with parameters
gen_esn(inputSize, resSize, outputSize, leakRate)
%}
disp 'Generating ESN...'
net = gen_esn(1, 100, 1, 1.0);

%{
train the ESN with data with parameters
train_esn(esn, dataFile, trainLen, initLen)
%}
disp 'Training ESN...'
net = train_esn(net, 'MackeyGlass_t17_single_column', 500, 50);

%{
run the ESN over test data with parameters
test_esn(esn, dataFile, testLen)
%}
disp 'Testing ESN...'
net = test_esn(net, 'MackeyGlass_t17_single_column', 500);

disp (['Error Rate: ', num2str(net.mse)]);