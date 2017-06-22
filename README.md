## Summary

This repository contains concrete application examples for the [micompr] [R]
package, which implements a procedure for comparing multivariate samples
associated with different groups.

These examples are described in detail in the following reference:

* Fachada N, Rodrigues J, Lopes VV, Martins RC, Rosa AC. (2016) micompr: An R
Package for Multivariate Independent Comparison of Observations. *The R Journal*
8(2):405–420.
https://journal.r-project.org/archive/2016-2/fachada-rodrigues-lopes-etal.pdf

## Examples

### Simulation model with multiple outputs

The replication of a simulation model in a new context highlights differences
between the conceptual and implemented models, as well as inconsistencies in
the conceptual model specification, promoting model verification, model
validation and model credibility

In this example, provided in the [pphpc.R](pphpc.R) script, [micompr] is used
for comparing the outputs of two implementations of the [PPHPC] agent-based
model. The compared output data used available at
https://zenodo.org/record/46848. Uncompress this data to a local folder, and
specify the folder in the [`dir_data`](https://github.com/fakenmc/micompr-examples/blob/master/pphpc.R#L5)
variable within the script.

### Monthly sunspots

### Saugeen river flow

### PH2 database of dermoscopic images


### License

[MIT License](LICENSE)

[micompr]:https://github.com/fakenmc/micompr
[R]: https://www.r-project.org/
[PPHPC]: https://github.com/fakenmc/pphpc

