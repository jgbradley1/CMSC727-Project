NOTES

1)
To run an ESN with NO backpropagation connections from the output to the reservoir, use main.m.
To run an ESN that HAS backpropagation connections from the output to the reservoir, use main2.m.
To run the comparison experiments, simply run the appropriate experiment script in the Comparison code directory. Results will be placed into a corresponding .mat file. Note that these require the Matlab Neural Network Toolbox.


2)
'MackeyGlass_t17' and 'MackeyGlass_t17_single_column' are the exact same datasets, except 'MackeyGlass_t17' has two columns. The second column is a copy of the first column. This was created because of the format expected by the train_esn2() and test_esn2() functions.


3)
gen_esn2(), train_esn2(), and test_esn2() expect the following format of a datafile

pattern1_feature1, pattern1_feature2, pattern1_feature3,...,pattern1_featureN, target_output1
pattern2_feature1, pattern2_feature2, pattern2_feature3,...,pattern2_featureN, target_output2
pattern3_feature1, pattern3_feature2, pattern3_feature3,...,pattern3_featureN, target_output3
pattern4_feature1, pattern4_feature2, pattern4_feature3,...,pattern4_featureN, target_output4


The last column of the datafile must hold the target output. There can only be one column of target output.


4)
generate_freqGen_sequence(...) is a function that generates data for the tunable frequency generator task.
generate_NARMA_sequence(...) is a function that generates data based on the nonlinear autoregressive moving average (NARMA) model.


5)
sigmoid(...) and sigmoid_inverse(...) are not currently used/called as activation functions in the code. They were used for development purposes only, however we may decide to use them in our testing. Using a different activation function than the one currently being utilized (tanh and atanh) may produce better results.