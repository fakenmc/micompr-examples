# Copyright (c) 2016 Nuno Fachada
# Distributed under the MIT License (http://opensource.org/licenses/MIT)

# Location of resized images
imgfolder <- "~/PH2/images_resize/"

# File specifing observation levels, i.e., the sample to which observations
# (images) are associated with
grpsfile <- "derma_levels.tsv"

# Load libraries
library(bmp)
library(micompr)

# Image definitions
imgs <- dir(imgfolder)
nimgs <- length(imgs)
npixels <- 760 * 570

# Specify image groups (Common nevi, atypical nevi,
# melanomas).
f <- read.table(grpsfile, row.names = 1)
grps <- f[order(row.names(f)), ]

# Read images from disk
# Use different color channels as outputs, and also
# use a concatenated output
rimgs <- matrix(nrow = nimgs, ncol = npixels)
gimgs <- matrix(nrow = nimgs, ncol = npixels)
bimgs <- matrix(nrow = nimgs, ncol = npixels)
rgbimgs <- matrix(nrow = nimgs, ncol = npixels * 3)

for (i in 1:nimgs) {

  cimg <- read.bmp(paste0(imgfolder, imgs[i]))
  rimgs[i, ] <- c(cimg[ , , 1])
  gimgs[i, ] <- c(cimg[ , , 2])
  bimgs[i, ] <- c(cimg[ , , 3])
  rgbimgs[i, ] <- c(cimg[ , , 1], cimg[ , , 2], cimg[ , , 3])

}

# Perform multivariate independent comparison of images
mic <-
  micomp(outputs = c("R", "G", "B", "RGB"),
         ve_npcs = 0.9,
         comps = list(
           list(name = "1v2",
                grpout = list(
                  data = list(R = rimgs[grps != 3, ],
                              G = gimgs[grps != 3, ],
                              B = bimgs[grps != 3, ],
                              RGB = rgbimgs[grps != 3, ]),
                  factors = factor(grps[grps != 3]))),
           list(name = "1v3",
                grpout = list(
                  data = list(R = rimgs[grps != 2, ],
                              G = gimgs[grps != 2, ],
                              B = bimgs[grps != 2, ],
                              RGB = rgbimgs[grps != 2, ]),
                  factors = factor(grps[grps != 2]))),
           list(name = "2v3",
                grpout = list(
                  data = list(R = rimgs[grps != 1, ],
                              G = gimgs[grps != 1, ],
                              B = bimgs[grps != 1, ],
                              RGB = rgbimgs[grps != 1, ]),
                  factors = factor(grps[grps != 1])))))

###
### LATEX Table
###

toLatex(mic,
        booktabs = T,
        data_show = c("parp-1", "nparp-1", "scoreplot"),
        data_labels = c("$t$-test", "U test", "PCS"),
        pvalf_params = list(minval = 1e-8, na_str = "*"),
        label = "tab:melanoma",
        caption = paste("Comparison of PH$^2$ dataset images",
                        "grouped by lesion type."))
