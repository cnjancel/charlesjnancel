library(readxl)
library(openxlsx)
library(broom)
library(dplyr)

# Load the data
data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Excel Raw/compiled_nutritional_data.xlsx")

# Fit the models
model1 <- lm(Calories ~ `Total Fat`, data = data)
model2 <- lm(Calories ~ `Total Carbohydrate`, data = data)
model3 <- lm(Calories ~ Sugars, data = data)
model4 <- lm(Calories ~ Protein, data = data)

# Extract and store the summary for each model
summary_model1 <- summary(model1)
summary_model2 <- summary(model2)
summary_model3 <- summary(model3)
summary_model4 <- summary(model4)

# Get the coefficient table for each model
coef_model1 <- coef(summary_model1)
coef_model2 <- coef(summary_model2)
coef_model3 <- coef(summary_model3)
coef_model4 <- coef(summary_model4)

# Bind the rows from each model's coefficient table
all_coefs <- rbind(
  cbind(Model = "Total Fat", coef_model1),
  cbind(Model = "Total Carbohydrate", coef_model2),
  cbind(Model = "Sugars", coef_model3),
  cbind(Model = "Protein", coef_model4)
)

# Convert to a dataframe for exporting and filtering out the intercept
all_coefs_df <- as.data.frame(all_coefs)
all_coefs_df <- all_coefs_df %>% 
  filter(row.names(all_coefs_df) != "(Intercept)")

# Add a conclusion based on the p-value
all_coefs_df$Conclusion <- ifelse(all_coefs_df$`Pr(>|t|)` < 0.05, "Reject Null", "Fail to Reject Null")

write.xlsx(all_coefs_df, "Model_Coefficient_Tests.xlsx", rowNames = TRUE)
print(all_coefs_df)

