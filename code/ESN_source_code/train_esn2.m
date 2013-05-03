function esn = train_esn2(esn, dataFile, trainLen, skipLen)

	%{
	trainLen - amount of data to be used for training
	skipLen  - amount of data to "skip" when training (default = 1)
	%}
	esn.trainLength = trainLen;
    if skipLen < 1
        esn.skipLength = 1;
    else
        esn.skipLength = skipLen;
    end


	%{
	M - a state collecting matrix of size (T - T_0 + 1) x (K + N + L)
		where T = final time and T_0 = beginning time
	% reminder: matlab matrices are not zero-indexed, hence the +1
	%}
	esn.M = zeros(trainLen-esn.skipLength, esn.inputSize + esn.resSize);
	esn.T = zeros(trainLen-esn.skipLength, esn.outputSize);


	% load the data (e.g. MackeyGlass_t17.txt)
	data = load(dataFile);


	% define d = target matrix with the teacher output
	% teacher output is assumed to be the last columns of data
	% with column subscript range (inputSize+1) - size(data, 2) 
	% reminder: matlab matrices are not zero-indexed, hence the +1
	esn.d = data(1:trainLen, size(data, 2));
    
	% run the data through the reservoir and collect each state x
	% Drive the network by the training data,for times t=0,...,T, by presenting the teacher input u(n), and by teacher-forcing the teacher output d(n-1)
	x = zeros(esn.resSize,1); % x(0) = 0
    
    %u = data(1, 1:esn.inputSize)';
    
	for t = 0:trainLen-1
        
        u = data(t+1, 1:esn.inputSize)'; % will be a K x 1 vector, represents u(t+1)
        
		% calculate x(t+1)
		if t == 0
            % compute x(1)
            % assume d(0)=0 and x(0)=0
            x = (1-esn.leak_rate)*x + esn.leak_rate*tanh(esn.W_in*u + esn.W*x);
        else
            x = (1-esn.leak_rate)*x + esn.leak_rate*tanh(esn.W_in*u + esn.W*x + esn.W_back*esn.d(t, :));
        end
        
        % store [u(t), x(t)] in collection matrix M
        % store atanh(d(t)) in collection matrix T
        if t >= esn.skipLength
            esn.M(t-esn.skipLength+1, :) = [u', x'];
            esn.T(t-esn.skipLength+1, :) = atanh(esn.d(t, :))';  % store the target matrix d row-wise into the teacher collection matrix T, producing a (trainLen-skipLen) x L matrix
        end
        
    end
    
	esn.x = x; % last reservoir state in training cycle

	% train the output - using pseudoinverse method
	% we really want the equation W_out' = inv(M)*T
	% As suggested by MathWorks, the equation W_out' = M \ T
	% can be used instead (faster runtime, better accuracy).
	% The solution is produced using Gaussian elimination
	esn.W_out = (pinv(esn.M) * esn.T);
    esn.W_out = esn.W_out';
end
