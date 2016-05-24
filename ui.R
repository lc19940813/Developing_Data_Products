library(shiny)
shinyUI(
    pageWithSidebar(
        headerPanel("Predict Species from Iris Dataset by Machine Learning Algorithm"),
        sidebarPanel(
            h4("Please enter inputs of flowers: "),
            numericInput('Sepal.Length','Sepal Length', 6, min = 4, max = 8, step = 0.1),
            numericInput('Sepal.Width','Sepal Width', 3, min = 2, max = 5, step = 0.1),
            numericInput('Petal.Length','Petal Length', 4.5, min = 1, max = 7, step = 0.1),
            numericInput('Petal.Width','Petal Width', 1.5, min = 0.1, max = 3, step = 0.1),
            actionButton("goButton", "Submit!"),
            h4("You can see the distribution of attributes of flowers according to Iris"),
            checkboxGroupInput("checkbox", "Histograms of Iris", 
                               c("Sepal Length" = "sl",
                                 "Sepal Width" = "sw",
                                 "Petal Length" = "pl",
                                 "Petal Width" = "pw"))
        ),
        mainPanel(
            h3('Results of Prediction'),
            h4('Your Inputs:'),
            h4('Sepal Length:'),
            verbatimTextOutput("text1"),
            h4('Sepal Width:'),
            verbatimTextOutput("text2"),
            h4('Petal Length:'),
            verbatimTextOutput("text3"),
            h4('Petal Width:'),
            verbatimTextOutput("text4"),
            h4('According to our machine learning algorithm, it is highly likely that the species is:'),
            verbatimTextOutput("prediction"),
            h3("Histograms of Iris:"),
            plotOutput('Histogram_sl'),
            plotOutput('Histogram_sw'),
            plotOutput('Histogram_pl'),
            plotOutput('Histogram_pw')
        )
    )
)