function [middel, med, varians, stdafv, data_max, data_min] = deskriptorer(data,antal_bins)

interval = (ceil(max(data)) - floor(min(data)))/antal_bins
bins = floor(min(data)):interval:ceil(max(data))

histogram(data, bins, "Normalization","probability")

middel = mean(data);
med = median(data);
varians = var(data, 1);
stdafv = std(data, 1);
data_max = max(data)
data_min = min(data)

end