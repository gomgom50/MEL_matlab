function [middel, med, varians, stdafv, data_max, data_min] = deskriptorer(data)

middel = mean(data);
med = median(data);
varians = var(data, 1);
stdafv = std(data, 1);
data_max = max(data)
data_min = min(data)

end