addpath('../');

outputSize = 1;
trainingSize = 4000;
testingSize = 1000;


% Mackey Glass Test with optimal parameters
net1 = gen_esn2(1, 100, outputSize, 1, 0.5, 'No');
net1 = train_esn2(net1, '../data/MackeyGlass_t17_with_time', trainingSize, 5);
net1 = test_esn2(net1, '../data/MackeyGlass_t17_with_time', testingSize);


% Power Test with optimal parameters
net2 = gen_esn2(6, 45, outputSize, 1, 0.05, 'No');
net2 = train_esn2(net2, '../data/power', trainingSize, 425);
net2 = test_esn2(net2, '../data/power', testingSize);


% Stock Test with optimal parameters
net3 = gen_esn2(28, 30, outputSize, 0.7, 0.05, 'No');
net3 = train_esn2(net3, '../data/stocks', trainingSize, 20);
net3 = test_esn2(net3, '../data/stocks', testingSize);


disp (['Optimal Performance --  Mackey Error: ', num2str(net1.mse), '  Power Error: ', num2str(net2.mse), '  Stock Error: ', num2str(net3.mse)]);
addpath('../');