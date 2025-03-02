from sqlalchemy import create_engine
import pandas as pd

# Database connection details
username = '####'
password = '####'
host = '####'
port = '5432'
database = 'Inventory'

# Create a connection string
connection_string = f'postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}'

try:
    # Create a database engine
    engine = create_engine(connection_string)
    print("Engine created successfully.")

    # Create a connection object
    conn = engine.raw_connection()
    
    # Define your SQL query
    query = "SELECT * FROM inventory"  # Replace 'inventory' with your actual table name

    # Use a cursor to execute the query
    with conn.cursor() as cursor:
        cursor.execute(query)
        data = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]

        # Load data into a DataFrame
        df = pd.DataFrame(data, columns=columns)
        
        # Display the DataFrame
        print(df.head())  # Print the first few rows of the DataFrame

except Exception as e:
    print(f"Error loading data into DataFrame: {e}")

finally:
    # Ensure the connection is closed
    if 'conn' in locals():
        conn.close()
    if 'engine' in locals():
        engine.dispose()
        
###########################################################################

# Exploratory Data Analysis On Python
# Display basic information
print("Dataset Info:")
print(df.info())

# Display the first few rows of the dataframe
print(df.head())

df.describe

# Check for missing values
missing_values_count = df.isnull().sum()

# Get the data types of each column and store them in a variable
data_types = df.dtypes

# Convert 'Posting Date','Entry Date','Document Date' to datetime format
df['posting_date'] = pd.to_datetime(df['posting_date'], format='%d/%m/%Y')
df['document_date'] = pd.to_datetime(df['document_date'], format='%d/%m/%Y')
df['entry_date'] = pd.to_datetime(df['entry_date'], format='%d/%m/%Y')

# Ensure 'time_of_entry' column is a string type
df['time_of_entry'] = df['time_of_entry'].astype(str)

# Convert from 24-hour to datetime and then format to 12-hour format
df['time_of_entry'] = pd.to_datetime(df['time_of_entry'], format='%H:%M:%S').dt.strftime('%I:%M:%S %p')

# Print the updated DataFrame
print("\nUpdated DataFrame with 12-Hour Format Time:")
print(df)

# Convert the 'qty_in_un._of_entry' column to numeric, replacing non-numeric values with NaN
df['qty_in_un_of_entry'] = pd.to_numeric(df['qty_in_un_of_entry'], errors='coerce')

# Optionally, print the dtype and unique values to verify
print(df['qty_in_un_of_entry'].dtype)
print(df['qty_in_un_of_entry'].unique())


# Fill NaN values with 0 (if needed, but there are no NaNs)
df['qty_in_un_of_entry'] = df['qty_in_un_of_entry'].fillna(0)

# Convert to integer
df['qty_in_un_of_entry'] = df['qty_in_un_of_entry'].astype(int)

# Remove commas and convert to numeric (float)
df['amount_in_lc'] = df['amount_in_lc'].replace('[\$,]', '', regex=True).astype(float)
df['qty_in_order_unit'] = df['qty_in_order_unit'].replace('[\$,]', '', regex=True).astype(float)
df['quantity'] = df['quantity'].replace('[\$,]', '', regex=True).astype(float)
df['qty_in_opun'] = df['qty_in_opun'].replace('[\$,]', '', regex=True).astype(float)

# Convert to numeric, ensuring it handles the conversion to integer
df['purchase_order'] = pd.to_numeric(df['purchase_order'], errors='coerce').astype('Int64')

df['cost_center'] = pd.to_numeric(df['cost_center'], errors='coerce').astype('Int64')

df['supplier'] = pd.to_numeric(df['supplier'], errors='coerce').astype('Int64')

df['product_code'] = pd.to_numeric(df['product_code'], errors='coerce').astype('Int64')

df['vendor_code'] = pd.to_numeric(df['vendor_code'], errors='coerce').astype('Int64')


# Convert to integer type
df['order'] = df['order'].astype('Int64')

# Get the data types of each column and store them in a variable
data_types = df.dtypes

# Drop the 'Batch' and 'Product Code' columns
df.drop(columns=['batch', 'product_code'], inplace=True)

# Verify the columns have been removed
print("\nColumns after dropping 'Batch' and 'Product Code':")
print(df.columns)


# NUMERIC COLUMNS
numeric_columns_data = df.select_dtypes(include=['number'])

# Store the names of numeric columns in a list
numeric_column_names = numeric_columns_data.columns.tolist()

# Display the numeric column names
print("Numeric Columns:")
print(numeric_column_names)

# Descriptive statistics
numeric_stats = numeric_columns_data.describe()

print("\nDescriptive Statistics for Numeric Columns:")
print(numeric_stats)

# Calculate the median for each numeric column
medians = numeric_columns_data.median()

# Check for missing values in numeric columns
missing_values_count_numeric = numeric_columns_data.isnull().sum()

numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns

######### SKEWNESS
# Compute skewness for each numeric column
skewness_values = df[numeric_columns].skew()
# Print skewness values
print("Skewness of Numeric Columns:")
print(skewness_values)


######### KURTOSIS ################



import numpy as np
# Filter to only numeric columns
numeric_columns = df.select_dtypes(include=[np.number])

# Calculate kurtosis for numeric columns
kurtosis_values = numeric_columns.kurtosis()



##from scipy.stats import kurtosis
# Calculate kurtosis for each numeric column
#kurtosis_values = {}
#for column in numeric_columns:
    # Ensure the column exists in the DataFrame and is numeric
 #   if column in df.columns and pd.api.types.is_numeric_dtype(df[column]):
 #       kurt_value = kurtosis(df[column].dropna(), fisher=True)  # Fisher=True means excess kurtosis
  #      kurtosis_values[column] = kurt_value
  #  else:
   #     kurtosis_values[column] = None
        
# Display the kurtosis values
#print("\nKurtosis Values:")
#for column, kurt_value in kurtosis_values.items():
 #   print(f"{column}: {kurt_value}")
#######################################################################################################################
##################################  Graphical Representation  #################################
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as stats

# Identify numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns

# Outlier Detection - Box Plots
plt.figure(figsize=(15, 20))
# Adjust spacing between plots
plt.subplots_adjust(hspace=0.9, wspace=0.3)  # hspace and wspace control vertical and horizontal spacing
for i, column in enumerate(numeric_columns, 1):
    plt.subplot(5, 3, i)  # Adjust the subplot grid if necessary, e.g., (5, 3)
    sns.boxplot(data=df, x=column)
    plt.title(f'Box Plot of {column}')
plt.show()


# FOR MATERIAL ID
# Box plot for 'Material ID'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='material_id', color='skyblue', orient='v')
plt.title('Box Plot of Material ID', fontsize=16)
plt.ylabel('Material ID', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Material ID'
plt.subplot(1, 2, 2)
sns.histplot(df['material_id'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Material ID', fontsize=16)
plt.xlabel('Material ID', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()



# FOR PLANT CODE
# Create a vertical box plot and histogram for 'Plant Code'
plt.figure(figsize=(14, 6))
# Box plot for 'Plant Code'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='plant_code', color='skyblue', orient='v')
plt.title('Box Plot of Plant Code', fontsize=16)
plt.ylabel('Plant Code', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Plant Code'
plt.subplot(1, 2, 2)
sns.histplot(df['plant_code'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Plant Code', fontsize=16)
plt.xlabel('Plant Code', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# FOR MOVEMENT TYPE
# Create a figure for 'Movement Type'
plt.figure(figsize=(14, 6))
# Box plot for 'Movement Type'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='movement_type', color='skyblue', orient='v')
plt.title('Box Plot of Movement Type', fontsize=16)
plt.ylabel('Movement Type', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Movement Type'
plt.subplot(1, 2, 2)
sns.histplot(df['movement_type'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Movement Type', fontsize=16)
plt.xlabel('Movement Type', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# FOR MATERIAL DOCUMENT
# Create a figure for 'Material Document'
plt.figure(figsize=(14, 6))
# Box plot for 'Material Document'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='material_document', color='skyblue', orient='v')
plt.title('Box Plot of Material Document', fontsize=16)
plt.ylabel('Material Document', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Material Document'
plt.subplot(1, 2, 2)
sns.histplot(df['material_document'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Material Document', fontsize=16)
plt.xlabel('Material Document', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# FOR QTY IN UN OF ENTRY
# Box plot for 'Qty in Un. of Entry'
plt.subplot(2, 2, 1)
sns.boxplot(data=df, y='qty_in_un_of_entry', color='skyblue', orient='v')
plt.title('Box Plot of Qty in Un. of Entry', fontsize=16)
plt.ylabel('Qty in Un. of Entry', fontsize=14)
plt.xlabel('Value', fontsize=14)


# Histogram for 'Qty in Un. of Entry'
plt.subplot(2, 2, 2)
sns.histplot(df['qty_in_un_of_entry'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Qty in Un. of Entry', fontsize=16)
plt.xlabel('Qty in Un. of Entry', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.show()


# FOR ORDER
# Box plot for 'Order'
plt.subplot(2, 2, 3)
sns.boxplot(data=df, y='order', color='skyblue', orient='v')
plt.title('Box Plot of Order', fontsize=16)
plt.ylabel('Order', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Order'
plt.subplot(2, 2, 4)
sns.histplot(df['order'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Order', fontsize=16)
plt.xlabel('Order', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR QTY IN OPUN
# Create a figure for 'Qty in OPUn'
plt.figure(figsize=(14, 6))
# Box plot for 'Qty in OPUn'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='qty_in_opun', color='skyblue', orient='v')
plt.title('Box Plot of Qty in OPUn', fontsize=16)
plt.ylabel('Qty in OPUn', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Qty in OPUn'
plt.subplot(1, 2, 2)
sns.histplot(df['qty_in_opun'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Qty in OPUn', fontsize=16)
plt.xlabel('Qty in OPUn', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR QTY IN ORDER UNIT
# Create a figure for 'Qty in order unit'
plt.figure(figsize=(14, 6))
# Box plot for 'Qty in order unit'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='qty_in_order_unit', color='skyblue', orient='v')
plt.title('Box Plot of Qty in order unit', fontsize=16)
plt.ylabel('Qty in order unit', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Qty in order unit'
plt.subplot(1, 2, 2)
sns.histplot(df['qty_in_order_unit'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Qty in order unit', fontsize=16)
plt.xlabel('Qty in order unit', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR COMPANY CODE
# Create a figure for 'Company Code'
plt.figure(figsize=(14, 6))
# Box plot for 'Company Code'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='company_code', color='skyblue', orient='v')
plt.title('Box Plot of Company Code', fontsize=16)
plt.ylabel('Company Code', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Company Code'
plt.subplot(1, 2, 2)
sns.histplot(df['company_code'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Company Code', fontsize=16)
plt.xlabel('Company Code', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR AMOUNT IN LC
# Create a figure for 'Amount in LC'
plt.figure(figsize=(14, 6))
# Box plot for 'Amount in LC'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='amount_in_lc', color='skyblue', orient='v')
plt.title('Box Plot of Amount in LC', fontsize=16)
plt.ylabel('Amount in LC', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Amount in LC'
plt.subplot(1, 2, 2)
sns.histplot(df['amount_in_lc'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Amount in LC', fontsize=16)
plt.xlabel('Amount in LC', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR PURCHASE ORDER
# Create a figure for 'Purchase Order'
plt.figure(figsize=(14, 6))
# Box plot for 'Purchase Order'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='purchase_order', color='skyblue', orient='v')
plt.title('Box Plot of Purchase Order', fontsize=16)
plt.ylabel('Purchase Order', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Purchase Order'
plt.subplot(1, 2, 2)
sns.histplot(df['purchase_order'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Purchase Order', fontsize=16)
plt.xlabel('Purchase Order', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR ITEM
# Create a figure for 'Item'
plt.figure(figsize=(14, 6))
# Box plot for 'Item'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='item', color='skyblue', orient='v')
plt.title('Box Plot of Item', fontsize=16)
plt.ylabel('Item', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Item'
plt.subplot(1, 2, 2)
sns.histplot(df['item'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Item', fontsize=16)
plt.xlabel('Item', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR REASON FOR MOVEMENT
# Create a figure for 'Reason for Movement'
plt.figure(figsize=(14, 6))
# Box plot for 'Reason for Movement'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='reason_for_movement', color='skyblue', orient='v')
plt.title('Box Plot of Reason for Movement', fontsize=16)
plt.ylabel('Reason for Movement', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Reason for Movement'
plt.subplot(1, 2, 2)
sns.histplot(df['reason_for_movement'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Reason for Movement', fontsize=16)
plt.xlabel('Reason for Movement', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR COST CENTER
# Create a figure for 'Cost Center'
plt.figure(figsize=(14, 6))
# Box plot for 'Cost Center'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='cost_center', color='skyblue', orient='v')
plt.title('Box Plot of Cost Center', fontsize=16)
plt.ylabel('Cost Center', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Cost Center'
plt.subplot(1, 2, 2)
sns.histplot(df['cost_center'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Cost Center', fontsize=16)
plt.xlabel('Cost Center', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR SUPPLIER
# Create a figure for 'Supplier'
plt.figure(figsize=(14, 6))
# Box plot for 'Supplier'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='supplier', color='skyblue', orient='v')
plt.title('Box Plot of Supplier', fontsize=16)
plt.ylabel('Supplier', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Supplier'
plt.subplot(1, 2, 2)
sns.histplot(df['supplier'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Supplier', fontsize=16)
plt.xlabel('Supplier', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR QUANTITY
# Create a figure for 'Quantity'
plt.figure(figsize=(14, 6))
# Box plot for 'Quantity'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='quantity', color='skyblue', orient='v')
plt.title('Box Plot of Quantity', fontsize=16)
plt.ylabel('Quantity', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Quantity'
plt.subplot(1, 2, 2)
sns.histplot(df['quantity'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Quantity', fontsize=16)
plt.xlabel('Quantity', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR MATERIAL DOC YEAR
# Create a figure for 'Material Doc. Year'
plt.figure(figsize=(14, 6))
# Box plot for 'Material Doc. Year'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='material_doc_year', color='skyblue', orient='v')
plt.title('Box Plot of Material Doc. Year', fontsize=16)
plt.ylabel('Material Doc. Year', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Material Doc. Year'
plt.subplot(1, 2, 2)
sns.histplot(df['material_doc_year'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Material Doc. Year', fontsize=16)
plt.xlabel('Material Doc. Year', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()



# ITEM NO STOCK TRANSFER RESERV
# Create a figure for 'Item No. Stock Transfer Reserv.'
plt.figure(figsize=(14, 6))
# Box plot for 'Item No. Stock Transfer Reserv.'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='item_no_stock_transfer_reserv', color='skyblue', orient='v')
plt.title('Box Plot of Item No. Stock Transfer Reserv.', fontsize=16)
plt.ylabel('Item No.Stock Transfer Reserv.', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Item No. Stock Transfer Reserv.'
plt.subplot(1, 2, 2)
sns.histplot(df['item_no_stock_transfer_reserv'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Item No. Stock Transfer Reserv.', fontsize=16)
plt.xlabel('Item No.Stock Transfer Reserv.', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# VENDOR CODE
# Create a figure for 'Vendor Code'
plt.figure(figsize=(14, 6))
# Box plot for 'Vendor Code'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='vendor_code', color='skyblue', orient='v')
plt.title('Box Plot of Vendor Code', fontsize=16)
plt.ylabel('Vendor Code', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Vendor Code'
plt.subplot(1, 2, 2)
sns.histplot(df['vendor_code'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Vendor Code', fontsize=16)
plt.xlabel('Vendor Code', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# Data Distribution - Histograms
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns
df[numeric_columns].hist(bins=15, figsize=(15, 10))
plt.suptitle('Histograms of Numeric Columns', fontsize=16)
plt.tight_layout(h_pad=4.0, rect=[0, 0.03, 1, 0.95])  # Adjust h_pad for vertical spacing
plt.show()


# Identify numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns

# Plot histograms for all numeric columns
for column in numeric_columns:
    plt.figure(figsize=(10, 6))
    sns.histplot(df[column].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
    plt.title(f'Distribution of {column}')
    plt.xlabel(column)
    plt.ylabel('Frequency')
    plt.show()


# Compute correlation matrix
corr = df[numeric_columns].corr()
# Heatmap to visualize correlations
plt.figure(figsize=(16, 12))
sns.heatmap(corr, annot=True, cmap='coolwarm', fmt=".2f")
plt.title('Correlation Matrix')
plt.show()
# Sort columns in ascending order

    
# Plot QQ plots for each numeric column one by one
for col in numeric_columns:
    plt.figure(figsize=(6, 6))
    stats.probplot(df[col].dropna(), dist="norm", plot=plt)
    plt.title(f'QQ Plot of {col}')
    plt.show()


# Visualize skewness using a bar plot
plt.figure(figsize=(12, 6))
sns.barplot(x=skewness_values.index, y=skewness_values.values, palette="viridis")
plt.axhline(0, color='gray', linestyle='--')
plt.title('Skewness of Numeric Columns')
plt.xlabel('Columns')
plt.ylabel('Skewness')
plt.xticks(rotation=45, ha='right')  # Rotate x-axis labels for better readability

# Add labels to each bar
for i, value in enumerate(skewness_values):
    plt.text(i, value + (0.1 if value >= 0 else -0.1), f'{value:.2f}', 
             ha='center', va='bottom' if value >= 0 else 'top', fontsize=13, color='black')

plt.tight_layout()
plt.show()



import numpy as np
# Filter to only numeric columns
numeric_columns = df.select_dtypes(include=[np.number])

# Calculate kurtosis for numeric columns
kurtosis_values = numeric_columns.kurtosis()

# Visualize kurtosis using a bar plot
plt.figure(figsize=(10, 6))
sns.barplot(x=kurtosis_values.index, y=kurtosis_values.values, palette="viridis")
plt.axhline(0, color='gray', linestyle='--')
plt.title('Kurtosis of Numeric Columns')
plt.xlabel('Columns')
plt.ylabel('Kurtosis')
plt.xticks(rotation=45, ha='right')  # Rotate x-axis labels for better readability

# Add labels to each bar
for i, value in enumerate(kurtosis_values):
    plt.text(i, value + (0.1 if value >= 0 else -0.1), f'{value:.2f}', 
             ha='center', va='bottom' if value >= 0 else 'top', fontsize=13, color='black')

plt.tight_layout()
plt.show()
###############################################################################################
##############################    Pre-Processing Steps    ###################################

# Identify numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns

# Get the data types of each column and store them in a variable
data_types = df.dtypes

##########  Numeric Columns With Null Values  ############
# Check for missing values in numeric columns
null_values_numeric = df[numeric_columns].isnull().sum()

# Filter out columns where null values are present
numeric_columns_with_nulls = null_values_numeric[null_values_numeric > 0].index.tolist()


#############    OUTLIERS COUNT    ################
# Initialize an empty list to store outlier counts
outlier_counts = []
# Loop through each numeric column
for column in numeric_columns:
    if column in df.columns:
        # Calculate Q1 (25th percentile) and Q3 (75th percentile)
        Q1 = df[column].quantile(0.25)
        Q3 = df[column].quantile(0.75)
        IQR = Q3 - Q1
        
        # Define outlier thresholds
        lower_bound = Q1 - 1.5 * IQR
        upper_bound = Q3 + 1.5 * IQR
        
        # Count the number of outliers
        num_outliers = ((df[column] < lower_bound) | (df[column] > upper_bound)).sum()
        
        # Append the result to the list
        outlier_counts.append({
            'Column': column,
            'Outlier Count': num_outliers
        })

# Create a DataFrame from the outlier counts
outlier_df = pd.DataFrame(outlier_counts)


############### CHECKING AND CORRECTING VALUES IN PURCHASE ORDER AND COST CENTER
import pandas as pd

# Get the data types of each column and store them in a variable
data_types = df.dtypes

# Select numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns


# Check for any non-integer values
def check_non_integer_values(series):
    # Convert the column to a numeric type, and find any float values
    series_numeric = pd.to_numeric(series, errors='coerce')
    non_integers = series_numeric[series_numeric != series_numeric.round()].dropna()
    return non_integers

# Identify non-integer values in purchase_order and cost_center
non_integer_purchase_order = check_non_integer_values(df['purchase_order'])
non_integer_cost_center = check_non_integer_values(df['cost_center'])

print("Non-integer values in 'purchase_order':")
print(non_integer_purchase_order)

print("Non-integer values in 'cost_center':")
print(non_integer_cost_center)


########### FOR PURCAHSE ORDER AND COST CENTER CORRECTION ###############
# If there are non-integers, attempt to correct them
def correct_to_integer(series):
    # Convert the column to integer, coercing errors to NaN
    series_corrected = pd.to_numeric(series, errors='coerce').fillna(0).astype(int)
    return series_corrected

# Correct columns to integers
df['purchase_order'] = correct_to_integer(df['purchase_order'])
df['cost_center'] = correct_to_integer(df['cost_center'])

# Confirm the changes
print("Corrected 'purchase_order' column:")
print(df['purchase_order'].head())

print("Corrected 'cost_center' column:")
print(df['cost_center'].head())


##########################################################################
#FOR Purchase Order And Cost Center Outliers Correction
# Function to cap outliers based on IQR
def cap_outliers(series):
    Q1 = series.quantile(0.25)
    Q3 = series.quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    # Cap the outliers
    series = series.clip(lower_bound, upper_bound)
    return series

# Apply capping to the specified columns
df['purchase_order'] = cap_outliers(df['purchase_order'])
df['cost_center'] = cap_outliers(df['cost_center'])

# Verify the results by checking the outlier counts again
def count_outliers(series):
    Q1 = series.quantile(0.25)
    Q3 = series.quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    # Count outliers
    outliers = series[(series < lower_bound) | (series > upper_bound)]
    return len(outliers)

# Check outlier counts after capping
purchase_order_outliers = count_outliers(df['purchase_order'])
cost_center_outliers = count_outliers(df['cost_center'])

print({'Column': 'purchase_order', 'Outlier Count': purchase_order_outliers})
print({'Column': 'cost_center', 'Outlier Count': cost_center_outliers})






##########################################################################
#FOR Supplier And Vendor Code Outliers Correction
# Function to cap outliers based on IQR
def cap_outliers(series):
    Q1 = series.quantile(0.25)
    Q3 = series.quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    # Cap the outliers
    series = series.clip(lower_bound, upper_bound)
    return series

# Apply capping to the specified columns
df['supplier'] = cap_outliers(df['supplier'])
df['vendor_code'] = cap_outliers(df['vendor_code'])

# Verify the results by checking the outlier counts again
def count_outliers(series):
    Q1 = series.quantile(0.25)
    Q3 = series.quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    # Count outliers
    outliers = series[(series < lower_bound) | (series > upper_bound)]
    return len(outliers)

# Check outlier counts after capping
purchase_order_outliers = count_outliers(df['supplier'])
cost_center_outliers = count_outliers(df['vendor_code'])

print({'Column': 'supplier', 'Outlier Count': purchase_order_outliers})
print({'Column': 'vendor_code', 'Outlier Count': cost_center_outliers})


########################### CORRECTION FOR ALL NUMERIC COLUMNS #############################
# Function to round and correct non-integers to integers
def correct_to_integer(series):
    """
    Round a pandas Series to integers, handling non-integer values by rounding.
    
    Parameters:
    series (pd.Series): The Series to convert.

    Returns:
    pd.Series: The Series converted to integer type, preserving NaNs.
    """
    # Round non-integer values and convert to integers
    series_rounded = series.round().astype('Int64')  # Use Int64 dtype to preserve NaNs
    return series_rounded

# Correct specified columns to integers without filling NaNs
columns_to_correct = ['order', 'purchase_order', 'cost_center', 'supplier', 'vendor_code']

for col in columns_to_correct:
    df[col] = correct_to_integer(df[col])

# Display the corrected DataFrame
print("Corrected DataFrame:")
print(df)
############################################################################################


##################################### HANDLING MISSING VALUES #######################
###############################################
######################## REMAINING NULLS AFTER APPLYING THIS 18082
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression

# Convert the 'order' and 'purchase_order' columns to numeric, forcing errors to NaN
df['order'] = pd.to_numeric(df['order'], errors='coerce')
df['purchase_order'] = pd.to_numeric(df['purchase_order'], errors='coerce')

# Drop rows where 'purchase_order' is NaN and store them in a separate DataFrame
df_cleaned = df.dropna(subset=['purchase_order'])

# Separate rows with missing 'order' values
df_missing_order = df_cleaned[df_cleaned['order'].isnull()]

# Separate rows with non-missing 'order' values for training
df_non_missing_order = df_cleaned[df_cleaned['order'].notnull()]

# Features and target for training
X_train = df_non_missing_order[['purchase_order']]
y_train = df_non_missing_order['order']

# Train the Linear Regression model
model = LinearRegression()
model.fit(X_train, y_train)

# Predict the missing 'order' values
X_predict = df_missing_order[['purchase_order']]
predicted_orders = model.predict(X_predict)

# Convert the 'order' column to float to safely fill the values
df['order'] = df['order'].astype(float)

# Fill the missing 'order' values in the original DataFrame
df.loc[df['order'].isnull() & df['purchase_order'].notnull(), 'order'] = predicted_orders

# Optionally convert the 'order' column back to integers if necessary
df['order'] = df['order'].round().astype('Int64')  # using 'Int64' to handle any potential null values

# Store the 'purchase_order' values into a new DataFrame for analysis
purchase_order_analysis = df_cleaned[['purchase_order']].copy()

# Display the updated DataFrame and the new purchase_order DataFrame
print("\nDataFrame after filling missing 'order' values:")
print(df.head())

print("\nNew DataFrame with 'purchase_order' values for analysis:")
print(purchase_order_analysis.head())


########## NOW WE USING COST CENTER COLUMN
################### THIS METHOD WORKED AND NOW THE NULL COUNT REMAINING IS 8467
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression

# Convert the 'order' and 'cost_center' columns to numeric, forcing errors to NaN
df['order'] = pd.to_numeric(df['order'], errors='coerce')
df['cost_center'] = pd.to_numeric(df['cost_center'], errors='coerce')

# Drop rows where 'cost_center' is NaN and store them in a separate DataFrame
df_cleaned = df.dropna(subset=['cost_center'])

# Separate rows with missing 'order' values
df_missing_order = df_cleaned[df_cleaned['order'].isnull()]

# Separate rows with non-missing 'order' values for training
df_non_missing_order = df_cleaned[df_cleaned['order'].notnull()]

# Features and target for training
X_train = df_non_missing_order[['cost_center']]
y_train = df_non_missing_order['order']

# Train the Linear Regression model
model = LinearRegression()
model.fit(X_train, y_train)

# Predict the missing 'order' values
X_predict = df_missing_order[['cost_center']]
predicted_orders = model.predict(X_predict)

# Convert the 'order' column to float to safely fill the values
df['order'] = df['order'].astype(float)

# Fill the missing 'order' values in the original DataFrame
df.loc[df['order'].isnull() & df['cost_center'].notnull(), 'order'] = predicted_orders

# Optionally convert the 'order' column back to integers if necessary
df['order'] = df['order'].round().astype('Int64')  # using 'Int64' to handle any potential null values

# Store the 'cost_center' values into a new DataFrame for analysis
cost_center_analysis = df_cleaned[['cost_center']].copy()

# Display the updated DataFrame and the new cost_center DataFrame
print("\nDataFrame after filling missing 'order' values:")
print(df.head())

print("\nNew DataFrame with 'cost_center' values for analysis:")
print(cost_center_analysis.head())

############ NOW I'M USING KNN METHOD FOR REMAINING COUNT 8467
import pandas as pd
from sklearn.impute import KNNImputer
# Convert columns to float before imputation
df['order'] = df['order'].astype(float)
df['purchase_order'] = df['purchase_order'].astype(float)
df['cost_center'] = df['cost_center'].astype(float)
df['supplier'] = df['supplier'].astype(float)
df['vendor_code'] = df['vendor_code'].astype(float)

# Features for imputation
features = ['purchase_order', 'cost_center', 'supplier', 'vendor_code']

# Initialize and fit the KNN Imputer
knn_imputer = KNNImputer(n_neighbors=5)
df[features] = knn_imputer.fit_transform(df[features])

# Handle remaining missing values in 'order' column
df['order'] = df['order'].fillna(df['order'].mean())

# Round the 'order' column values to nearest integer
df['order'] = df['order'].round()

# Convert 'order' column to integer type if necessary
df['order'] = df['order'].astype('Int64')  # Using 'Int64' to handle any potential null values

# Display the DataFrame
print("\nDataFrame after KNN imputation and handling missing values:")
print(df)

# Round the columns and convert them to integers
df['order'] = df['order'].round().astype(int)
df['purchase_order'] = df['purchase_order'].round().astype(int)
df['cost_center'] = df['cost_center'].round().astype(int)
df['supplier'] = df['supplier'].round().astype(int)
df['vendor_code'] = df['vendor_code'].round().astype(int)



######################################################################################

# Identify numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns


# Get the data types of each column and store them in a variable
data_types = df.dtypes


##########  Numeric Columns With Null Values  ############
# Check for missing values in numeric columns
null_values_numeric = df[numeric_columns].isnull().sum()

# Filter out columns where null values are present
numeric_columns_with_nulls = null_values_numeric[null_values_numeric > 0].index.tolist()



########### SKIP THIS PART###########################
###############################################################################
########### FOR ORDER ############
# Convert to numeric, setting errors='coerce' to handle non-numeric values
df['order'] = pd.to_numeric(df['order'], errors='coerce')

# Replace NaN with the placeholder value (-1)
df['order'].fillna(-1, inplace=True)

# Convert the column to integer type
df['order'] = df['order'].astype('int')

########### FOR SUPPLIER ############
# Replace NaN with the placeholder value (-1)
df['supplier'].fillna(-1, inplace=True)

# Convert the column to integer type
df['supplier'] = df['supplier'].astype('int')

########### FOR VENDOR CODE ############
# Replace NaN with the placeholder value (-1)
df['vendor_code'].fillna(-1, inplace=True)

# Convert the column to integer type
df['vendor_code'] = df['vendor_code'].astype('int')
################## THIS PART ############################
###################################################################################




################ NON-NUMERIC (CATEGORICAL) COLUMNS ####################

# Identify columns to exclude
exclude_types = ['number', 'int64', 'float64', 'datetime64[ns]', 'timedelta64[ns]']

# Select columns that are not of these types
categorical_columns = df.select_dtypes(exclude=exclude_types)

# Get the names of categorical columns
categorical_column_names = categorical_columns.columns.tolist()


# Check for missing values in numeric columns
missing_values_categorical = categorical_columns.isnull().sum()

# Step 5: Detect and Handle Duplicates
# Find duplicates across all columns in the DataFrame
duplicates = df[df.duplicated(keep=False)]

print("Duplicate Rows in the DataFrame:")
print(duplicates)

# Drop the specified columns
df = df.drop(columns=['consumption', 'receipt_indicator'])

################ FOR STORAGE LOCATION ##################
# Replace NaN values in 'storage_location' with 'UNSPECIFIED'
df['storage_location'] = df['storage_location'].fillna('UNSPECIFIED')


############### FOR REFERENCE ###################
# Replace NaN values in 'reference' with 'UNKNOWN'
df['reference'] = df['reference'].fillna('UNKNOWN')


############## FOR ORDER PRICE UNIT #############
# Update 'order_price_unit' where the value is NaN
df['order_price_unit'] = df['order_price_unit'].fillna('NONE')


############# FOR ORDER UNIT ###############
# Update 'order_unit' where it is NaN and 'qty_in_order_unit' is 0
df.loc[(df['order_unit'].isna()) & (df['qty_in_order_unit'] == 0), 'order_unit'] = 'NONE'


########## FOR MOVEMENT INDICATOR #########
# Update 'movement_indicator' where the value is NaN
df['movement_indicator'] = df['movement_indicator'].fillna('B')


####### FOR ITEM AUTOMATICALLY CREATED #######
# Update 'item_automatically_created' where the value is NaN
df['item_automatically_created'] = df['item_automatically_created'].fillna('N')



############# FOR PRODUCT DESCRIPTION ####################
# Replace NaN values with 'UNKNOWN' in 'product_description'
df['product_description'] = df['product_description'].fillna('UNKNOWN')


################# TrNSFORMATION #######################
import numpy as np
df['item_no_stock_transfer_reserv'] = df['item_no_stock_transfer_reserv'].apply(lambda x: np.log(x + 1))

# Example DataFrame numeric_columns_data with the same numeric columns
numeric_columns_data = df.select_dtypes(include=[np.number])

def normalize_column(column):
    skewness = column.skew()
    if skewness > 1:
        # Apply log transformation for high positive skewness
        return np.log1p(column - column.min() + 1)
    elif 0.5 < skewness <= 1:
        # Apply square root transformation for moderate positive skewness
        return np.sqrt(column - column.min() + 1)
    elif skewness < -1:
        # Apply square transformation for high negative skewness
        return np.square(column)
    else:
        # Return column unchanged if not skewed
        return column

# Apply normalization to each numeric column in numeric_columns_data
numeric_columns_normalized = numeric_columns_data.apply(normalize_column)

# Replace the numeric columns in the original DataFrame with the normalized values
#df[numeric_columns_data.columns] = numeric_columns_normalized

# Update the original DataFrame with normalized numeric columns
df.update(numeric_columns_normalized)

print("Normalized DataFrame:")
print(df)




### For Kurtosis Correction

# Example DataFrame with numeric columns
numeric_columns_data = df.select_dtypes(include=[np.number])

def normalize_column(column):
    skewness = column.skew()
    kurtosis = column.kurtosis()
    
    # Correct for skewness
    if skewness > 1:
        column = np.log1p(column - column.min() + 1)
    elif 0.5 < skewness <= 1:
        column = np.sqrt(column - column.min() + 1)
    elif skewness < -1:
        column = np.square(column)
    
    # Correct for kurtosis
    if kurtosis > 3:
        # Apply cube root transformation for high kurtosis
        return np.cbrt(column - column.min() + 1)
    elif kurtosis < 3:
        # Apply exponential transformation for low kurtosis
        return np.exp(column - column.min() + 1) - 1
    
    return column

# Apply normalization to each numeric column in numeric_columns_data
numeric_columns_normalized = numeric_columns_data.apply(normalize_column)

# Update the original DataFrame with normalized numeric columns
df.update(numeric_columns_normalized)


# Save the updated DataFrame back to a CSV file
df.to_csv("C:\\Users\\HP\\Cleaned_Dataset_Updated_cleaned2222.csv", index=False)



#############################################
from AutoClean import AutoClean
#Auto Clean
pipeline = AutoClean(df)
df_clean = pipeline.output

#############################################



############### EDA AFTER PRE-PROCESSING ####################

# NUMERIC COLUMNS
numeric_columns_data = df.select_dtypes(include=['number'])

# Get the data types of each column and store them in a variable
data_types = df.dtypes

# Descriptive statistics
numeric_stats = numeric_columns_data.describe()

print("\nDescriptive Statistics for Numeric Columns:")
print(numeric_stats)

# Calculate the median for each numeric column
medians = numeric_columns_data.median()

# Check for missing values in numeric columns
missing_values_count_numeric = numeric_columns_data.isnull().sum()

numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns

numeric_columns_with_dtypes = df.select_dtypes(include='number').dtypes
print(numeric_columns_with_dtypes)


######### SKEWNESS
# Compute skewness for each numeric column
skewness_values_after = df[numeric_columns].skew()
# Print skewness values
print("Skewness of Numeric Columns:")
print(skewness_values_after)


######### KURTOSIS
from scipy.stats import kurtosis
# Calculate kurtosis for each numeric column
kurtosis_values_after = {}
for column in numeric_columns:
    # Ensure the column exists in the DataFrame and is numeric
    if column in df.columns and pd.api.types.is_numeric_dtype(df[column]):
        kurt_value = kurtosis(df[column].dropna(), fisher=True)  # Fisher=True means excess kurtosis
        kurtosis_values_after[column] = kurt_value
    else:
        kurtosis_values_after[column] = None

# Display the kurtosis values
print("\nKurtosis Values:")
for column, kurt_value in kurtosis_values_after.items():
    print(f"{column}: {kurt_value}")

######################## SOME MORE VISUALIZATIONS #########################
# Visualize stock levels by material type
plt.figure(figsize=(10, 6))
sns.barplot(x='material_type', y='quantity', data=df, estimator=np.sum)
plt.title('Total Quantity by Material Type')
plt.xticks(rotation=45)
plt.show()


# Identify slow-moving stock
slow_moving_stock = df[df['quantity'] < df['quantity'].quantile(0.2)]
print("Slow-moving stock items:")
print(slow_moving_stock['material_description'].unique())


# Calculate inventory turnover ratio
inventory_turnover = df.groupby('material_id')['quantity'].sum() / df.groupby('material_id')['quantity'].mean()
print("Inventory Turnover Ratio:")
print(inventory_turnover)

# Save the updated DataFrame back to a CSV file
df.to_csv("C:\\Users\\HP\\Cleaned_Dataset_Updated_cleaned400.csv", index=False)



#######################################################################################################################
##################################  Graphical Representation  #################################
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as stats

# Identify numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns

# Outlier Detection - Box Plots
plt.figure(figsize=(15, 20))
# Adjust spacing between plots
plt.subplots_adjust(hspace=0.9, wspace=0.3)  # hspace and wspace control vertical and horizontal spacing
for i, column in enumerate(numeric_columns, 1):
    plt.subplot(5, 3, i)  # Adjust the subplot grid if necessary, e.g., (5, 3)
    sns.boxplot(data=df, x=column)
    plt.title(f'Box Plot of {column}')
plt.show()


# FOR MATERIAL ID
# Box plot for 'Material ID'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='material_id', color='skyblue', orient='v')
plt.title('Box Plot of Material ID', fontsize=16)
plt.ylabel('Material ID', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Material ID'
plt.subplot(1, 2, 2)
sns.histplot(df['material_id'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Material ID', fontsize=16)
plt.xlabel('Material ID', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()



# FOR PLANT CODE
# Create a vertical box plot and histogram for 'Plant Code'
plt.figure(figsize=(14, 6))
# Box plot for 'Plant Code'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='plant_code', color='skyblue', orient='v')
plt.title('Box Plot of Plant Code', fontsize=16)
plt.ylabel('Plant Code', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Plant Code'
plt.subplot(1, 2, 2)
sns.histplot(df['plant_code'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Plant Code', fontsize=16)
plt.xlabel('Plant Code', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# FOR MOVEMENT TYPE
# Create a figure for 'Movement Type'
plt.figure(figsize=(14, 6))
# Box plot for 'Movement Type'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='movement_type', color='skyblue', orient='v')
plt.title('Box Plot of Movement Type', fontsize=16)
plt.ylabel('Movement Type', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Movement Type'
plt.subplot(1, 2, 2)
sns.histplot(df['movement_type'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Movement Type', fontsize=16)
plt.xlabel('Movement Type', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# FOR MATERIAL DOCUMENT
# Create a figure for 'Material Document'
plt.figure(figsize=(14, 6))
# Box plot for 'Material Document'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='material_document', color='skyblue', orient='v')
plt.title('Box Plot of Material Document', fontsize=16)
plt.ylabel('Material Document', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Material Document'
plt.subplot(1, 2, 2)
sns.histplot(df['material_document'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Material Document', fontsize=16)
plt.xlabel('Material Document', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# FOR QTY IN UN OF ENTRY
# Box plot for 'Qty in Un. of Entry'
plt.subplot(2, 2, 1)
sns.boxplot(data=df, y='qty_in_un_of_entry', color='skyblue', orient='v')
plt.title('Box Plot of Qty in Un. of Entry', fontsize=16)
plt.ylabel('Qty in Un. of Entry', fontsize=14)
plt.xlabel('Value', fontsize=14)


# Histogram for 'Qty in Un. of Entry'
plt.subplot(2, 2, 2)
sns.histplot(df['qty_in_un_of_entry'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Qty in Un. of Entry', fontsize=16)
plt.xlabel('Qty in Un. of Entry', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.show()


# FOR ORDER
# Box plot for 'Order'
plt.subplot(2, 2, 3)
sns.boxplot(data=df, y='order', color='skyblue', orient='v')
plt.title('Box Plot of Order', fontsize=16)
plt.ylabel('Order', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Order'
plt.subplot(2, 2, 4)
sns.histplot(df['order'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Order', fontsize=16)
plt.xlabel('Order', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR QTY IN OPUN
# Create a figure for 'Qty in OPUn'
plt.figure(figsize=(14, 6))
# Box plot for 'Qty in OPUn'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='qty_in_opun', color='skyblue', orient='v')
plt.title('Box Plot of Qty in OPUn', fontsize=16)
plt.ylabel('Qty in OPUn', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Qty in OPUn'
plt.subplot(1, 2, 2)
sns.histplot(df['qty_in_opun'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Qty in OPUn', fontsize=16)
plt.xlabel('Qty in OPUn', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR QTY IN ORDER UNIT
# Create a figure for 'Qty in order unit'
plt.figure(figsize=(14, 6))
# Box plot for 'Qty in order unit'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='qty_in_order_unit', color='skyblue', orient='v')
plt.title('Box Plot of Qty in order unit', fontsize=16)
plt.ylabel('Qty in order unit', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Qty in order unit'
plt.subplot(1, 2, 2)
sns.histplot(df['qty_in_order_unit'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Qty in order unit', fontsize=16)
plt.xlabel('Qty in order unit', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR COMPANY CODE
# Create a figure for 'Company Code'
plt.figure(figsize=(14, 6))
# Box plot for 'Company Code'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='company_code', color='skyblue', orient='v')
plt.title('Box Plot of Company Code', fontsize=16)
plt.ylabel('Company Code', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Company Code'
plt.subplot(1, 2, 2)
sns.histplot(df['company_code'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Company Code', fontsize=16)
plt.xlabel('Company Code', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR AMOUNT IN LC
# Create a figure for 'Amount in LC'
plt.figure(figsize=(14, 6))
# Box plot for 'Amount in LC'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='amount_in_lc', color='skyblue', orient='v')
plt.title('Box Plot of Amount in LC', fontsize=16)
plt.ylabel('Amount in LC', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Amount in LC'
plt.subplot(1, 2, 2)
sns.histplot(df['amount_in_lc'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Amount in LC', fontsize=16)
plt.xlabel('Amount in LC', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR PURCHASE ORDER
# Create a figure for 'Purchase Order'
plt.figure(figsize=(14, 6))
# Box plot for 'Purchase Order'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='purchase_order', color='skyblue', orient='v')
plt.title('Box Plot of Purchase Order', fontsize=16)
plt.ylabel('Purchase Order', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Purchase Order'
plt.subplot(1, 2, 2)
sns.histplot(df['purchase_order'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Purchase Order', fontsize=16)
plt.xlabel('Purchase Order', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR ITEM
# Create a figure for 'Item'
plt.figure(figsize=(14, 6))
# Box plot for 'Item'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='item', color='skyblue', orient='v')
plt.title('Box Plot of Item', fontsize=16)
plt.ylabel('Item', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Item'
plt.subplot(1, 2, 2)
sns.histplot(df['item'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Item', fontsize=16)
plt.xlabel('Item', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR REASON FOR MOVEMENT
# Create a figure for 'Reason for Movement'
plt.figure(figsize=(14, 6))
# Box plot for 'Reason for Movement'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='reason_for_movement', color='skyblue', orient='v')
plt.title('Box Plot of Reason for Movement', fontsize=16)
plt.ylabel('Reason for Movement', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Reason for Movement'
plt.subplot(1, 2, 2)
sns.histplot(df['reason_for_movement'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Reason for Movement', fontsize=16)
plt.xlabel('Reason for Movement', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR COST CENTER
# Create a figure for 'Cost Center'
plt.figure(figsize=(14, 6))
# Box plot for 'Cost Center'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='cost_center', color='skyblue', orient='v')
plt.title('Box Plot of Cost Center', fontsize=16)
plt.ylabel('Cost Center', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Cost Center'
plt.subplot(1, 2, 2)
sns.histplot(df['cost_center'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Cost Center', fontsize=16)
plt.xlabel('Cost Center', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR SUPPLIER
# Create a figure for 'Supplier'
plt.figure(figsize=(14, 6))
# Box plot for 'Supplier'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='supplier', color='skyblue', orient='v')
plt.title('Box Plot of Supplier', fontsize=16)
plt.ylabel('Supplier', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Supplier'
plt.subplot(1, 2, 2)
sns.histplot(df['supplier'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Supplier', fontsize=16)
plt.xlabel('Supplier', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR QUANTITY
# Create a figure for 'Quantity'
plt.figure(figsize=(14, 6))
# Box plot for 'Quantity'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='quantity', color='skyblue', orient='v')
plt.title('Box Plot of Quantity', fontsize=16)
plt.ylabel('Quantity', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Quantity'
plt.subplot(1, 2, 2)
sns.histplot(df['quantity'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Quantity', fontsize=16)
plt.xlabel('Quantity', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


#FOR MATERIAL DOC YEAR
# Create a figure for 'Material Doc. Year'
plt.figure(figsize=(14, 6))
# Box plot for 'Material Doc. Year'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='material_doc_year', color='skyblue', orient='v')
plt.title('Box Plot of Material Doc. Year', fontsize=16)
plt.ylabel('Material Doc. Year', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Material Doc. Year'
plt.subplot(1, 2, 2)
sns.histplot(df['material_doc_year'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Material Doc. Year', fontsize=16)
plt.xlabel('Material Doc. Year', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()



# ITEM NO STOCK TRANSFER RESERV
# Create a figure for 'Item No. Stock Transfer Reserv.'
plt.figure(figsize=(14, 6))
# Box plot for 'Item No. Stock Transfer Reserv.'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='item_no_stock_transfer_reserv', color='skyblue', orient='v')
plt.title('Box Plot of Item No. Stock Transfer Reserv.', fontsize=16)
plt.ylabel('Item No.Stock Transfer Reserv.', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Item No. Stock Transfer Reserv.'
plt.subplot(1, 2, 2)
sns.histplot(df['item_no_stock_transfer_reserv'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Item No. Stock Transfer Reserv.', fontsize=16)
plt.xlabel('Item No.Stock Transfer Reserv.', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# VENDOR CODE
# Create a figure for 'Vendor Code'
plt.figure(figsize=(14, 6))
# Box plot for 'Vendor Code'
plt.subplot(1, 2, 1)
sns.boxplot(data=df, y='vendor_code', color='skyblue', orient='v')
plt.title('Box Plot of Vendor Code', fontsize=16)
plt.ylabel('Vendor Code', fontsize=14)
plt.xlabel('Value', fontsize=14)

# Histogram for 'Vendor Code'
plt.subplot(1, 2, 2)
sns.histplot(df['vendor_code'].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
plt.title('Distribution of Vendor Code', fontsize=16)
plt.xlabel('Vendor Code', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.tight_layout()
plt.show()


# Data Distribution - Histograms
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns
df[numeric_columns].hist(bins=15, figsize=(15, 10))
plt.suptitle('Histograms of Numeric Columns', fontsize=16)
plt.tight_layout(h_pad=4.0, rect=[0, 0.03, 1, 0.95])  # Adjust h_pad for vertical spacing
plt.show()


# Identify numeric columns
numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns

# Plot histograms for all numeric columns
for column in numeric_columns:
    plt.figure(figsize=(10, 6))
    sns.histplot(df[column].dropna(), bins=30, kde=True)  # KDE for a smoother distribution
    plt.title(f'Distribution of {column}')
    plt.xlabel(column)
    plt.ylabel('Frequency')
    plt.show()


# Compute correlation matrix
corr = df[numeric_columns].corr()
# Heatmap to visualize correlations
plt.figure(figsize=(16, 12))
sns.heatmap(corr, annot=True, cmap='coolwarm', fmt=".2f")
plt.title('Correlation Matrix')
plt.show()
# Sort columns in ascending order

    
# Plot QQ plots for each numeric column one by one
for col in numeric_columns:
    plt.figure(figsize=(6, 6))
    stats.probplot(df[col].dropna(), dist="norm", plot=plt)
    plt.title(f'QQ Plot of {col}')
    plt.show()



numeric_columns = df.select_dtypes(include=['float64', 'int64', 'int32']).columns

######### SKEWNESS
# Compute skewness for each numeric column
skewness_values = df[numeric_columns].skew()
# Print skewness values
print("Skewness of Numeric Columns:")
print(skewness_values)



# Visualize skewness using a bar plot
plt.figure(figsize=(12, 6))
sns.barplot(x=skewness_values.index, y=skewness_values.values, palette="viridis")
plt.axhline(0, color='gray', linestyle='--')
plt.title('Skewness of Numeric Columns')
plt.xlabel('Columns')
plt.ylabel('Skewness')
plt.xticks(rotation=45, ha='right')  # Rotate x-axis labels for better readability

# Add labels to each bar
for i, value in enumerate(skewness_values):
    plt.text(i, value + (0.1 if value >= 0 else -0.1), f'{value:.2f}', 
             ha='center', va='bottom' if value >= 0 else 'top', fontsize=13, color='black')

plt.tight_layout()
plt.show()



import numpy as np
# Filter to only numeric columns
numeric_columns = df.select_dtypes(include=[np.number])

# Calculate kurtosis for numeric columns
kurtosis_values = numeric_columns.kurtosis()

# Visualize kurtosis using a bar plot
plt.figure(figsize=(10, 6))
sns.barplot(x=kurtosis_values.index, y=kurtosis_values.values, palette="viridis")
plt.axhline(0, color='gray', linestyle='--')
plt.title('Kurtosis of Numeric Columns')
plt.xlabel('Columns')
plt.ylabel('Kurtosis')
plt.xticks(rotation=45, ha='right')  # Rotate x-axis labels for better readability

# Add labels to each bar
for i, value in enumerate(kurtosis_values):
    plt.text(i, value + (0.1 if value >= 0 else -0.1), f'{value:.2f}', 
             ha='center', va='bottom' if value >= 0 else 'top', fontsize=13, color='black')

plt.tight_layout()
plt.show()


##################### NORMALIZING COLUMNS ########################

def best_transformation(column):
    transformations = {}
    
    # Original data Q-Q plot (used as a baseline)
    original_stat, original_p_value = stats.normaltest(column)
    transformations['Original'] = column
    
    # Log transformation (only apply if all values are positive)
    if np.all(column > 0):
        log_transformed = np.log(column)
        log_stat, log_p_value = stats.normaltest(log_transformed)
        transformations['Log'] = log_transformed
    
    # Square root transformation
    sqrt_transformed = np.sqrt(column)
    sqrt_stat, sqrt_p_value = stats.normaltest(sqrt_transformed)
    transformations['Square Root'] = sqrt_transformed
    
    # Cube root transformation
    cbrt_transformed = np.cbrt(column)
    cbrt_stat, cbrt_p_value = stats.normaltest(cbrt_transformed)
    transformations['Cube Root'] = cbrt_transformed
    
    # Exponential transformation
    exp_transformed = np.exp(column) - 1
    exp_stat, exp_p_value = stats.normaltest(exp_transformed)
    transformations['Exponential'] = exp_transformed
    
    # Square transformation
    square_transformed = np.square(column)
    square_stat, square_p_value = stats.normaltest(square_transformed)
    transformations['Square'] = square_transformed
    
    # Inverse transformation (only apply if all values are positive)
    if np.all(column > 0):
        inverse_transformed = 1 / column
        inverse_stat, inverse_p_value = stats.normaltest(inverse_transformed)
        transformations['Inverse'] = inverse_transformed
    
    # Evaluate the p-values from normality tests and select the best transformation
    best_transformation_name = min(transformations, key=lambda k: stats.normaltest(transformations[k])[1])
    return transformations[best_transformation_name], best_transformation_name

# Example DataFrame with numeric columns
numeric_columns_data = df.select_dtypes(include=[np.number])

# Apply the best transformation to each numeric column
for column_name in numeric_columns_data.columns:
    transformed_column, transformation_name = best_transformation(numeric_columns_data[column_name])
    print(f"Best transformation for {column_name}: {transformation_name}")
    df[column_name] = transformed_column





##################################### SKIP THIS PART ALSO ####################
############# NOW WE ARE USING ON SUPPLIER
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression

# Convert the 'order' and 'supplier' columns to numeric, forcing errors to NaN
df['order'] = pd.to_numeric(df['order'], errors='coerce')
df['supplier'] = pd.to_numeric(df['supplier'], errors='coerce')

# Drop rows where 'supplier' is NaN and store them in a separate DataFrame
df_cleaned = df.dropna(subset=['supplier'])

# Separate rows with missing 'order' values
df_missing_order = df_cleaned[df_cleaned['order'].isnull()]

# Separate rows with non-missing 'order' values for training
df_non_missing_order = df_cleaned[df_cleaned['order'].notnull()]

# Check if there are any rows to train on
if df_non_missing_order.shape[0] > 0:
    # Features and target for training
    X_train = df_non_missing_order[['supplier']]
    y_train = df_non_missing_order['order']

    # Train the Linear Regression model
    model = LinearRegression()
    model.fit(X_train, y_train)

    # Predict the missing 'order' values
    X_predict = df_missing_order[['supplier']]
    predicted_orders = model.predict(X_predict)

    # Convert the 'order' column to float to safely fill the values
    df['order'] = df['order'].astype(float)

    # Fill the missing 'order' values in the original DataFrame
    df.loc[df['order'].isnull() & df['supplier'].notnull(), 'order'] = predicted_orders

    # Optionally convert the 'order' column back to integers if necessary
    df['order'] = df['order'].round().astype('Int64')  # using 'Int64' to handle any potential null values
else:
    print("No non-null data available for training the model. Consider using a different imputation strategy.")

# Store the 'supplier' values into a new DataFrame for analysis
supplier_analysis = df_cleaned[['supplier']].copy()

# Display the updated DataFrame and the new supplier DataFrame
print("\nDataFrame after filling missing 'order' values:")
print(df.head())

print("\nNew DataFrame with 'supplier' values for analysis:")
print(supplier_analysis.head())

############### NOW WE ARE USING ON TENDOR CODE
##############WILL IT WORK OR NOT

import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression

# Convert the 'order' and 'vendor_code' columns to numeric, forcing errors to NaN
df['order'] = pd.to_numeric(df['order'], errors='coerce')
df['vendor_code'] = pd.to_numeric(df['vendor_code'], errors='coerce')

# Drop rows where 'vendor_code' is NaN and store them in a separate DataFrame
df_cleaned = df.dropna(subset=['vendor_code'])

# Separate rows with missing 'order' values
df_missing_order = df_cleaned[df_cleaned['order'].isnull()]

# Separate rows with non-missing 'order' values for training
df_non_missing_order = df_cleaned[df_cleaned['order'].notnull()]

# Check if there are any rows to train on
if df_non_missing_order.shape[0] > 0:
    # Features and target for training
    X_train = df_non_missing_order[['vendor_code']]
    y_train = df_non_missing_order['order']

    # Train the Linear Regression model
    model = LinearRegression()
    model.fit(X_train, y_train)

    # Predict the missing 'order' values
    X_predict = df_missing_order[['vendor_code']]
    predicted_orders = model.predict(X_predict)

    # Convert the 'order' column to float to safely fill the values
    df['order'] = df['order'].astype(float)

    # Fill the missing 'order' values in the original DataFrame
    df.loc[df['order'].isnull() & df['vendor_code'].notnull(), 'order'] = predicted_orders

    # Optionally convert the 'order' column back to integers if necessary
    df['order'] = df['order'].round().astype('Int64')  # using 'Int64' to handle any potential null values
else:
    print("No non-null data available for training the model. Consider using a different imputation strategy.")

# Store the 'vendor_code' values into a new DataFrame for analysis
vendor_code_analysis = df_cleaned[['vendor_code']].copy()

# Display the updated DataFrame and the new vendor_code DataFrame
print("\nDataFrame after filling missing 'order' values:")
print(df.head())

print("\nNew DataFrame with 'vendor_code' values for analysis:")
print(vendor_code_analysis.head())

####################################################################################
