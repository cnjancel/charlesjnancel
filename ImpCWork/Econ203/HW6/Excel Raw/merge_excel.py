import pandas as pd
import os

folder_path = 'D:\Personal\Personal-Projects\Coursework\Econ203\HW6\Excel Raw'
files = os.listdir(folder_path)

all_data = []
for file in files:
    if file.endswith('.xlsx'):
        file_path = os.path.join(folder_path, file)
        df = pd.read_excel(file_path)
        all_data.append(df)

combined_df = pd.concat(all_data, ignore_index=True)
combined_df.to_excel('combined_data.xlsx', index=False)
