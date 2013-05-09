cols = {'pwr_rp','pwr_elm','pwr_jor'};
sizes = [25:25:200];
mses = zeros(3,3);
result = zeros(8,3);

for s = 1:8
  net_size = sizes(s);
  for run = 1:3
    power_rp; mses(run,1) = mse;
    power_elman; mses(run,2) = mse;
    power_jordan; mses(run,3) = mse;
  end
  result(s, :) = min(mses);
end

save('power_results.mat','cols','sizes','result');
