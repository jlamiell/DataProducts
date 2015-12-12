library(shiny)
library(ggplot2)
library(MESS)

shinyServer(function(input, output) {
        n <- 200
        output$DistPlot <- renderPlot({
                a <- min(input$m1 - 4 * input$s1, input$m2 - 4 * input$s2)
                b <- max(input$m1 + 4 * input$s1, input$m2 + 4 * input$s2)
                x <- seq(a, b, (b - a)/n)
                pdf1 <- dnorm(x, input$m1, input$s1)
                pdf2 <- dnorm(x, input$m2, input$s2)
                df <- data.frame(x, pdf1, pdf2)
                ggplot(data.frame(x, pdf1, pdf2), aes(x)) +
                        geom_line(aes(y = pdf1), color = 'yellow', size = 1.1) +
                        geom_line(aes(y = pdf2), color = 'black', size = 1.1) +
                        ggtitle('Discriminator distribution functions') + xlab('Discriminator value') + ylab('') +
                        geom_vline(xintercept = input$c, color = 'red', size = 1.1)
        })
        output$ROCPlot <- renderPlot({
                a <- min(input$m1 - 4 * input$s1, input$m2 - 4 * input$s2)
                b <- max(input$m1 + 4 * input$s1, input$m2 + 4 * input$s2)
                t <- seq(a, b, (b - a)/n)
                fp <- pnorm(t, input$m1, input$s1, lower.tail = FALSE)
                tp <- pnorm(t, input$m2, input$s2, lower.tail = FALSE)
                fpt <- pnorm(input$c, input$m1, input$s1, lower.tail = FALSE)
                tpt <- pnorm(input$c, input$m2, input$s2, lower.tail = FALSE)
                df <- data.frame(fp, tp, fpt, tpt)
                if (input$m1 < input$m2) {
                        A <- round(auc(fp, tp), 3)
                        ggplot(df) + geom_line(aes(x = fp, y = tp), color = 'black', size = 1.1) +
                                ggtitle('ROC curve') + xlab('False positive rate (1 - specificity)') +
                                ylab('True positive rate (sensitivity)') +
                                annotate('text', x = 0.75, y = 0.25, label = paste('AUC =', A)) +
                                geom_point(aes(fpt, tpt), colocr = 'red', size = 4)
                } else {
                        A <- round(auc(tp, fp), 3)
                        ggplot(df) + geom_line(aes(x = tp, y = fp), color = 'black', size = 1.1) +
                                ggtitle('ROC curve') + xlab('False positive rate (1 - specificity)') +
                                ylab('True positive rate (sensitivity)') +
                                annotate('text', x = 0.75, y = 0.25, label = paste('AUC =', A)) +
                                geom_point(aes(tpt, fpt), color = 'red', size = 4)
                }
        })
})
