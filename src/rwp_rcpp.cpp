// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-
#include <RcppEigen.h>
#include <Rcpp.h>
#include <cmath>
using namespace Rcpp;
using namespace std;
using namespace Eigen;
// [[Rcpp::depends(RcppEigen)]]



// Compute RWP function of Robust Selection
// [[Rcpp::export]]
Eigen::VectorXd rwp_rcpp(const Eigen::MatrixXd &X, int B){
    if (B == 0) {
        stop("Need more than 0 bootstrap sample");
    }
    const int n(X.rows());
    const int p(X.cols());
    if (n == 2) {
        stop("Sample size must be larger than 2");
    }
    //Placeholders
    Eigen::VectorXd Lambdas(B);
    Eigen::MatrixXd X_boot(X);
    IntegerVector boot_index(n);
    //Compute Sample Covariance
    Eigen::MatrixXd centered = X.rowwise() - X.colwise().mean();
    Eigen::MatrixXd orig_cov = (centered.adjoint() * centered) / double(n - 1);

    //Compute RWP for each bootstrap sample
    for(int i = 0; i < B; ++i) {
        //Bootstrap data
        boot_index=floor(runif(n, 0, n));
        for(int j = 0; j < n; ++j) {
            for(int k = 0; k < p; ++k) {
                X_boot(j,k) = X(boot_index[j],k);
            }
        }
        Eigen::MatrixXd boot_centered = X_boot.rowwise() - X_boot.colwise().mean();
        Eigen::MatrixXd boot_cov = (boot_centered.adjoint() * boot_centered) / double(n - 1);
        Lambdas(i) = (boot_cov - orig_cov).lpNorm<Infinity>();
    }
    return Lambdas;
}
