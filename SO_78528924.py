import pandas as pd
import matplotlib.pyplot as plt

# Load the generated toy data
file_path = 'crossed_re_01.csv'
monthly_data = pd.read_csv(file_path)

# Check the column names
print(monthly_data.columns)

# Ensure column names are correct
if 'datetime' not in monthly_data.columns:
    raise KeyError("The 'datetime' column is not found in the dataset.")
if 'month' not in monthly_data.columns:
    raise KeyError("The 'month' column is not found in the dataset.")
if 'Transaction_Amount' not in monthly_data.columns:
    raise KeyError("The 'Transaction_Amount' column is not found in the dataset.")

# Convert 'datetime' column to datetime type if not already
monthly_data['datetime'] = pd.to_datetime(monthly_data['datetime'])

# Extract the list of months from the data
months = monthly_data['month'].unique()

# Plot the data for each month in separate figures
for month in months:
    month_data = monthly_data[monthly_data['month'] == month]
    plt.figure(figsize=(10, 5))
    plt.plot(month_data['datetime'], month_data['Transaction_Amount'], marker='o', linestyle='-')
    plt.title(f'Transaction Amount - Month {month}')
    plt.xlabel('Timestamp')
    plt.ylabel('Transaction Amount')
    plt.grid(True)
    plt.show()
