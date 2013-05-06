inputSize = 1;
outputSize = 1;
leakRate = 0.5;
spectralRadius = 0.5;
reservoirSize = 100;

trainingSize = 4000;
testingSize = 1000;
forgetSize = 100;

disp('Mackey Glass Dataset');
disp('Forget Size Optimization');

X = zeros(19, 1);      % will hold values for graphing the horizontal axis later on, initial array size doesn't matter
Y = zeros(19, 1);      % will hold values for graphing the vertical axis later on, initial array size doesn't matter

counter = 1;

for forgetSize = 0:10:500
    % gen_esn(inputSize, resSize, outputSize, leakRate, spectral_radius)
    net = gen_esn(inputSize, reservoirSize, outputSize, leakRate, spectralRadius);

    % train_esn(esn, dataFile, trainLen, initLen)
    net = train_esn(net, 'data/MackeyGlass_t17_single_column', trainingSize, forgetSize);
    
    % test_esn(esn, dataFile, testLen)
    net = test_esn(net, 'data/MackeyGlass_t17_single_column', testingSize);
    
    % record leak rate and mse for graphing
    X(counter) = forgetSize;
    Y(counter) = net.mse;
    counter = counter+1;
    
    disp (['Forget Size: ', num2str(forgetSize), '    Error Rate: ', num2str(net.mse)]);
end

bar(X, Y);
title('Forget Size Optimization For Mackey Glass');
xlabel('Forget Size');
ylabel('MSE');

% axis([xmin xmax ymin ymax]) -- leave a little room above the maximum of Y
% for asthetic purposes
axis([-5 505 0 max(Y)+0.05*max(Y)])