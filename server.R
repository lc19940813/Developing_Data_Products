data("iris")
library(caret)
inTrain <- createDataPartition(iris$Species, p = 0.7, list = FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
ctrol <- trainControl(method = "cv", number = 5)
mod1 <- train(Species ~ ., data = training, trControl = ctrol, method = "rf")
mod2 <- train(Species ~ ., data = training, trControl = ctrol, method = "gbm", verbose = FALSE)
mod <- list(mod1, mod2)
pred_train <- lapply(mod, function(model) predict(model, training))
names(pred_train) <- c("model1","model2") 
pred_train$Species <- training$Species
Stack_data <- as.data.frame(pred_train)
comod <- train(Species ~ ., data = Stack_data, method = "rf",trControl = ctrol)

res <- function(Sepal.Length,Sepal.Width,Petal.Length,Petal.Width){
    dat <- list(Sepal.Length = Sepal.Length, Sepal.Width = Sepal.Width,
                Petal.Length=Petal.Length,Petal.Width=Petal.Width)
    dat <- as.data.frame(dat)
    pred_dat <- lapply(mod, function(model) predict(model, dat))
    names(pred_dat) <- c("model1","model2") 
    Stack_data_dat <- as.data.frame(pred_dat)
    as.character(predict(comod, Stack_data_dat))
}

library(shiny)
shinyServer(
    function(input, output){
        output$prediction <- renderPrint(
            if(input$goButton == 0) "Waiting for your input"
            else {
                res(input$Sepal.Length, input$Sepal.Width,input$Petal.Length,input$Petal.Width)
            }
        )
        output$Histogram_sl <- renderPlot(
            if("sl" %in% input$checkbox)
                hist(iris$Sepal.Length, col = "lightblue", xlab = "Sepal length(cm)", main = "Histogram")
        )
        output$Histogram_sw <- renderPlot(
            if("sw" %in% input$checkbox)
                hist(iris$Sepal.Width, col = "red", xlab = "Sepal Width(cm)", main = "Histogram")
        )
        output$Histogram_pl <- renderPlot(
            if("pl" %in% input$checkbox)
                hist(iris$Petal.Length, col = "lightgreen", xlab = "Petal Length(cm)", main = "Histogram")
        )
        output$Histogram_pw <- renderPlot(
            if("pw" %in% input$checkbox)
                hist(iris$Petal.Width, col = "lightgrey", xlab = "Petal Width(cm)", main = "Histogram")
        )
        output$text1 <- renderPrint(input$Sepal.Length)
        output$text2 <- renderPrint(input$Sepal.Width)
        output$text3 <- renderPrint(input$Petal.Length)
        output$text4 <- renderPrint(input$Petal.Width)
    }
)