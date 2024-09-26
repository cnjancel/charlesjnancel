library(readxl)
library(ggplot2)
library(gridExtra)

# Load the data
data <- read_excel("D:\\Personal\\Personal-Projects\\Coursework\\Econ203\\HW6\\Excel Raw\\compiled_nutritional_data.xlsx")

model1 <- lm(Calories ~ `Total Fat`, data = data)
mse1 <- mean(residuals(model1)^2)

model2 <- lm(Calories ~ `Total Carbohydrate`, data = data)
mse2 <- mean(residuals(model2)^2)

model3 <- lm(Calories ~ Sugars, data = data)
mse3 <- mean(residuals(model3)^2)

model4 <- lm(Calories ~ Protein, data = data)
mse4 <- mean(residuals(model4)^2)


print(mse1)
print(mse2)
print(mse3)
print(mse4)
