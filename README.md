Robust Selection
================

[![PyPI version](https://badge.fury.io/py/robust-selection.svg)](https://badge.fury.io/py/robust-selection) 

R and Python Package by **C Tran**, P Cisneros-Velarde, A Petersen and S-Y Oh

This repository provides a Python package for Robust Selection algorithm 
for estimation of the graphical lasso regularization parameter.

P Cisneros-Velarde, A Petersen and S-Y Oh (2020). Distributionally Robust Formulation and Model Selection for the Graphical Lasso. Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics. [[PMLR](http://proceedings.mlr.press/v108/cisneros20a.html)][[Papers with Code](https://paperswithcode.com/paper/distributionally-robust-formulation-and-model)]

![CV vs. RobSel](https://github.com/dddlab/robust-selection/raw/main/examples/cv-vs-robsel.png)

# Python
## Installation
 To install python package from pypi:
```bash
pip install robust-selection
```

## Example
The basic example of RobSel can be found in this binder
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dddlab/robust-selection/main?filepath=examples%2Frobsel_cv_example.ipynb)

# R
## Installation
To install R package with devtools, run the following command in your R console:
```r
devtools::install_github("dddlab/robust-selection")
```
If you also want install the vignettes along with the package, type instead:
```r
devtools::install_github("dddlab/robust-selection", build_vignette = TRUE)
 ```
 
## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(robsel)
## basic example code
x <- matrix(rnorm(100*5),ncol=5)
#Estimate lambda for glasso
lambda <- robsel(x, alpha=0.9, B=200)
lambda
#> [1] 0.1708681
#Use glasso directly with robsel estimate
glasso.model <- robsel.glasso(x, alpha=0.9)
glasso.model
#> $alpha
#> [1] 0.9
#> 
#> $lambda
#> [1] 0.1680075
#> 
#> $Sigma
#> $Sigma$w
#>              [,1]     [,2]     [,3]     [,4]         [,5]
#> [1,]  1.196005929 0.000000 0.000000 0.000000 -0.007034997
#> [2,]  0.000000000 1.158448 0.000000 0.000000  0.000000000
#> [3,]  0.000000000 0.000000 1.228607 0.000000  0.000000000
#> [4,]  0.000000000 0.000000 0.000000 1.258977  0.000000000
#> [5,] -0.007034997 0.000000 0.000000 0.000000  1.292179663
#> 
#> 
#> $Omega
#> $Omega$wi
#>             [,1]      [,2]    [,3]      [,4]        [,5]
#> [1,] 0.836143033 0.0000000 0.00000 0.0000000 0.004552203
#> [2,] 0.000000000 0.8632241 0.00000 0.0000000 0.000000000
#> [3,] 0.000000000 0.0000000 0.81393 0.0000000 0.000000000
#> [4,] 0.000000000 0.0000000 0.00000 0.7942955 0.000000000
#> [5,] 0.004552203 0.0000000 0.00000 0.0000000 0.773910976
#Using robsel with multiple confidence level alpha
robsel(x, alpha=c(0.1,0.9))
#> [1] 0.3510959 0.1709872
robsel.glasso(x, alpha=c(0.1,0.9))
#> $alpha
#> [1] 0.1 0.9
#> 
#> $lambda
#> [1] 0.3469212 0.1655974
#> 
#> $Sigma
#> $Sigma[[1]]
#>         [,1]     [,2]    [,3]     [,4]     [,5]
#> [1,] 1.37492 0.000000 0.00000 0.000000 0.000000
#> [2,] 0.00000 1.337361 0.00000 0.000000 0.000000
#> [3,] 0.00000 0.000000 1.40752 0.000000 0.000000
#> [4,] 0.00000 0.000000 0.00000 1.437891 0.000000
#> [5,] 0.00000 0.000000 0.00000 0.000000 1.471093
#> 
#> $Sigma[[2]]
#>              [,1]     [,2]     [,3]     [,4]         [,5]
#> [1,]  1.193595777 0.000000 0.000000 0.000000 -0.009445148
#> [2,]  0.000000000 1.156038 0.000000 0.000000  0.000000000
#> [3,]  0.000000000 0.000000 1.226197 0.000000  0.000000000
#> [4,]  0.000000000 0.000000 0.000000 1.256567  0.000000000
#> [5,] -0.009445148 0.000000 0.000000 0.000000  1.289769511
#> 
#> 
#> $Omega
#> $Omega[[1]]
#>           [,1]      [,2]      [,3]     [,4]      [,5]
#> [1,] 0.7273153 0.0000000 0.0000000 0.000000 0.0000000
#> [2,] 0.0000000 0.7477411 0.0000000 0.000000 0.0000000
#> [3,] 0.0000000 0.0000000 0.7104693 0.000000 0.0000000
#> [4,] 0.0000000 0.0000000 0.0000000 0.695463 0.0000000
#> [5,] 0.0000000 0.0000000 0.0000000 0.000000 0.6797665
#> 
#> $Omega[[2]]
#>             [,1]      [,2]      [,3]     [,4]        [,5]
#> [1,] 0.837853126 0.0000000 0.0000000 0.000000 0.006135706
#> [2,] 0.000000000 0.8650238 0.0000000 0.000000 0.000000000
#> [3,] 0.000000000 0.0000000 0.8155299 0.000000 0.000000000
#> [4,] 0.000000000 0.0000000 0.0000000 0.795819 0.000000000
#> [5,] 0.006135706 0.0000000 0.0000000 0.000000 0.775377262
```
