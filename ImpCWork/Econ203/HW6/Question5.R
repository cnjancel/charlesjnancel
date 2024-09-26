library(readxl)
library(ggplot2)
library(gridExtra)

# Load the data
data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Excel Raw/compiled_nutritional_data.xlsx")

# Define the output PDF file path
output_file_path <- "/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Q5.pdf"

# Start the PDF device
pdf(output_file_path, width = 8, height = 11)

# Function to plot the model summary
plot_model_summary <- function(model, label) {
  grid.newpage()  # Start a new page for each model summary
  grid.text(label, x = 0.5, y = 0.95, just = "center", gp = gpar(fontsize = 12, fontface = "bold"))
  coef_table <- as.data.frame(summary(model)$coefficients)
  coef_table <- cbind(Term = rownames(coef_table), coef_table)
  rownames(coef_table) <- NULL
  table_grob <- tableGrob(coef_table, rows = NULL, theme = ttheme_minimal())
  grid.draw(table_grob)
}

# Function to plot the scatter plot
plot_scatter <- function(data, independent_var, dependent_var, label) {
  grid.newpage()  # Start a new page for each scatter plot
  p <- ggplot(data, aes_string(x = independent_var, y = dependent_var)) +
    geom_point() +
    geom_smooth(method = "lm", color = "blue") +
    labs(title = label, x = independent_var, y = dependent_var)
  print(p)
}

# Fit the models and plot summaries
model1 <- lm(Calories ~ `Total Fat`, data = data)
plot_model_summary(model1, "Model Summary for Calories vs Total Fat")

model2 <- lm(Calories ~ `Total Carbohydrate`, data = data)
plot_model_summary(model2, "Model Summary for Calories vs Total Carbohydrate")

model3 <- lm(Calories ~ Sugars, data = data)
plot_model_summary(model3, "Model Summary for Calories vs Sugars")

model4 <- lm(Calories ~ Protein, data = data)
plot_model_summary(model4, "Model Summary for Calories vs Protein")

# Now plot the scatter plots
plot_scatter(data, "`Total Fat`", "Calories", "Scatter Plot of Calories vs Total Fat")
plot_scatter(data, "`Total Carbohydrate`", "Calories", "Scatter Plot of Calories vs Total Carbohydrate")
plot_scatter(data, "Sugars", "Calories", "Scatter Plot of Calories vs Sugars")
plot_scatter(data, "Protein", "Calories", "Scatter Plot of Calories vs Protein")

# Close the PDF device
dev.off()

cat("Model summaries and scatter plots have been written to: ", output_file_path, "\n")
