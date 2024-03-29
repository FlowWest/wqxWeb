# wqxWeb

WQX Web is a service provided by the EPA CDX to facilitate the submission of data 
to the WQX through CDX. This R package aims at providing an easy to use interface to all endpoints
defined by the WQX Web REST API. 

## Installation

You can install wqxWeb with the following:

```r
remotes::install_github("flowwest/wqxWeb")
```

Note that wqxWeb relies on python >= 3.6 and therefore a version must be available. 
Furthermore, the `wqxtools` python package is bundled with this repository as a 
git submodule, therefore a command-line git interface must be available in order for `remotes` 
to properly install this package. 

wqxWeb is in early development, and we hope to streamline the installation process among 
other components in the near future.

## Getting Started

### Prerequesites

wqxWeb exports a function for each of the endpoints provided by the WQX Web API. 

In order to use this service, you must be registered with the CDX and have created a private key.
More information on these steps [here](https://cdx.epa.gov/about/userguide). 


## Details

Currently the R package wraps a python package `wqxtools` with mirror functions that allow the 
R interface. 

To start an upload session, call the `cdx` function with the proper parameters and save it as an object. You will call the session object as a parameter in the subsequent functions `cdx_upload`, `cdx_import`, `cdx_get_status`, and `cdx_submit_to_cdx`. 
