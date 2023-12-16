# 6101 Final Project RMD Code Understanding

## Part 1 Importing data

72-81 This R code chunk is configuring global options for R Markdown, mainly to suppress warnings, hide results, and messages from output, and to set the format for numerical options.

84-87 Importing data

## Part 2 EDA

92-98 Data describe

102-107 Print the column names and change some columns to diff columns name

112-114 Check the unique value in the cab_company

117-119 Check the unique value in the cab_type

121-126 geom_boxplot for the price and different destination

137-167 performing a time series analysis, creating visualizations of hourly prices for both Uber and Lyft separately

186-199 creates side-by-side histograms for Lyft and Uber, comparing the frequency distribution of their prices, and adds a legend to distinguish between the two companies.

217-251 creating a combined boxplot visualization using ggplot2 to compare the prices of Lyft and Uber rides for different cab types, with the cab types ordered by their median prices.

275-284 creating a scatter plot that visualizes the relationship between price and distance in a dataset, with points color-coded by price and a minimalistic theme applied to the plot.

303-312 reating a boxplot to visualize the distribution of prices across different surge multipliers in a dataset, with surge multiplier categories represented by different colors in the plot.

328-333 relationship between three variables: hour, distance, and price, with markers representing data points in three-dimensional space

355-360 show sd

365-375 test normality for hour

379-387 test normality for price

test normality for distance

test normality for surge_multiplier

420-434 correlation coefficients between numeric variables in the dataset and then visualizes these correlations using a heatmap

449-454 performing a chi-squared test of independence to assess the relationship between the "cab_company" and "cab_type" variables in the dataset

## Part 3 Modeling

479-483 Linear Model (price~ distance+surge-multiplier)

517-531 

1. Converting a timestamp column in the dataframe to datetime format and extracting the weekday from it.
2. Selecting specific columns of interest from the dataframe and creating a predictor variable (X) and a target variable (y).
3. Splitting the data into training and testing sets using a 70-30 split ratio for further analysis, such as modeling.

535-571 

1. Converting a text feature column ('long_summary') in the training and testing datasets to a Corpus object for text analysis.
2. Creating document-term matrices (DTMs) for TF-IDF (Term Frequency-Inverse Document Frequency) weighting from the training and testing text data.
3. Applying TF-IDF weighting to the DTMs.
4. Performing Truncated Singular Value Decomposition (Truncated SVD) on the TF-IDF matrices to reduce dimensionality.
5. Creating data frames from the Truncated SVD output for both training and testing datasets.
6. Merging the reduced dimensionality text features back into the original training and testing datasets.
7. Dropping the original 'long_summary' column from both datasets after merging.

573-587

This R code chunk is mapping the values in the 'cab_type' column of both the training and testing datasets ('X_train' and 'X_test') to ordinal values based on a defined mapping. It replaces the original categorical values in 'cab_type' with their corresponding ordinal values specified in the 'ordinal_enc' mapping vector.

589-598

This R code chunk is performing preprocessing for categorical variables in the training and testing datasets ('X_train' and 'X_test') using the `recipes` package:

1. It creates a recipe object ('rec') specifying that all nominal (categorical) variables in the dataset should be one-hot encoded (converted to dummy variables), except for the outcome variables.
2. The 'prep' function prepares the recipe by determining the necessary data transformations based on the training data ('X_train').
3. Finally, it uses the 'bake' function to apply the prepared recipe to both the training and testing datasets, resulting in 'X_train_processed' and 'X_test_processed,' which have the categorical variables one-hot encoded and are ready for modeling.



600-605

This R code chunk is performing linear regression modeling:

1. It fits a linear regression model ('linear_model') using the training dataset ('X_train_processed') with the target variable 'y_train.'
2. The 'summary' function is used to obtain a summary of the linear regression model, which includes coefficients, standard errors, p-values, and other relevant statistics for each predictor variable in the model.

607-610 

This R code chunk is performing Principal Component Regression (PCR) to build a regression model using principal components as predictors and cross-validation for model validation.





