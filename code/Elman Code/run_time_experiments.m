cols = {'pwr_rp','pwr_elm'};
sizes = [25:25:200];
times = zeros(1,2);
result = zeros(8,2);

for s = 1:8
  net_size = sizes(s);
  power_rp; result(s,1) = max(tr.time);
  power_elman; result(s,2) = max(tr.time);
end

save('power_times.mat','cols','sizes','result');
