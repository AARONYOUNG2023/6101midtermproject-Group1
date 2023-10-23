#%%
import seaborn as sns
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df1 = pd.read_csv('rideshare_kaggle.csv')
df1.head(5)

# %%
df1.columns

# %%
df1.isna().sum()

# %%
df1 = df1.dropna()

# %%
df1

# %%
corr_all = df1.corr()
fig, ax = plt.subplots(figsize=(20,20))
# Create the heatmap
sns.heatmap(corr_all, cmap="PuBuGn", annot=True, fmt=".1f", linewidths=.5, ax=ax)
# Set the title and axis labels
ax.set_title("corr heatmap")
# Show the plot
plt.show()

# %%
sam_df = df1.sample(n=6000, random_state=42)
sam_df = sam_df.reset_index(drop=True)
sam_df

# %%
fin_df = sam_df[['hour', 'price','distance','surge_multiplier','cab_type','name']]
fin_df

# %%
fin_df.to_csv('final_dataset.csv',index=False)
# %%
