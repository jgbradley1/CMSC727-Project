cols = {'mky_rp','mky_elm','mky_jor'};
sizes = [25:25:200];
mses = zeros(3,3);
result = zeros(8,3);

for s = 1:8
  net_size = sizes(s);
  for i = 1:3
    mackey_rp; mses(i,1) = mse;
    mackey_elman; mses(i,2) = mse;
    mackey_jordan; mses(i,3) = mse;
  end
  result(s, :) = min(mses);
end

save('mackey_results.mat','cols','sizes','result');

