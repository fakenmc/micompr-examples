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
model. The compared output data is available at
https://zenodo.org/record/46848. Uncompress the data to a local folder, and
specify the folder in the
[`dir_data`](https://github.com/fakenmc/micompr-examples/blob/master/pphpc.R#L5)
variable within the script.

### Monthly sunspots

This example, provided in the [sunspot.R](sunspot.R) script, uses the monthly
sunspot data included with [R], which contains the monthly numbers of sunspots
from 1749 to the present day. The example aims to answer the following question:
_Were the solar cycles during the 1749–1859 interval significantly different
from the more recent observations?_

### Saugeen river flow

This example, provided in the [saugeen.R](saugeen.R) script, uses the Saugeen
River daily flow data included in the [deseasonalize] [R] package. This data
consists of a time series of the rivers’ daily flow (m<sup>3</sup>/s) from 1915
to 1979. The example aims to answer the following question: _is there any
statistical difference between the flow dynamics during the 1915–1944 and
1950–1979 periods (perhaps due to climate change or some other factor)?_

### PH<sup>2</sup> database of dermoscopic images

In this example we use the tools provided by the [micompr] package to study the
[PH<sup>2</sup> database](https://www.fc.up.pt/addi/ph2%20database.html) of
dermoscopic images. This image database contains a total of 200 dermoscopic
images of melanocytic lesions, including, from benign to more serious, 80
common nevi, 80 atypical nevi, and 40 melanomas. The goal is to verify if
images of the three types of lesions form statistically distinguishable
samples.

This example is provided in the [derma.R](derma.R) script. However, the
following pre-processing of the images was performed (using [ImageMagick]
command-line utilities under Linux) before comparing them with [micompr]:

* Since each image comes in its own separate folder, we first copy all the
images to the same folder:

```sh
# List folders (within the "PH2 Dataset images" folder) containing images
DIRS=`ls PH2\ Dataset\ images/`

# Create "images" folder
mkdir -p images

# Copy all images to the "images" folder
for DIR in $DIRS
do
  cp PH2\ Dataset\ images/${DIR}/${DIR}_Dermoscopic_Image/${DIR}.* images
done
```

* These are 8-bit RGB color images, with a resolution of purportedly 768 × 560
pixels. The following command shows this is not the case, and that the image
sizes vary between 761 × 570 and 769 × 577:

```sh
# List all PH2 images
IMGS=`ls images/`

# Check properties of all images
for IMG in $IMGS
do
  identify images/${IMG} | cut -d " " -f 3,5
done
```

* As such, we resize all images to 760 × 570 prior before comparing them with
[micompr]:

```sh
# List all PH2 images
IMGS=`ls images/`

# Create a folder for the resized images
mkdir -p images_resize

# Resize all images to 760 × 570
for IMG in $IMGS
do
  convert images/${IMG} -resize 760x570\! images_resize/${IMG}
done
```

The folder containing the resized images is specified in the
[`imgfolder`](https://github.com/fakenmc/micompr-examples/blob/master/derma.R#L5)
variable within the [derma.R](derma.R) script.

## License

[MIT License](LICENSE)

[deseasonalize]:https://cran.r-project.org/package=deseasonalize
[micompr]:https://github.com/fakenmc/micompr
[R]:https://www.r-project.org/
[PPHPC]:https://github.com/fakenmc/pphpc
[ImageMagick]:https://www.imagemagick.org/

