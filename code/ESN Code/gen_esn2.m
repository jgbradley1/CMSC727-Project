function esn = gen_esn2(inputSize, resSize, outputSize, leakRate, alpha, outputToReservoirConnections)
	
	% define the ESN parameters
	esn.inputSize = inputSize;
	esn.resSize = resSize;
	esn.outputSize = outputSize;
	esn.totalUnits = inputSize + resSize + outputSize;
    esn.leak_rate = leakRate;
    esn.alpha = alpha;


	% generate the ESN network + reservoir matrices
	%{
	Using the notation
		K # of input units
		N # of internal units
		L # of output units

	W_in = N x K input matrix
	W = N x N reservoir matrix
	W_out = L x (K+N) output matrix		<- will be calculated later
	W_back = N x L backpropagation weight matrix
	%}

	esn.W_in = 2.0 * rand(resSize,inputSize) - 1.0;
	esn.W = 2.0 * rand(resSize,resSize) - 1.0;
	
    backConnections = strcmp('Yes', outputToReservoirConnections);
    if (backConnections == 1)
        esn.W_back = 2.0 * rand(resSize,outputSize) - 1.0;
    else
        esn.W_back = zeros(resSize,outputSize);
    end
    
	%{
	- ensure the reservoir has the echo state property
	- normalize W to a matrix with unit spectral redius
	  by setting W = 1/rhoW * W
	- Scale W to a spectral radius of alpha (where alpha < 1) by setting
	  W = W *. alpha
	- small alpha -> use for fast, short-memory tasks
	- large alpha -> use for slow, long-memory tasks
	%}
    
    opts.tol = 1e-3;                                % reduce the tolerance of the eigs() function
	rhoW = abs(eigs(esn.W,1, 'lm', opts));          % find the "largest eigenvalue" (by the "largest magnitude" measure scale)

	esn.W = esn.W .* (1/rhoW);                      % Normalize W to have unit spectral radius
	esn.W = esn.alpha .* esn.W;                     % Redefine W to have a spectral radius of alpha
end