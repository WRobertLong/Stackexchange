import pandas as pd
import statsmodels.api as sm
from statsmodels.regression.mixed_linear_model import MixedLM

# Load the dataset
data = pd.read_csv("singular_data.csv")

# Define the dependent variable (y) and the fixed effect (x)
y = data['y']
X = sm.add_constant(data['x'])  # Adding a constant for the intercept

# Define the random effects grouping variable
groups = data['group']

# Fit the linear mixed-effects model
model = MixedLM(y, X, groups=groups)
result = model.fit()

# Print the model summary
print(result.summary())