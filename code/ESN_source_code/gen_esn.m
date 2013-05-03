function esn = gen_esn(inputSize, resSize, outputSize, leakRate)
	
	% define the ESN parameters
	esn.numInputs = inputSize;
	esn.reservoirSize = resSize;
	esn.numOutputs = outputSize;
	esn.leak_rate = leakRate;
	esn.totalUnits = inputSize + resSize + outputSize;


	% generate the ESN network + reservoir matrices
	esn.IW = 2.0 * rand(resSize,1+inputSize) - 1.0;
	esn.RW = 2.0 * rand(resSize,resSize) - 1.0;


	% ensure the reservoir has the echo state property
	% normalize and set spectral radius
	%disp 'Computing spectral radius...';
	rhoW = abs(eigs(esn.RW,1));			% find the "largest eigenvalue" (by the "largest magnitude" measure scale)
	esn.RW = esn.RW .* ( 1.25 /rhoW);
	