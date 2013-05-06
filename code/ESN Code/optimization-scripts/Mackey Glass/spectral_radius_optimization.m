addpath('../../');

inputSize = 1;
outputSize = 1;
reservoirSize = 100;
leakRate = 0.5;

trainingSize = 4000;
testingSize = 1000;
forgetSize = 100;

disp('Mackey Glass Dataset');
disp('Spectral Radius Optimization');

X = zeros(18, 1);      % will hold values for graphing the horizontal axis later on
Y = zeros(18, 1);      % will hold values for graphing the vertical axis later on
counter = 1;

for spectralRadius = 0.05:0.05:0.95
    % gen_esn(inputSize, resSize, outputSize, leakRate, spectral_radius)
    net = gen_esn(inputSize, reservoirSize, outputSize, leakRate, spectralRadius);

    % train_esn(esn, dataFile, trainLen, initLen)
    net = train_esn(net, '../../data/MackeyGlass_t17_single_column', trainingSize, forgetSize);
    
    % test_esn(esn, dataFile, testLen)
    net = test_esn(net, '../../data/MackeyGlass_t17_single_column', testingSize);
    
    % record leak rate and mse for graphing
    X(counter) = spectralRadius;
    Y(counter) = net.mse;
    counter = counter+1;
    
    disp (['Spectral Radius: ', num2str(spectralRadius), '    Error Rate: ', num2str(net.mse)]);
end

bar(X, Y);
title('Spectral Radius Optimization For Mackey Glass');
xlabel('Spectral Radius');
ylabel('MSE');

% axis([xmin xmax ymin ymax]) -- leave a little room above the maximum of Y
% for asthetic purposes
axis([0 1 0 max(Y)+0.05*max(Y)])

addpath('../../');