Robust Selection
================

[![Badge](https://www.r-pkg.org/badges/version/robsel)](https://cran.r-project.org/web/packages/robsel/index.html)
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
To install from CRAN
```r
install.packages("robsel")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(robsel)
## basic example code
x <- matrix(rnorm(100*5),ncol=5)
```
### Estimate lambda for glasso
``` r
lambda <- robsel(x, alpha=0.9, B=200)
lambda
#> [1] 0.1561845
```
### Use glasso directly with robsel estimate
```r
glasso.model <- robsel.glasso(x, alpha=0.9)
glasso.model
#> $alpha
#> [1] 0.9
#> 
#> $lambda
#> [1] 0.1596663
#> 
#> $Sigma
#> $Sigma[[1]]
#>             [,1]        [,2]     [,3]        [,4]     [,5]
#> [1,]  1.04954034  0.02769511 0.000000 -0.08435207 0.000000
#> [2,]  0.02769511  1.25358486 0.000000 -0.00222587 0.000000
#> [3,]  0.00000000  0.00000000 1.092117  0.00000000 0.000000
#> [4,] -0.08435207 -0.00222587 0.000000  1.12448050 0.000000
#> [5,]  0.00000000  0.00000000 0.000000  0.00000000 1.246764
#> 
#> 
#> $Omega
#> $Omega[[1]]
#>             [,1]        [,2]      [,3]       [,4]      [,5]
#> [1,]  0.95913305 -0.02106219 0.0000000 0.07190696 0.0000000
#> [2,] -0.02106219  0.79817757 0.0000000 0.00000000 0.0000000
#> [3,]  0.00000000  0.00000000 0.9156528 0.00000000 0.0000000
#> [4,]  0.07190696  0.00000000 0.0000000 0.89469360 0.0000000
#> [5,]  0.00000000  0.00000000 0.0000000 0.00000000 0.8020765
```
### Using robsel with multiple confidence levels alpha
```r
robsel(x, alpha=c(0.1,0.9))
#> [1] 0.3266095 0.1571961
robsel.glasso(x, alpha=c(0.1,0.9))
#> $alpha
#> [1] 0.1 0.9
#> 
#> $lambda
#> [1] 0.3179958 0.1588493
#> 
#> $Sigma
#> $Sigma[[1]]
#>         [,1]     [,2]     [,3]    [,4]     [,5]
#> [1,] 1.20787 0.000000 0.000000 0.00000 0.000000
#> [2,] 0.00000 1.411914 0.000000 0.00000 0.000000
#> [3,] 0.00000 0.000000 1.250446 0.00000 0.000000
#> [4,] 0.00000 0.000000 0.000000 1.28281 0.000000
#> [5,] 0.00000 0.000000 0.000000 0.00000 1.405093
#> 
#> $Sigma[[2]]
#>             [,1]         [,2]   [,3]         [,4]     [,5]
#> [1,]  1.04872328  0.028512174 0.0000 -0.085169133 0.000000
#> [2,]  0.02851217  1.252767801 0.0000 -0.002315537 0.000000
#> [3,]  0.00000000  0.000000000 1.0913  0.000000000 0.000000
#> [4,] -0.08516913 -0.002315537 0.0000  1.123663436 0.000000
#> [5,]  0.00000000  0.000000000 0.0000  0.000000000 1.245947
#> 
#> 
#> $Omega
#> $Omega[[1]]
#>           [,1]      [,2]      [,3]      [,4]      [,5]
#> [1,] 0.8279038 0.0000000 0.0000000 0.0000000 0.0000000
#> [2,] 0.0000000 0.7082583 0.0000000 0.0000000 0.0000000
#> [3,] 0.0000000 0.0000000 0.7997144 0.0000000 0.0000000
#> [4,] 0.0000000 0.0000000 0.0000000 0.7795387 0.0000000
#> [5,] 0.0000000 0.0000000 0.0000000 0.0000000 0.7116965
#> 
#> $Omega[[2]]
#>             [,1]        [,2]      [,3]       [,4]      [,5]
#> [1,]  0.96003670 -0.02171539 0.0000000 0.07272214 0.0000000
#> [2,] -0.02171539  0.79872675 0.0000000 0.00000000 0.0000000
#> [3,]  0.00000000  0.00000000 0.9163384 0.00000000 0.0000000
#> [4,]  0.07272214  0.00000000 0.0000000 0.89545824 0.0000000
#> [5,]  0.00000000  0.00000000 0.0000000 0.00000000 0.8026025
```
