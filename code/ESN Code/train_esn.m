function esn = train_esn(esn, dataFile, trainLen, initLen)

	%{
	trainLen - amount of data to be used for training
	initLen  - amount of data to "skip" when training
	%}
	esn.trainLength = trainLen;
	esn.skipLength = initLen;


	% allocate memory for the collected states
	esn.X = zeros(1+esn.numInputs + esn.reservoirSize, trainLen-initLen);


	% load the data
	data = load(dataFile);


	% define the target matrix
	esn.target = data(initLen+2:trainLen+1, size(data, 2))';


	% run the data through the reservoir and collect each state x
	x = zeros(esn.reservoirSize,1);
	for t = 1:trainLen
		u = data(t, 1:esn.numInputs);
		x = (1-esn.leak_rate)*x + esn.leak_rate*tanh( esn.IW*[1;u] + esn.RW*x );
		if t > initLen
			esn.X(:,t-initLen) = [1;u;x];
		end
	end

	esn.x = x; % last reservoir state in training cycle - to be used when running test data

	% train the output - using pseudoinverse method
	reg = 1e-8;  % regularization coefficient - used for data smoothing
	X_T = esn.X';
	esn.OW = (esn.target*X_T) / (esn.X*X_T + reg*eye(1+esn.numInputs+esn.reservoirSize));
