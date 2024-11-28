import numpy as np
import pandas as pd
from scipy.stats import norm
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm

# Set seed for reproducibility
np.random.seed(15)

# Define the number of observations and the covariance matrix
N = 43
sigma = np.array([
    [1, 0.2, 0.3, 0.1, 0.4, 0.2, 0.3],
    [0.2, 1, 0.5, 0.2, 0.3, 0.1, 0.2],
    [0.3, 0.5, 1, 0.3, 0.4, 0.2, 0.1],
    [0.1, 0.2, 0.3, 1, 0.3, 0.5, 0.2],
    [0.4, 0.3, 0.4, 0.3, 1, 0.2, 0.1],
    [0.2, 0.1, 0.2, 0.5, 0.2, 1, 0.4],
    [0.3, 0.2, 0.1, 0.2, 0.1, 0.4, 1]
])

# Generate the data with 7 variables
data = np.random.multivariate_normal(mean=np.zeros(7), cov=sigma, size=N)
df = pd.DataFrame(data, columns=[f'V{i+1}' for i in range(7)])

# Define the response variable Y
df['Y'] = 10 + df['V1'] + np.random.normal(0, 1, N)

# Fit the linear model
X = sm.add_constant(df.drop(columns=['Y']))  # Add intercept
model = sm.OLS(df['Y'], X).fit()

# Retrieve adjusted R², p-values, and coefficients
adjusted_r_squared = model.rsquared_adj
p_values = model.pvalues
coefficients = model.params

# Combine coefficients and p-values into a single DataFrame for display
results_df = pd.DataFrame({
    'Coefficient': coefficients,
    'P-value': p_values
})

# Display results
print("Adjusted R²:", adjusted_r_squared)
print("\nCoefficients and P-values:\n", results_df)
