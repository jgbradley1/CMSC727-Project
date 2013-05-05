function [ a ] = sigmoid_inverse( z )
% Computes the inverse of the sigmoid function -- logit() will perform the
% same calculation
    a = log(z) - log(1-z);

end