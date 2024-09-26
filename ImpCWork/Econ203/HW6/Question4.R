library(readxl)
library(openxlsx)


new_data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Predicted_Calories_New_Data.xlsx")

new_data$Error_Fat <- new_data$Calories - new_data$Predicted_Calories_Fat
new_data$Error_Carbs <- new_data$Calories - new_data$Predicted_Calories_Carbs
new_data$Error_Sugars <- new_data$Calories - new_data$Predicted_Calories_Sugars
new_data$Error_Protein <- new_data$Calories - new_data$Predicted_Calories_Protein


error_data <- data.frame(
  Product_Name = new_data$`Product Name`,  
  Error_Fat = new_data$Error_Fat,
  Error_Carbs = new_data$Error_Carbs,
  Error_Sugars = new_data$Error_Sugars,
  Error_Protein = new_data$Error_Protein
)
write.xlsx(error_data, "Prediction_Errors.xlsx", rowNames = FALSE)
