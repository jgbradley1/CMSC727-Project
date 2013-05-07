cols = {'mky_rp','mky_elm','mky_jor'};
sizes = [25:25:200];
mses = zeros(3,3);
result = zeros(8,3);

for s = 1:8
  net_size = sizes(s);
  for run = 1:3
    mackey_rp; mses(run,1) = mse;
    mackey_elman; mses(run,2) = mse;
    mackey_jordan; mses(run,3) = mse;
  end
  result(s, :) = min(mses);
end

save('mackey_results.mat','cols','sizes','result');

