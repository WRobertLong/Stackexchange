import numpy as np
from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import RBF, ConstantKernel as C
from scipy.special import expit, logit

# Example data (replace with your actual data)
N = 10  # number of sequences
m = 50  # number of points per sequence
d = 5   # dimension of phi
phis = np.random.rand(N, d)
xs = np.sort(np.random.rand(N, m), axis=1)
ys = np.random.rand(N, m)

# Apply logit transform to y
ys_transformed = logit(ys)

# Flatten data for GP fitting
X_train = np.hstack([np.repeat(phis, m, axis=0), xs.reshape(-1, 1)])
y_train = ys_transformed.flatten()

# Define the kernel: you can customize this kernel based on your problem
kernel = C(1.0, (1e-3, 1e3)) * RBF(1.0, (1e-2, 1e2))

# Create GaussianProcessRegressor model
gp = GaussianProcessRegressor(kernel=kernel, n_restarts_optimizer=10)

# Fit to the transformed data
gp.fit(X_train, y_train)

# To predict, we first prepare the test data
# Example: let's use one of the phis and xs from the training set
phi_test = phis[0].reshape(1, -1)
x_test = np.linspace(0, 1, 100).reshape(-1, 1)
X_test = np.hstack([np.repeat(phi_test, x_test.shape[0], axis=0), x_test])

# Predict the transformed values
y_pred_transformed, sigma = gp.predict(X_test, return_std=True)

# Invert the transformation to get predictions on the original scale
y_pred = expit(y_pred_transformed)

# y_pred now contains the predictions in the [0, 1] range