addpath('../');

inputSize = 1;
outputSize = 1;
reservoirSize = 100;
leakRate = 0.5;
spectralRadius = 0.5;
forgetSize = 100;

trainingSize = 4000;
testingSize = 1000;

disp('Reservoir Size Optimization');

horizontalX = zeros(1, 1);      % will hold values for graphing the horizontal axis later on
mackeyErrorRate = zeros(1, 1);      % will hold values for graphing the vertical axis later on
powerErrorRate = zeros(1, 1);      % will hold values for graphing the vertical axis later on
stockErrorRate = zeros(1, 1);      % will hold values for graphing the vertical axis later on
counter = 1;

for reservoirSize = 5:5:200
    % Mackey Glass Test
    % inputSize = 1
    net = gen_esn2(1, reservoirSize, outputSize, leakRate, spectralRadius, 'No');
    net = train_esn2(net, '../data/MackeyGlass_t17_with_time', trainingSize, forgetSize);
    net = test_esn2(net, '../data/MackeyGlass_t17_with_time', testingSize);
    
    mackeyErrorRate(counter) = net.mse;
    
    
    % Power Test
    % inputSize = 6
    net = gen_esn2(6, reservoirSize, outputSize, leakRate, spectralRadius, 'No');
    net = train_esn2(net, '../data/power', trainingSize, forgetSize);
    net = test_esn2(net, '../data/power', testingSize);
    
    powerErrorRate(counter) = net.mse;
    
    
    % Stock Test
    net = gen_esn2(28, reservoirSize, outputSize, leakRate, spectralRadius, 'No');
    net = train_esn2(net, '../data/stocks', trainingSize, forgetSize);
    net = test_esn2(net, '../data/stocks', testingSize);
    
    stockErrorRate(counter) = net.mse;
    
    
    % record leak rate and mse for graphing
    horizontalX(counter) = reservoirSize;
    counter = counter+1;
    
    disp (['Reservoir Size: ', num2str(reservoirSize), '  Mackey Error: ', num2str(mackeyErrorRate(counter-1)), '  Power Error: ', num2str(powerErrorRate(counter-1)), '  Stock Error: ', num2str(stockErrorRate(counter-1))]);
end

plot(horizontalX, mackeyErrorRate); hold all;
plot(horizontalX, powerErrorRate); hold all;
plot(horizontalX, stockErrorRate); hold all;

legend('Mackey Glass', 'Power', 'Stocks');
title('Reservoir Size Optimization');
xlabel('Reservoir Size');
ylabel('MSE');

% axis([xmin xmax ymin ymax]) -- leave a little room above the maximum of Y
% for asthetic purposes
maxError = max([max(mackeyErrorRate), max(powerErrorRate), max(stockErrorRate)]);
axis([0 205 0 maxError+0.05*maxError])

addpath('../');