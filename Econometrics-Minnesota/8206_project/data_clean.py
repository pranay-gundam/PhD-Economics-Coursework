import pandas as pd
import os
area_code_dict = {
    '0000': 'United States',
    '0100': 'Northeast',
    '0110': 'New England',
    '0120': 'Middle Atlantic',
    '0200': 'Midwest',
    '0230': 'East North Central',
    '0240': 'West North Central',
    '0300': 'South',
    '0350': 'South Atlantic',
    '0360': 'East South Central',
    '0370': 'West South Central',
    '0400': 'West',
    '0480': 'Mountain',
    '0490': 'Pacific'}

item_code_dict = {
    'SA0': 'All items',
    'SAF': 'Food',
    'SACE': 'Energy Commodities',
    'SEHF': 'Energy Services',
    'SACL1E': 'Commodities less food and energy commodities',
    'SASLE': 'Services less energy services'}

# series_id construction for cpi values: 
#      CU[seasonal code][periodicity code][area code][item code]
# Seasonal code is S (seasonally adjusted) or U (unadjusted)
# Periodicity code is S (semiannual) or R (regular monthly)

series_id_list = [f"CUSR{area}{item}" for area in area_code_dict.keys() 
                  for item in item_code_dict.keys()]

#df = pd.read_csv('data_raw/cu.data.0.Current', sep='\t')
df = pd.concat([pd.read_csv(f'data_raw/{file}', sep='\t') for file in os.listdir('data_raw')], ignore_index=True)

df.columns = df.columns.str.strip()
df = df.map(lambda x: x.strip() if isinstance(x, str) else x)
df = df[(df['period'] != 'M13') | (df['period'] != 'S01') | (df['period'] != 'S02') | (df['period'] != 'S03')]
df = df[df['series_id'].isin(series_id_list)]
df['period'] = df['period'].str.extract(r'(\d+)$').astype(int)
df['year'] = df['year'].astype(int)
df['value'] = df['value'].astype(float)
df['day'] = 1
df['month'] = df['period']
df['date'] = pd.to_datetime(df[['year', 'month', 'day']].assign(day=1))
df = df.drop(columns=['day', 'month', 'period', 'year', 'footnote_codes'])


df['area_code'] = df['series_id'].str[4:8]
df['item_code'] = df['series_id'].str[8:]
df['region'] = df['area_code'].map(area_code_dict)
df['item'] = df['item_code'].map(item_code_dict)
df = df.drop(columns=['area_code', 'item_code'])
df = df.drop_duplicates().reset_index(drop=True)
df = df.sort_values(by=['series_id', 'date']).reset_index(drop=True)
df.to_csv('data_cleaned/cu_cleaned.csv', index=False)

# Doing a pivoted data set as well
df_pivot = df.pivot(index='date', columns='series_id', values='value')
df_pivot.to_csv('data_cleaned/pricelvl_cleaned_pivot.csv', index = True)

# Calculate inflation as lagged percentage changes in price levels
df_inflation = df_pivot.pct_change() * 100
fedfunds = pd.read_csv('data_raw/FEDFUNDS.csv')
fedfunds['date'] = pd.to_datetime(fedfunds['observation_date'])
df_inflation = df_inflation.merge(fedfunds, left_on='date', right_on='date', how='left')
df_inflation.drop(columns=['observation_date'], inplace=True)
df_inflation.to_csv('data_cleaned/inflation_cleaned_pivot.csv', index=False)
# Note: Region data is not seasonally adjusted! Putting that on pause for now.

df_inflation_yoy = df_pivot.pct_change(12) * 100
df_inflation_yoy = df_inflation_yoy.merge(fedfunds, left_on='date', right_on='date', how='left')
df_inflation_yoy.drop(columns=['observation_date'], inplace=True)
df_inflation_yoy.to_csv('data_cleaned/inflation_yoy_cleaned_pivot.csv', index=False)