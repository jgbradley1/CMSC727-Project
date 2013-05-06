addpath('../../');

inputSize = 1;
outputSize = 1;
leakRate = 0.5;
spectralRadius = 0.5;

trainingSize = 4000;
testingSize = 1000;
forgetSize = 100;

disp('Mackey Glass Dataset');
disp('Reservoir Size Optimization');

X = zeros(1, 1);      % will hold values for graphing the horizontal axis later on
Y = zeros(1, 1);      % will hold values for graphing the vertical axis later on
counter = 1;

for reservoirSize = 5:5:200
    % gen_esn(inputSize, resSize, outputSize, leakRate, spectral_radius)
    net = gen_esn2(inputSize, reservoirSize, outputSize, leakRate, spectralRadius, 'No');

    % train_esn(esn, dataFile, trainLen, initLen)
    net = train_esn2(net, '../../data/MackeyGlass_t17_with_time', trainingSize, forgetSize);
    
    % test_esn(esn, dataFile, testLen)
    net = test_esn2(net, '../../data/MackeyGlass_t17_with_time', testingSize);
    
    % record leak rate and mse for graphing
    X(counter) = reservoirSize;
    Y(counter) = net.mse;
    counter = counter+1;
    
    disp (['Reservoir Size: ', num2str(reservoirSize), '    Error Rate: ', num2str(net.mse)]);
end

plot(X, Y);
title('Reservoir Size Optimization For Mackey Glass');
xlabel('Reservoir Size');
ylabel('MSE');

% axis([xmin xmax ymin ymax]) -- leave a little room above the maximum of Y
% for asthetic purposes
axis([0 205 0 max(Y)+0.05*max(Y)])

rmpath('../../');