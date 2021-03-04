#' @title Fit Graphical Lasso with RobSel
#'
#' @description Fit  Graphical Lasso with estimate regularization parameter from Robust Selection
#'
#' @param X A \code{n}-by-\code{p} data matrix
#' @param alpha A prespecified confidence level. Default 0.05
#' @param B Number of bootstrap sample. Default 200
#' @param ... Optional arguments passed on to glasso.
#'
#' @return A list with components:
#' \item{alpha}{Prespecified confidence level}
#' \item{lambda}{Estimate regularization parameter for Graphical Lasso}
#' \item{Omega}{Estimated inverse covariance matrix}
#' \item{Sigma}{Estimated covariance matrix}
#'
#' @examples
#' set.seed(17)
#' library(robsel)
#' X <-matrix(rnorm(50*20),ncol=20)
#'
#' #Use Graphical Lasso with estimate regularization parameter lambda from RobSel
#' a <- robsel.glasso(X = X, alpha = 0.05, B = 200)
#'
#' @references P Cisneros-Velarde, A Petersen and S-Y Oh (2020). Distributionally Robust Formulation and Model Selection for the Graphical Lasso. Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics.
#' @references Friedman, Jerome, Trevor Hastie, and Robert Tibshirani. 'Sparse inverse covariance estimation with the graphical lasso.' \emph{Biostatistics} 9.3 (2008): 432-441.
#' @references Meinshausen, Nicolai and Buhlmann, Peter. 2006. 'High-Dimensional Graphs and Variable Selection with the Lasso.' \emph{The Annals of Statistics}. JSTOR: 1436-1462.
#' @references Witten, Daniela M, Friedman, Jerome H, and Simon, Noah. 2011. 'New Insights and Faster computations for the Graphical Lasso.' \emph{Journal of Computation and Graphical Statistics}. Taylor and Francis: 892-900.
#'
#'
#' @seealso \link[robsel]{robsel} for Robust Selection algorithm, \link[glasso]{glasso} for Graphical Lasso algorithm.
#'
#' @importFrom glasso glasso
#' @importFrom stats cov
#' @export
#'
robsel.glasso <- function(X, alpha = 0.05, B = 200, ...) {
    # Compute estimate regularization parameter from RobSel
    lambda <- robsel(X, alpha, B)
    s <- cov(X)
    # Return the fit of glasso
    model <- glasso(s=s, rho=lambda, ...)
    returns = list(alpha = alpha, lambda = lambda,
                   Omega = model$wi, Sigma = model$w)
    return(returns)
}
