# Copyright (c) 2016 Nuno Fachada
# Distributed under the MIT License (http://opensource.org/licenses/MIT)

# Load library
library(micompr)

# Months in the 1749-1859 interval (110 years)
# Months in the 1902-2012 interval (110 years)
m <- sunspot.month[c(1:1320, 1837:3156)]
m <- matrix(m, nrow = 20)

# Factor vector, two levels:
# a) ten 11-year cycles from 1749 to 1859
# b) ten 11-year cycles from 1902 to 2012
groups <- factor(c(rep("A", 10), rep("B", 10)))

# Compare the two groups, use 9 PCs for MANOVA
cmp <- cmpoutput("SunSpots", 9, m, groups)
