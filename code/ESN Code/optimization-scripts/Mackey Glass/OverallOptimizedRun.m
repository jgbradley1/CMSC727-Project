addpath('../../');

inputSize = 1;
outputSize = 1;
reservoirSize = 180;
leakRate = 0.45;
spectralRadius = 0.95;

trainingSize = 4000;
testingSize = 1000;
forgetSize = 310;

disp('Mackey Glass Dataset');
disp('Overall Optimization Performance');

% gen_esn(inputSize, resSize, outputSize, leakRate, spectral_radius)
net = gen_esn(inputSize, reservoirSize, outputSize, leakRate, spectralRadius);

% train_esn(esn, dataFile, trainLen, initLen)
net = train_esn(net, '../../data/MackeyGlass_t17_single_column', trainingSize, forgetSize);

% test_esn(esn, dataFile, testLen)
net = test_esn(net, '../../data/MackeyGlass_t17_single_column', testingSize);

disp(['Overall Performance: ', num2str(net.mse)]);

rmpath('../../');