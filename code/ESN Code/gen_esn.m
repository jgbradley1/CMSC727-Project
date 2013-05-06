function esn = gen_esn(inputSize, resSize, outputSize, leakRate, spectral_radius)
	
	% define the ESN parameters
	esn.numInputs = inputSize;
	esn.reservoirSize = resSize;
	esn.numOutputs = outputSize;
	esn.leak_rate = leakRate;
    esn.alpha = spectral_radius;
	esn.totalUnits = inputSize + resSize + outputSize;


	% generate the ESN network + reservoir matrices
	esn.IW = 2.0 * rand(resSize,1+inputSize) - 1.0;
	esn.RW = 2.0 * rand(resSize,resSize) - 1.0;


	% ensure the reservoir has the echo state property
	% normalize and set spectral radius
	
    opts.tol = 1e-3;                        % reduce the tolerance of the eigs() function
	rhoW = abs(eigs(esn.RW,1, 'lm', opts));       % find the "largest eigenvalue" (by the "largest magnitude" measure scale)
    esn.RW = esn.RW .* (1/rhoW);            % Normalize W to have unit spectral radius
    
    esn.RW = esn.alpha .* esn.RW;           % Redefine W to have a spectral radius of alpha
end