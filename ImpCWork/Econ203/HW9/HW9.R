# Load necessary libraries
library(readxl)
library(dplyr)

data <- read_excel("/Users/cancel/Documents/Personal/Coursework/Econ203/HW9/return.xlsx")

print(colnames(data))

str(data)

# Fit the linear regression model
model <- lm(return ~ dkr + eps + netinc + salary, data = data)

# Model including sp90
model_with_sp90 <- lm(return ~ dkr + eps + netinc + salary + sp90, data = data)
print(summary(model_with_sp90))

# Model including lsp90
model_with_lsp90 <- lm(return ~ dkr + eps + netinc + salary + lsp90, data = data)
print(summary(model_with_lsp90))

# Output the summary of the model to the console
model_summary <- summary(model)
print(model_summary)

sink("/Users/cancel/Documents/Personal/Coursework/Econ203/HW9/model_summary.txt")
print(model_summary)
sink()

sink("/Users/cancel/Documents/Personal/Coursework/Econ203/HW9/model_with_sp90_summary.txt")
print(summary(model_with_sp90))
sink()

sink("/Users/cancel/Documents/Personal/Coursework/Econ203/HW9/model_with_lsp90_summary.txt")
print(summary(model_with_lsp90))
sink()


# Save the model for future use
save(model, file = "/Users/cancel/Documents/Personal/Coursework/Econ203/HW9/regression_model.RData")
save(model_with_sp90, file = "/Users/cancel/Documents/Personal/Coursework/Econ203/HW9/regression_model_with_sp90.RData")
save(model_with_lsp90, file = "/Users/cancel/Documents/Personal/Coursework/Econ203/HW9/regression_model_with_lsp90.RData")



