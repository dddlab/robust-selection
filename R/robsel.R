#' @title Robust Selection
#'
#' @description Robust Selection algorithm for estimation of the regularization parameter for Graphical Lasso
#'
#' @param x A \code{n}-by-\code{p} data matrix
#' @param alpha Prespecified confidence level. Default 0.9
#' @param B Number of bootstrap sample. Default 200
#'
#' @return \code{lambda} Estimation of the regularization parameter for Graphical Lasso. A vector of lambda will be return if more than 1 value of alpha is provided.
#'
#' @examples
#' set.seed(17)
#' library(robsel)
#' x <-matrix(rnorm(50*20),ncol=20)
#'
#' #Compute estimation of lambda at confidence level alpha
#' lambda <- robsel(x = x, alpha = 0.9, B = 200)
#'
#' @references P Cisneros-Velarde, A Petersen and S-Y Oh (2020). Distributionally Robust Formulation and Model Selection for the Graphical Lasso. Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics.
#'
#' @seealso \code{\link{robsel.glasso}} for using Graphical Lasso algorithm with estimate regularization parameter lambda from Robust Selection.
#' @useDynLib robsel
#' @importFrom Rcpp sourceCpp
#' @export

robsel <- function(x, alpha = 0.9, B = 200) {
    if (sum(alpha<0)!=0 || sum(alpha>1)!=0) {
        stop('alpha must be between 0 and 1')
    }
    if (B <= 0) {
        stop("B must be a positive integer")
    } else if (B < 100) {
        warning("Please choose a large B (B >= 100 is recommened)")
    }
    B = as.integer(B)
    alpha = as.numeric(alpha)
    #For each bootstrap sample, compute the bootstrap RWP function
    lambda = rwp_rcpp(x, B)

    #Sort lambda from smallest to largest
    lambda = sort(lambda)

    #Choose lambda by order statistic
    index = as.integer(B * (1 - alpha))
    index[index==0] = 1
    return(lambda[index])
}
