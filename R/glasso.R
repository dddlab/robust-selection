#' @title Fit Graphical Lasso with RobSel
#'
#' @description Fit  Graphical Lasso with estimate regularization parameter from Robust Selection
#'
#' @param x A \code{n}-by-\code{p} data matrix
#' @param alpha Prespecified confidence level. Default 0.9
#' @param B Number of bootstrap sample. Default 200
#' @param ... Optional arguments passed on to glasso.
#'
#' @return A list with components:
#' \item{alpha}{A list of prespecified confidence level}
#' \item{lambda}{A list of estimate regularization parameter for Graphical Lasso}
#' \item{Omega}{A list of estimated inverse covariance matrix}
#' \item{Sigma}{A list of estimated covariance matrix}
#' @note Each item in each compenent corresponds to a prespecified level alpha.
#'
#' @examples
#' set.seed(17)
#' library(robsel)
#' x <-matrix(rnorm(50*20),ncol=20)
#'
#' #Use Graphical Lasso with estimate regularization parameter lambda from RobSel
#' fit <- robsel.glasso(x = x, alpha = 0.9, B = 200)
#'
#' @references P Cisneros-Velarde, A Petersen and S-Y Oh (2020). Distributionally Robust Formulation and Model Selection for the Graphical Lasso. Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics.
#' @references Friedman, Jerome, Trevor Hastie, and Robert Tibshirani. 'Sparse inverse covariance estimation with the graphical lasso.' \emph{Biostatistics} 9.3 (2008): 432-441.
#' @references Meinshausen, Nicolai and Buhlmann, Peter. 2006. 'High-Dimensional Graphs and Variable Selection with the Lasso.' \emph{The Annals of Statistics}. JSTOR: 1436-1462.
#' @references Witten, Daniela M, Friedman, Jerome H, and Simon, Noah. 2011. 'New Insights and Faster computations for the Graphical Lasso.' \emph{Journal of Computation and Graphical Statistics}. Taylor and Francis: 892-900.
#'
#'
#' @seealso \link[robsel]{robsel} for Robust Selection algorithm, \link[glasso]{glasso} for Graphical Lasso algorithm.
#' @useDynLib robsel
#' @importFrom Rcpp sourceCpp
#' @importFrom glasso glasso
#' @importFrom stats cov
#' @export
#'
robsel.glasso <- function(x, alpha = 0.9, B = 200, ...) {
    s = cov(x)
    
    # Compute estimate regularization parameter from RobSel
    lambda = robsel(x, alpha, B)
    
    # Fit of glasso
    models = sapply(lambda, glasso, s=s, ...)
    
    #Return components
    returns = list()
    returns$alpha = alpha
    returns$lambda = lambda
    returns$Sigma = models[1,]
    returns$Omega = models[2,]
    return(returns)
}
