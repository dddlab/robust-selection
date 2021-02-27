Robust Selection
================

[![PyPI version](https://badge.fury.io/py/robust-selection.svg)](https://badge.fury.io/py/robust-selection) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dddlab/robust-selection/main?filepath=examples%2Frobsel_cv_example.ipynb)

Python Package by **C Tran**, P Cisneros-Velarde, A Petersen and S-Y Oh

This repository provides a Python package for Robust Selection algorithm 
for estimation of the graphical lasso regularization parameter.

P Cisneros-Velarde, A Petersen and S-Y Oh (2020). Distributionally Robust Formulation and Model Selection for the Graphical Lasso. Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics. [[PMLR](http://proceedings.mlr.press/v108/cisneros20a.html)][[Papers with Code](https://paperswithcode.com/paper/distributionally-robust-formulation-and-model)]

![CV vs. RobSel](https://github.com/dddlab/robust-selection/raw/main/examples/cv-vs-robsel.png)

## Installation
To install R package with devtools, run the following command in your R console:
```r
devtools::install_github("dddlab/robust-selection/R-package")
```

If you also want install the vignettes along with the package, type instead:

```r
devtools::install_github("dddlab/robust-selection/R-package", build_vignette = TRUE)
```

To install python package from pypi:
```bash
pip install robust-selection
```

