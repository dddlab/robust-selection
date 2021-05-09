#' @title Robust Selection
#'
#' @description Robust Selection algorithm for estimation of the regularization parameter for Graphical Lasso
#'
#' @param X A \code{n}-by-\code{p} data matrix
#' @param alpha A prespecified confidence level. Default 0.9
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
#' lambda <- robsel(X = X, alpha = 0.9, B = 200)
#'
#' @references P Cisneros-Velarde, A Petersen and S-Y Oh (2020). Distributionally Robust Formulation and Model Selection for the Graphical Lasso. Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics.
#'
#' @seealso \code{\link{robsel.glasso}} for using Graphical Lasso algorithm with estimate regularization parameter lambda from Robust Selection.
#' @useDynLib robsel
#' @importFrom Rcpp sourceCpp
#' @export

robsel <- function(X, alpha = 0.9, B = 200) {
    if (alpha<0 || alpha >1) {
        stop('alpha must be between 0 and 1')
    }
    if (B < 100) {
        warning("Please choose a large B (B >= 100 is recommened)")
    }
    #For each bootstrap sample, compute the bootstrap RWP function
    lambda <- rwp_rcpp(X, B)

    #Sort lambda from smallest to largest
    lambda <- sort(lambda)

    #Choose lambda by order statistic
    index <- as.integer(B * (1 - alpha))
    if (index == 0) {
        return(lambda[1])
    } else {
        return(lambda[index])
    }
}
