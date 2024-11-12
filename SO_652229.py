import numpy as np
import pandas as pd
import statsmodels.formula.api as smf

# Parameters
beta_0 = 0  # Intercept
beta_1 = 0  # Main effect of C
beta_2 = 0.27  # Main effect of X
beta_3_list = [0.1, 0.2, 0.3]  # Interaction effects to test
sigma_b = 1  # Std dev of random intercept
sigma_e = 1  # Std dev of residual error
n_subjects_list = [10, 15, 20]  # Reduced number of subjects to test for quicker execution
n_obs_per_subject = 5  # Observations per subject

def simulate_data(beta_3, n_subjects, n_obs_per_subject):
    # Random effects for subjects
    b_subject = np.random.normal(0, sigma_b, n_subjects)

    # Simulate data
    data = []
    for j in range(n_subjects):
        C = np.random.choice([-1, 1], n_obs_per_subject)  # Sum contrast coding
        X = np.random.normal(size=n_obs_per_subject)
        Y = (beta_0 + beta_1 * C + beta_2 * X +
             beta_3 * C * X + b_subject[j] +
             np.random.normal(0, sigma_e, n_obs_per_subject))
        subject_id = np.repeat(j, n_obs_per_subject)
        data.append(pd.DataFrame({'Y': Y, 'C': C, 'X': X, 'Subject': subject_id}))

    return pd.concat(data)

def run_simulation(beta_3, n_subjects, n_obs_per_subject, n_simulations=20, alpha=0.05):
    significant_count = 0
    
    for foo in range(n_simulations):
        print(foo)
        # Simulate dataset
        data = simulate_data(beta_3, n_subjects, n_obs_per_subject)
        
        # Fit mixed model
        model = smf.mixedlm("Y ~ C * X", data, groups=data["Subject"])
        result = model.fit()

        # Check if the interaction is significant using t-test
        p_value = result.pvalues['C:X']
        if p_value < alpha:
            significant_count += 1
    
    power = significant_count / n_simulations
    return power

# Run simulations for different scenarios
results = []
for beta_3 in beta_3_list:
    for n_subjects in n_subjects_list:
        power = run_simulation(beta_3, n_subjects, n_obs_per_subject)
        results.append((beta_3, n_subjects, power))

# Display results
results_df = pd.DataFrame(results, columns=['Interaction Effect', 'Number of Subjects', 'Power'])

# Use standard print function to display the DataFrame
print("Power Analysis Results:\n", results_df)