function esn = test_esn(esn, dataFile, testLen)

	%{
	dataFile - data file to be used for testing
	testLen  - amount of data to be used for testing
	%}
	esn.testLength = testLen;

	% load the data (e.g. MackeyGlass_t17.txt)
	data = load(dataFile);

	% run the ESN in generative mode
	% generate the next testLen number of data points
	Y = zeros(esn.numOutputs,testLen);
	u = data(esn.trainLength+1);
	x = esn.x;
	for t = 1:testLen
		x = (1-esn.leak_rate)*x + esn.leak_rate*tanh( esn.IW*[1;u] + esn.RW*x );
		y = esn.OW*[1;u;x];
		Y(:,t) = y;
        
        % reset u for next iteration
        if t < testLen
            
            % GENERATIVE MODE -- this mode will only work if the number of
            % input nodes equals the number of output nodes
            %u = y;
        
            % PREDICTIVE MODE
            u = data(esn.trainLength+t+1);
        end
	end

	esn.x = x;

	% compute error
	%errorLen = 500;
	%mse = sum((data(esn.trainLength+2 : esn.trainLength+errorLen+1)' - Y(1, 1: errorLen)).^2) ./ errorLen;
    
    mse = sum((data(esn.trainLength+2 : esn.trainLength+testLen+1)' - Y(1, 1: testLen)).^2) ./ testLen;

	esn.mse = mse;
	