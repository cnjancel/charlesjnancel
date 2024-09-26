library(readxl)
library(openxlsx)

# Load the in-sample dataset (used to estimate the models)
data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Excel Raw/compiled_nutritional_data.xlsx")

model1 <- lm(Calories ~ `Total Fat`, data = data)
mse1 <- mean(residuals(model1)^2)

model2 <- lm(Calories ~ `Total Carbohydrate`, data = data)
mse2 <- mean(residuals(model2)^2)

model3 <- lm(Calories ~ Sugars, data = data)
mse3 <- mean(residuals(model3)^2)

model4 <- lm(Calories ~ Protein, data = data)
mse4 <- mean(residuals(model4)^2)

# Load the out-of-sample dataset (new data not used to estimate the models)
out_sample_data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Predicted_Calories_New_Data.xlsx")

# Assuming Predicted_Calories_New_Data.xlsx is the same as compiled_nutritional_data_2.xlsx but with predictions
# Calculate Out-of-Sample MSE for each model
out_sample_data$Residuals_Fat <- out_sample_data$Calories - out_sample_data$Predicted_Calories_Fat
out_sample_data$Residuals_Carbs <- out_sample_data$Calories - out_sample_data$Predicted_Calories_Carbs
out_sample_data$Residuals_Sugars <- out_sample_data$Calories - out_sample_data$Predicted_Calories_Sugars
out_sample_data$Residuals_Protein <- out_sample_data$Calories - out_sample_data$Predicted_Calories_Protein

out_sample_MSE_Fat <- mean(out_sample_data$Residuals_Fat^2)
out_sample_MSE_Carbs <- mean(out_sample_data$Residuals_Carbs^2)
out_sample_MSE_Sugars <- mean(out_sample_data$Residuals_Sugars^2)
out_sample_MSE_Protein <- mean(out_sample_data$Residuals_Protein^2)

# Print the in-sample MSEs
print(paste("In-Sample MSE for Total Fat model:", mse1))
print(paste("In-Sample MSE for Total Carbohydrate model:", mse2))
print(paste("In-Sample MSE for Sugars model:", mse3))
print(paste("In-Sample MSE for Protein model:", mse4))

print(paste("Out-of-Sample MSE for Fat:", out_sample_MSE_Fat))
print(paste("Out-of-Sample MSE for Carbs:", out_sample_MSE_Carbs))
print(paste("Out-of-Sample MSE for Sugars:", out_sample_MSE_Sugars))
print(paste("Out-of-Sample MSE for Protein:", out_sample_MSE_Protein))
