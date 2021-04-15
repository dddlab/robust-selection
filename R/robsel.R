robsel.rwp <- function(orig.cov, X, indices) {

    #Get bootstrap sample with replacement
    X.bootstrap <- X[indices, ]

    #Compute the bootstrap RWP function
    boot.cov <- c(cov(X.bootstrap))
    idx <- lower.tri(boot.cov, diag = T)
    return(max(abs(orig.cov - boot.cov)[idx]))
}

#' @title Robust Selection
#'
#' @description Robust Selection algorithm for estimation of the regularization parameter for Graphical Lasso
#'
#' @param X A \code{n}-by-\code{p} data matrix
#' @param alpha A prespecified confidence level. Default 0.05
#' @param B Number of bootstrap sample. Default 200
#'
#' @return \code{lambda} A estimation of the regularization parameter for Graphical Lasso
#'
#' @examples
#' set.seed(17)
#' library(robsel)
#' X <-matrix(rnorm(50*20),ncol=20)
#'
#' #Compute estimation of lambda at confidence level alpha
#' lambda <- robsel(X = X, alpha = 0.05, B = 200)
#'
#' @references P Cisneros-Velarde, A Petersen and S-Y Oh (2020). Distributionally Robust Formulation and Model Selection for the Graphical Lasso. Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics.
#'
#' @seealso \code{\link{robsel.glasso}} for using Graphical Lasso algorithm with estimate regularization parameter lambda from Robust Selection.
#' @importFrom boot boot
#' @export

robsel <- function(X, alpha = 0.05, B = 200) {
    #For each bootstrap sample, compute the bootstrap RWP function
    orig.cov <- cov(X)
    lambda <- boot(data=X, statistic=robsel.rwp, R=B, orig.cov=orig.cov)$t

    #Sort lambda from smallest to largest
    lambda <- sort(lambda)

    #Choose lambda by order statistic
    index <- as.integer(B * (1 - alpha))
    return(lambda[index])
}
