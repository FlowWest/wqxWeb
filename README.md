# wqxWeb

The WQX Web is a service provided by the EPA CDX to faciliate the submission of data 
to the WQX. This R package aims at providing an easy to use interface to all endpoints
defined by the WQX Web REST API. 

## Installation

You can install wqxWeb with the following:

```r
remotes::install_github("flowwest/wqxWeb")
```

Note that wqxWeb relies on python >= 3.6 and therefore a version must be available. 
Aslo note that the `wqxtools` python package is bundled with this repository as a 
git submodule, therefore a command-line git interface must be available in order for `remotes` 
to properly install this package. 

wqxWeb is in early development, and we hope to streamline installation among other components.

## Details

Currently the R package wraps a python package `wqxtools` with mirror functions that allow the 
R interface.
