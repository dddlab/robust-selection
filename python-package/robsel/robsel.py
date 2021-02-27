import numpy as np
from sklearn.utils import resample

def RWP(X, orig_cov, with_diag=False):
    """
    Robust Wasserstein Profile function.
    Parameters
    ----------
    X : ndarray of shape (n_samples, n_features)
        Data from which to compute the covariance estimate from bootrap sample.
    orig_cov: ndarray of shape (n_features, n_features)
        The covariance matrix of the variables from original data.
    with_diagonal : bool, default=False
        Whether or not to include diagonal when compute RWP function.

    Returns
    -------
    rwp : float
        rwp.
    """

    n = X.shape[0]
    p = X.shape[1]
    X_bootstrap = resample(X, replace=True, n_samples=n)
    A_s = np.cov(X_bootstrap,rowvar=False)
    if with_diag:
        A_s = A_s[np.tril_indices(p)]
    else:
        A_s = A_s[np.tril_indices(p,-1)]
    return np.linalg.norm(A_s - orig_cov, ord=np.inf)

def RobustSelection(X, alpha, B=200, with_diag=False):
    """
    Robust Selection algorithm for estimation of the regularization parameter.

    Parameters
    ----------
    X : ndarray of shape (n_samples, n_features)
        Data from which to compute the covariance estimate
    alpha : float or array_like
        The confidence level: the higher alpha, the lower the order statistics, 
        the smaller regularization parameter.
        Range is (0, 1).
    B : int, default=200
        Number of bootstrap samples such that (B)(1-alpha) is 
        also an integer.
    with_diagonal : bool, default=False
        Whether or not to include diagonal when compute RWP function.

    Returns
    -------
    lambda : array_type or float
        The estimated regularization parameter.

    """
    p = X.shape[1]
    A_n = np.cov(X, rowvar=False)
    if with_diag:
        A_n = A_n[np.tril_indices(p)]
    else:
        A_n = A_n[np.tril_indices(p,-1)]
    R_vec = np.zeros(B)
    for i in range(B):
        R_vec[i] = RWP(X, A_n, with_diag)
    R_vec = np.sort(R_vec)
    index = (B)*(1-alpha) - 1
    index = np.array(index)
    return R_vec[(index).astype(int)]

