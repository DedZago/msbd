import numpy as np
import pandas as pd
from sklearn.base import TransformerMixin
from sklearn.utils.validation import check_is_fitted

def AbsMeanVarDeriv(X, dt = 1):
	"""
	Funzione che calcola la variazione media della derivata
	
	Parameters
	----------
	X : DataFrame di shape (n, p)
		Le colonne del DataFrame costituiscono p osservazioni equispaziate di una quantità scalare.

	dt : int
		Intervallo di spaziatura delle osservazioni.

	Returns
	-------
	DataFrame di shape (n, 1)
		Contiene la variazione media assoluta della derivata.
	"""
	deriv = X.apply(lambda x: np.gradient(x, dt), axis=1, result_type="expand")
	dderiv = deriv.apply(lambda x: np.gradient(x, dt), axis=1, result_type="expand")
	return dderiv.abs().mean(axis=1)

class Whiten(TransformerMixin):
    """Trasforma i dati rendendoli a media zero e varianza unitaria"""

    def __init(self):
        pass

    def fit(self, X, y=None):
        self.media_ = X.mean(axis=0)
        sigma = np.cov(X.T)

        # decomposizione in autovettori (EVD)
        self.d_, self.E_ = np.linalg.eig(sigma)

        return self

    def transform(self, X):
        check_is_fitted(self, ["media_", "d_", "E_"])

        X -= self.media_

        return X.dot(self.E_).dot(np.diag(1 / np.sqrt(self.d_))).dot(self.E_.T)	