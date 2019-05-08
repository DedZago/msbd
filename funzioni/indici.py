import numpy as np


def indice_gini(p):
    """Indice di Gini

    Parameters
    ----------
    p : array, shape (n,)
        Array delle probabilità.

    Returns
    -------
    i : array, shape (n,)
        Indici di Gini degli elementi di p.
    """
    # ============== YOUR CODE HERE ==============
    i = 2*p*(1-p)
    # ============================================
    return i


def tasso_errata_classificazione(p):
    """Tasso di errata classificazione

    Parameters
    ----------
    p : array, shape (n,)
        Array delle probabilità.

    Returns
    -------
    i : array, shape (n,)
        Tasso di errata classificazione degli elementi di p.
    """
    # ============== YOUR CODE HERE ==============
    i = 1 - np.max([p,1-p], axis=0)
    # ============================================
    return i
