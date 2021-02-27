robsel.rwp <- function(X) {
    #Sample size
    n <- nrow(X)

    #Get bootstrap sample with replacement
    boot.index <- sample(1:n, size = n, replace = T)
    X.bootstrap <- X[boot.index, ]

    #Compute the bootstrap RWP function
    orig.cov <- c(cov(X))
    boot.cov <- c(cov(X.bootstrap))
    return(max(abs(orig.cov - boot.cov)))
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
#' library(MASS)
#' n <- 1000
#' p <- 50
#' mu <- rep(0, p)
#' Sigma <- rWishart(1,p,diag(p))
#' X <- mvrnorm(n, mu, Sigma)
#' alpha = 0.05
#'
#' #Compute estimation of lambda at confidence level alpha
#' lambda <- robsel(X = X, alpha = alpha, B = 200)
#'
#' @references P Cisneros-Velarde, A Petersen and S-Y Oh (2020). Distributionally Robust Formulation and Model Selection for the Graphical Lasso. Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics.
#'
#' @seealso \code{\link{robsel.glasso}} for using Graphical Lasso algorithm with estimate regularization parameter lambda from Robust Selection.
#'
#' @export

robsel <- function(X, alpha, B = 200) {
    lambda <-  c()

    #For each bootstrap sample, compute the bootstrap RWP function
    for (i in 1:B) {
        lambda <-  c(lambda, robsel.rwp(X))
    }

    #Sort lambda from smallest to largest
    lambda <- sort(lambda)

    #Choose lambda by order statistic
    index <- as.integer(B * (1 - alpha))
    return(lambda[index])
}
