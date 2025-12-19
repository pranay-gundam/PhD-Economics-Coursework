import pandas as pd
from statsmodels.tsa.api import VAR

# Assuming you have a DataFrame named 'data' with your time series variables
# For example:
data = pd.read_csv("data_cleaned/inflation_cleaned_pivot.csv")

# Create a VAR model instance
model = VAR(data)

# Estimate the model with a chosen lag order (e.g., 2)
results = model.fit(2)

# Print a summary of the results
print(results.summary())

# Make forecasts
forecasts = results.forecast(data.values, steps=5)

# Perform impulse response analysis
irf = results.irf(10)
irf.plot()