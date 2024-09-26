library(readxl)
library(ggplot2)
library(grid)
library(gridExtra)
library(openxlsx)
library(latex2exp)
library(pdftools)
library(qpdf)

# Load the data
data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Excel Raw/compiled_nutritional_data.xlsx")

output_file_path <- "/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Q2.pdf"

pdf(output_file_path, width = 8, height = 11)

# Fit the models
model1 <- lm(Calories ~ `Total Fat`, data = data)
model2 <- lm(Calories ~ `Total Carbohydrate`, data = data)
model3 <- lm(Calories ~ Sugars, data = data)
model4 <- lm(Calories ~ Protein, data = data)

# Plot summaries
plot_model_summary(model1, "Model Summary for Calories vs Total Fat")
plot_model_summary(model2, "Model Summary for Calories vs Total Carbohydrate")
plot_model_summary(model3, "Model Summary for Calories vs Sugars")
plot_model_summary(model4, "Model Summary for Calories vs Protein")

# Close the PDF device
dev.off()

new_data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Excel Part 2/compiled_nutritional_data_2.xlsx")

# Apply the models to the new data to generate predictions
new_data$Predicted_Calories_Fat <- 175.605383 + 4.361736 * new_data$`Total Fat`
new_data$Predicted_Calories_Carbs <- 157.531318 + 4.041027 * new_data$`Total Carbohydrate`
new_data$Predicted_Calories_Sugars <- 305.84865 - 8.18614 * new_data$Sugars
new_data$Predicted_Calories_Protein <- 86.67152 + 13.15175 * new_data$Protein

write.xlsx(new_data, "Predicted_Calories_New_Data.xlsx", rowNames = FALSE)

explanation_pdf <- "/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Explanation/Explanation.pdf"

combined_pdf_path <- "/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Combined_Report.pdf"

pdf_combine(c(output_file_path, explanation_pdf), output = combined_pdf_path)
