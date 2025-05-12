# ************************************ Bi-Variate Scatter Plot ************************************
library(webshot2)
library(plotly)
library(ggplot2)

# ************************** Select Inputs **************************
output$Measure1 = renderUI({
  selectInput("Measure1", "Sélectionner Measure1", 
              choices = selectdata()$FeatureValue[selectdata()$FeatureName == "Variable quantitative"],
              selected = rmeasures()[1])
})

output$Measure2 = renderUI({
  selectInput("Measure2", "Sélectionner Measure2", 
              choices = selectdata()$FeatureValue[selectdata()$FeatureName == "Variable quantitative"],
              selected = rmeasures()[2])
})

# ************************** Reactive Variable **************************
dataInput2 = reactive({
  if (is.null(input$Measure1) || is.null(input$Measure2)) return(NULL)
  
  inputdata2 = finalInputData() %>% select(all_of(c(input$Measure1, input$Measure2)))
  
  if (input$Measure1 == input$Measure2) {
    colnames(inputdata2) = c("XVar")
    inputdata2$YVar = inputdata2$XVar
  } else {
    colnames(inputdata2) = c("XVar", "YVar")
  }
  
  return(inputdata2)
})

# ************************** Outputs **************************
output$ScatterPlot = renderPlotly({
  req(dataInput2())
  
  plot_ly(
    data = dataInput2(), 
    x = ~XVar, 
    y = ~YVar, 
    type = "scatter", 
    mode = "markers", 
    marker = list(size = 5)
  ) %>% layout(
    title = paste0("Scatter Plot: ", input$Measure1, " vs ", input$Measure2),
    xaxis = list(title = input$Measure1),
    yaxis = list(title = input$Measure2)
  )
})

# ************************** Download Plot **************************
output$downloadScatterPDF <- downloadHandler(
  filename = function() {
    "scatter_plot.pdf"
  },
  content = function(file) {
    req(dataInput2())
    
    scatter_plot <- ggplot(dataInput2(), aes(x = XVar, y = YVar)) +
      geom_point(size = 5) +
      labs(
        title = paste0("Scatter Plot: ", input$Measure1, " vs ", input$Measure2),
        x = input$Measure1,
        y = input$Measure2
      )
    
    ggsave(file, plot = scatter_plot, device = "pdf", width = 11, height = 8.5)
  }
)
