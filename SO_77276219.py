import pandas as pd
import statsmodels.formula.api as smf

# Load the simulated data
simulated_data = pd.read_csv("simulated_data.csv")
simulated_data['group'] = 1  # This creates a dummy grouping variable

# Define the model formula
formula = "Val ~ 1"

# Define the variance components formula
vcf = {
    "R1": "0 + C(R1)",
    "R2": "0 + C(R2)",
    "R1:R2": "0 + C(R1):C(R2)"
}

# Fit the mixed linear model
model = smf.mixedlm(formula, data=simulated_data, groups=simulated_data["group"], vc_formula=vcf, re_formula="~1")
result = model.fit()

# Print the summary of the model
print(result.summary())