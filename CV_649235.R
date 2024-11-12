
import numpy as np
from scipy.spatial.distance import jensenshannon
import matplotlib.pyplot as plt

# Function to generate synthetic data
def generate_data(num_samples, num_features):
    X = np.random.rand(num_samples, num_features)
    y = (X.sum(axis=1) > (num_features / 2)).astype(int)
    return X, y

# Simulate model predictions as random probability distributions
def simulate_model_predictions(num_samples, num_classes, num_runs):
    predictions = []
    for _ in range(num_runs):
        preds = np.random.dirichlet(np.ones(num_classes), size=num_samples)
        predictions.append(preds)
    return predictions

# Calculate JS-divergence between two probability distributions
def js_divergence(p, q):
    return jensenshannon(p, q) ** 2

# Generate synthetic data
num_samples = 1000
num_features = 10
num_classes = 2  # Binary classification
num_runs = 30

X, y = generate_data(num_samples, num_features)

# Simulate predictions from two different models
predictions_f = simulate_model_predictions(num_samples, num_classes, num_runs)
predictions_g = simulate_model_predictions(num_samples, num_classes, num_runs)

# Calculate JS-divergence distributions
D_f = []
D_g = []
D = []

for i in range(num_samples):
    for j in range(num_runs):
        for k in range(j + 1, num_runs):
            D_f.append(js_divergence(predictions_f[j][i], predictions_f[k][i]))
            D_g.append(js_divergence(predictions_g[j][i], predictions_g[k][i]))
            D.append(js_divergence(predictions_f[j][i], predictions_g[k][i]))

# Plot the distributions
plt.hist(D_f, bins=50, alpha=0.5, label='Df')
plt.hist(D_g, bins=50, alpha=0.5, label='Dg')
plt.hist(D, bins=50, alpha=0.5, label='D')
plt.xlabel('JS-divergence')
plt.ylabel('Frequency')
plt.legend()
plt.title('JS-divergence Distributions')
plt.show()