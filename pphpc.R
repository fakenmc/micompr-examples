# Copyright (c) 2016 Nuno Fachada
# Distributed under the MIT License (http://opensource.org/licenses/MIT)

# Base dataset folder
dir_data <- "~/pphpc_data/"

# Load library
library(micompr)

# Output names
outputs <- c("$P^s$", "$P^w$", "$P^c$", "$\\mean{E}^s$",
             "$\\mean{E}^w$", "$\\mean{C}$", "$\\widetilde{A}$")

# Outputs from the NetLogo implementation
dir_nl_ok <- paste0(dir_data, "nl_ok")
# Outputs from the Java implementation, first configuration
dir_jex_ok <- paste0(dir_data, "j_ex_ok")
# Outputs from the Java implementation, second configuration
dir_jex_noshuff <- paste0(dir_data, "j_ex_noshuff")
# Outputs from the Java implementation, third configuration
dir_jex_diff <- paste0(dir_data, "j_ex_diff")

# Files for model size 400, parameter set 1
filez <- glob2rx("stats400v1*.txt")

# Perform the three comparison cases
mic <- micomp(outputs,
              ve_npcs = 0.75,
              list(list(name = "I",
                        folders = c(dir_nl_ok, dir_jex_ok),
                        files = c(filez, filez),
                        lvls = c("NLOK", "JEXOK")),
                   list(name = "II",
                        folders = c(dir_nl_ok, dir_jex_noshuff),
                        files = c(filez, filez),
                        lvls = c("NLOK", "JEXNS")),
                   list(name = "III",
                        folders = c(dir_nl_ok, dir_jex_diff),
                        files = c(filez, filez),
                        lvls = c("NLOK","JEXDIF"))),
              concat = T)

# LaTeX table
toLatex(mic,
        booktabs = T,
        data_show = c("npcs-1", "mnvp-1", "parp-1", "scoreplot"),
        data_labels = c("$\\#$PCs", "MNV", "$t$-test", "PCS"),
        col_width = T,
        pvalf_params = list(minval = 1e-8, na_str = "*"),
        label = "tab:pphpc",
        caption = paste("Comparison of a NetLogo implementation of",
                        "the PPHPC model against three configurations",
                        "of a parallel Java implementation."))
