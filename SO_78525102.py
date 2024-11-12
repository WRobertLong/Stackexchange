import numpy as np
import pandas as pd
import statsmodels.api as sm
from statsmodels.regression.mixed_linear_model import MixedLM
import math
import matplotlib.pyplot as plt
from scipy.stats import t


# SO_78525102.py

def CI_t(x, ci=0.95):
    n = len(x)
    mean_x = np.mean(x)
    sd_x = np.std(x, ddof=1)
    margin_error = t.ppf(ci + (1 - ci) / 2, df=n-1) * sd_x / np.sqrt(n)
    
    data = {
        'sample_size': [n],
        'Mean': [mean_x],
        'sd': [sd_x],
        'Margin_Error': [margin_error],
        'CI lower limit': [mean_x - margin_error],
        'CI Upper limit': [mean_x + margin_error]
    }
    
    df_out = pd.DataFrame(data).melt(var_name='Measurements', value_name='values')
    return df_out


# Initialize an empty list to store the results
results = []

# Loop through the filenames
for i in range(1, 99):
    filename = f"crossed_re_{i:02d}.csv"  # Generate the filename with leading zeros
    data = pd.read_csv(filename)  # Load the CSV file

    # Fit the linear mixed-effects model with random intercepts for both subject and item
    model = MixedLM.from_formula('y ~ x', data, re_formula='1', groups=data['subject'],
                                 vc_formula={'item': '0 + C(item)'})
    result = model.fit(reml=True, method='lbfgs')

    # Extracting variance components
    subject_var = result.cov_re.iloc[0, 0]  # SD of subject random effect
    item_var = result.vcomp[0]              # SD of item random effect
    residual_var = result.scale             # SD variance

    # Append the results to the list
    results.append({
    'run': i,
    'subject_sd': math.sqrt(subject_var),
    'item_sd': math.sqrt(item_var),
    'residual_sd': math.sqrt(residual_var)
    })

# Convert the list of results to a DataFrame
results_df = pd.DataFrame(results)

# Print the DataFrame
print(results_df)

# Extract the standard deviations of random effects into separate lists
subject_sd = [result['subject_sd'] for result in results]
item_sd = [result['item_sd'] for result in results]
residual_sd = [result['residual_sd'] for result in results]

# Calculate mean values
mean_subject_sd = np.mean(subject_sd)
mean_item_sd = np.mean(item_sd)
mean_residual_sd = np.mean(residual_sd)

print("\n")
print(f'Mean Subject SD: {mean_subject_sd}')
print(f'Mean Item SD: {mean_item_sd}')
print(f'Mean Residual SD: {mean_residual_sd}')

# Calculate standard deviations
sd_subject_sd = np.std(subject_sd)
sd_item_sd = np.std(item_sd)
sd_residual_sd = np.std(residual_sd)

print("\n")
print(f'SD Subject SD: {sd_subject_sd}')
print(f'SD Item SD: {sd_item_sd}')
print(f'SD Residual SD: {sd_residual_sd}')


# Calculate confidence intervals
CI_subject = CI_t(subject_sd)
CI_item = CI_t(item_sd)
CI_residual = CI_t(residual_sd)

print("\n")
print(f'Subject_CI: {CI_subject}')
print(f'Item CI: {CI_item}')
print(f'Residual CI: {CI_residual}')

# Plot histograms
plt.figure(figsize=(15, 5))

plt.subplot(1, 3, 1)
plt.hist(subject_sd, bins=30, alpha=0.7, color='blue')
plt.title('Subject SD Histogram')
plt.xlabel('Subject SD')
plt.ylabel('Frequency')

plt.subplot(1, 3, 2)
plt.hist(item_sd, bins=30, alpha=0.7, color='green')
plt.title('Item SD Histogram')
plt.xlabel('Item SD')
plt.ylabel('Frequency')

plt.subplot(1, 3, 3)
plt.hist(residual_sd, bins=30, alpha=0.7, color='red')
plt.title('Residual SD Histogram')
plt.xlabel('Residual SD')
plt.ylabel('Frequency')

plt.tight_layout()
plt.show()