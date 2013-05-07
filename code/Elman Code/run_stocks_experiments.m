cols = {'stk_rp','stk_elm','stk_jor'};
sizes = [25:25:200];
num_per = 3;
mses = zeros(num_per,3);
result = zeros(8,3);

for s = 1:8
  net_size = sizes(s);
  for i = 1:num_per
    stocks_rp; mses(i,1) = mse;
    stocks_elman; mses(i,2) = mse;
    stocks_jordan; mses(i,3) = mse;
  end
  result(s, :) = min(mses);
end

save('stocks_results.mat','cols','sizes','result');
