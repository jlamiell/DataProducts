library(shiny)

shinyUI(fluidPage(
        titlePanel("Reciver operating characteristic (ROC) curves"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("m1",
                                    "Mean 1 (yellow):", min = -5, max = 5, value = 0.1, step = 0.01),
                        sliderInput("s1",
                                    "Standard deviation 1 (yellow):", min = 0, max = 5, value = 1, step = 0.01),
                        sliderInput("m2",
                                    "Mean 2 (black):", min = -5, max = 5, value = -0.1, step = 0.01),
                        sliderInput("s2",
                                    "Standard deviation 2 (black):", min = 0, max = 5, value = 1, step = 0.01),
                        sliderInput("c",
                                    "Discriminator threshold (red):", min = -5, max = 5, value = 0, step = 0.01)
                ),
#                 mainPanel(
#                         plotOutput("DistPlot"),
#                         plotOutput("ROCPlot")
#                 )
                mainPanel(
                        tabsetPanel(
                                tabPanel("Documentation",
                                         h4(""),
                                         h4("Use this Shiny app to enhance your understanding of ROC curves."),
                                         h4("ROC curves provide a way to assess binary classifiers."),
                                         h4("Binary classifiers use a discriminator to distinguish two groups."),
                                         h4("Blood pressure could be used to distinguish hypertensives and normals."),
                                         h4("Glucose could be used to distinguish diabetics and normals."),
                                         h4("One must select a discriminator threshold to classify the two groups."),
                                         h4("Discriminator threshold value determines classifier performance."),
                                         h4("Classifier performance is assessed by true and false positive rates."),
                                         h4("Classifier performance is also assessed by the area under curve (AUC)."),
                                         h4("This app provides two discriminator normal distributions."),
                                         h4("The two groups are to be classified based on discriminator value."),
                                         h4("The group means and standard deviations are slider-adjustable."),
                                         h4("A ROC curve is created from these distributions."),
                                         h4("The discriminator threshold value is slider-adjustable."),
                                         h4("Use the sliders to see how adjustable parameters change the ROC curve."),
                                         h4("View the curves on the Plots tab.")),
                                tabPanel("Plots", 
                                        plotOutput("DistPlot"),
                                        plotOutput("ROCPlot"))
                        )
                )
)))
