import numpy as np
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt

# Simulate some data
np.random.seed(42)
n = 100
time = np.linspace(0, 10, n)
group = np.random.choice([0, 1], size=n)

# Parameters for the simulation
beta_0 = 1
beta_1_group1 = 0.3
beta_1_group2 = 0.5
initial_value = 10
noise = np.random.normal(0, 0.5, size=n)

# Simulated response variable
y_group1 = initial_value * np.exp(beta_1_group1 * time) + noise
y_group2 = initial_value * np.exp(beta_1_group2 * time) + noise
y = np.where(group == 0, y_group1, y_group2)

# Create DataFrame
df = pd.DataFrame({
    'time': time,
    'group': group,
    'y': y,
    'log_y': np.log(y),
    'log_y_y0': np.log(y / initial_value)
})

# Adding interaction term
df['time_group'] = df['time'] * df['group']

# Fit the first model: log(y) = beta_0 + beta_1 * time + beta_2 * group + beta_3 * (group * time)
X1 = sm.add_constant(df[['time', 'group', 'time_group']])
model1 = sm.OLS(df['log_y'], X1).fit()

# Fit the second model: log(y / y0) = beta_1 * time + beta_2 * (group * time)
X2 = sm.add_constant(df[['time', 'time_group']])
model2 = sm.OLS(df['log_y_y0'], X2).fit()

# Summarize the results
summary_model1 = model1.summary()
summary_model2 = model2.summary()

print(summary_model1)
print(summary_model2)

