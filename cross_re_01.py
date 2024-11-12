import numpy as np
import pandas as pd
import statsmodels.api as sm
from statsmodels.formula.api import mixedlm

import numpy as np
import pandas as pd
import statsmodels.api as sm
from statsmodels.regression.mixed_linear_model import MixedLM

data = pd.read_csv("crossed_re_01.csv")

# Fit the linear mixed-effects model with random intercepts for both subject and item
model = MixedLM.from_formula('y ~ x', data, re_formula='1', groups=data['subject'],
                             vc_formula={'item': '0 + C(item)'})
result = model.fit(reml=True, method='lbfgs')

# Print the summary of the model
print(result.summary())

# Extracting variance components
subject_var = result.cov_re.iloc[0, 0]  # Variance of subject random effect
item_var = result.vcomp[0]              # Variance of item random effect
residual_var = result.scale             # Residual variance

print("\nRandom Effects Variance Components:")
print(f"Subject Variance: {subject_var}")
print(f"Item Variance: {item_var}")

print("\nResidual Variance:")
print(f"Residual Variance: {residual_var}")