cols = {'pwr_rp','pwr_elm'};
sizes = [25:25:200];
times = zeros(3,2);
result = zeros(8,2);

for s = 1:8
  net_size = sizes(s);
  for run = 1:3
    power_rp; times(run,1) = max(tr.time);
    power_elman; times(run,2) = max(tr.time);
  end
  result(s, :) = mean(times);
end

save('power_times.mat','cols','sizes','result');
