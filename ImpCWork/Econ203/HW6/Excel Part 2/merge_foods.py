import pandas as pd
import os
import re

# Set your actual folder path where the Excel files are stored
folder_path = '/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Excel Part 2'
files = [file for file in os.listdir(folder_path) if file.endswith('.xlsx')]

compiled_data = []  # List to hold the data from all files

# Define a function to get the nutrient value safely
def get_nutrient_value(df, nutrient_name):
    try:
        # Try to get the row where the first cell contains the nutrient name
        nutrient_row = df[df.iloc[:, 0].str.contains(nutrient_name, na=False, case=False)]
        # Assuming the amount is in the second column
        value = nutrient_row.iloc[0, 1] if not nutrient_row.empty else 0
        return value
    except IndexError:
        # Return zero if there is an indexing error
        return 0

# Loop through each file and extract the data
for file in files:
    file_path = os.path.join(folder_path, file)
    df = pd.read_excel(file_path)  # Read the Excel file

    # Extract the product name from cell A5
    product_name = df.iloc[3, 0]

    # Create a dictionary for this product's data
    product_data = {
        'Product Name': product_name,
        'Total Fat': 0,
        'Calories': get_nutrient_value(df, 'Calories'),
        'Total Carbohydrate': get_nutrient_value(df, 'Carbohydrate'),
        'Sugars': get_nutrient_value(df, 'Sugars'),
        'Protein': get_nutrient_value(df, 'Protein')
    }

    # Sum up the various types of fats into 'Total Fat'
    product_data['Total Fat'] += get_nutrient_value(df, '\AFat')
    product_data['Total Fat'] += get_nutrient_value(df, 'Saturated fatty acids')
    product_data['Total Fat'] += get_nutrient_value(df, 'Fatty acids, total trans')
    product_data['Total Fat'] += get_nutrient_value(df, 'Polyunsaturated fatty acids')
    product_data['Total Fat'] += get_nutrient_value(df, 'Monounsaturated fatty acids')

    # Add this product's data to the compiled list
    compiled_data.append(product_data)

# Convert the compiled data into a DataFrame
compiled_df = pd.DataFrame(compiled_data)

# Save the compiled DataFrame to an Excel file
output_file_path = os.path.join('/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Excel Part 2', 'compiled_nutritional_data_2.xlsx')
compiled_df.to_excel(output_file_path, index=False)
