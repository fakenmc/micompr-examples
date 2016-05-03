# Copyright (c) 2016 Nuno Fachada
# Distributed under the MIT License (http://opensource.org/licenses/MIT)

# Load libraries
library(micompr)
library(deseasonalize)

# Unique years
years <- unique(sapply(rownames(SaugeenDay), substr, 1, 4))

# Number of days in each year
ndays <- sapply(years, function(x) sum(substr(rownames(SaugeenDay), 1, 4) == x))

# Indexes of last day in each year
lastdays <- cumsum(ndays)

# Prepare data for PCA
saugdata <- t(mapply(
  function(nd, ld) {
    rflows <- rep(NA, 366)
    rflows[1:nd] <- SaugeenDay[(ld - nd + 1):ld]
    # Discard last day in leap years
    rflows[1:365]
  },
  ndays, lastdays))

# Consider first 30 years and last 30 years (discard 5 years in between)
saugdata <- saugdata[c(1:30, 36:65), ]

# Factor vector, two levels: first 30 years and last 30 years
groups <- factor(c(rep("A", 30), rep("B", 30)))

# Compare
cmp <- cmpoutput("SaugeenFlow", 0.9, saugdata, groups)

# Plot output comparison
plot(cmp)