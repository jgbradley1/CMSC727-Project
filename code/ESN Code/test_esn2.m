function esn = test_esn2(esn, dataFile, testLen)

	%{
	dataFile - data file to be used for testing
	testLen  - amount of data to be used for testing
	%}
	esn.testLength = testLen;

	% load the data (e.g. MackeyGlass_t17.txt)
	data = load(dataFile);

	% run the ESN in generative mode
	% generate the next testLen number of data points
	Y = zeros(testLen, esn.outputSize);
	u = data(esn.trainLength, 1:esn.inputSize)';
	x = esn.x;
    % computer y(n)
    y = tanh(esn.W_out*[u; x]);
    
    u = data(esn.trainLength+1, 1:esn.inputSize)';
	for t = 1:testLen
		x = tanh(esn.W_in*u + esn.W*x + esn.W_back*y);
        
        y = tanh(esn.W_out*[u; x]);

		Y(t, :) = y';
        
		% reset u for next iteration
        if t < testLen
            
            % GENERATIVE MODE -- this mode will only work if the number of
            % input nodes equals the number of output nodes
            %u = y;
        
            % PREDICTIVE MODE
            u = data(esn.trainLength+1+t, 1:esn.inputSize)';
        end
    end
    
    
	% compute error
    mse = sum(((data(esn.trainLength+1 : esn.trainLength+testLen, size(data,2)) - Y).^2) ./ testLen);
    
    %errorLen = 500;
	%mse = sum((data(esn.trainLength+2 : esn.trainLength+errorLen+1, size(data,2)) - Y(1:errorLen, 1)).^2) ./ errorLen;
    
	esn.mse = mse;
end