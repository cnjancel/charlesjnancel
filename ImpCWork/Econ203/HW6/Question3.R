library(readxl)
library(ggplot2)
library(grid)
library(gridExtra)

data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Excel Raw/compiled_nutritional_data.xlsx")

desc_stats <- sapply(data[, -1], function(x) {
  c(Mean = mean(x, na.rm = TRUE),
    Median = median(x, na.rm = TRUE),
    Min = min(x, na.rm = TRUE),
    Max = max(x, na.rm = TRUE),
    SD = sd(x, na.rm = TRUE))
}, simplify = "data.frame")

desc_stats <- t(desc_stats)
desc_stats <- data.frame(Variable = rownames(desc_stats), desc_stats)

rownames(desc_stats) <- NULL
grid.newpage()
grid.table(desc_stats, rows = NULL)


pdf("/Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Q3.pdf")

grid.table(desc_stats)

for (i in 3:ncol(data)) {  
  col_name <- colnames(data)[i]
  if (col_name != "Calories") {
    gg <- ggplot(data, aes(x = .data[[colnames(data)[2]]], y = .data[[col_name]])) +
      geom_point() +
      labs(title = paste("Scatter Plot of", col_name, "vs Calories"),
           x = "Calories", y = col_name)
    print(gg)
  }
}
dev.off()


cat("Descriptive statistics and scatter plots have been written to: /Users/cancel/Documents/Personal/Coursework/Econ203/HW6/Q3.pdf\n")
