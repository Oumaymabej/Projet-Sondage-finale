strat_data <- reactiveValues(sample = NULL, allocation = NULL)

# Stratification dropdown: only categorical variables
output$strat_variable <- renderUI({
  req(selectdata())
  choices <- selectdata()$FeatureValue[selectdata()$FeatureName == "Variable qualitative"]
  selectInput("strat_variable", "Variable de stratification :", choices = choices, selected = choices[1])
})

# Auxiliary dropdown: also categorical
output$auxiliary_variable <- renderUI({
  req(finalInputData())
  
  df <- finalInputData()
  choices <- c("Aucune")
  
  if ("Area" %in% names(df)) {
    choices <- c("Aucune", "Area")
  }
  
  selectInput("auxiliary_variable", "Variable auxiliaire :", choices = choices, selected = "Aucune")
})



observeEvent(input$strat_generate, {
  req(finalInputData(), input$strat_sample_size, input$strat_variable, input$auxiliary_variable)
  
  data <- finalInputData()
  strat_var <- input$strat_variable
  n <- input$strat_sample_size

  strata_summary <- data %>%
    group_by(.data[[strat_var]]) %>%
    summarise(Nh = n(), .groups = "drop") %>%
    mutate(N = sum(Nh),
           nh = round(n * Nh / N))
  
  strat_data$allocation <- strata_summary

  sampled <- strata_summary %>%
    rowwise() %>%
    do({
      stratum_value <- .[[strat_var]]
      nh <- .$nh
      subset <- data[data[[strat_var]] == stratum_value, ]
      sample_n(subset, size = min(nh, nrow(subset)))
    }) %>%
    bind_rows()
  
  strat_data$sample <- sampled
})

# Descriptive stats per auxiliary variable
output$strat_descriptive_stats <- renderTable({
  req(strat_data$sample)
  
  strat_col <- input$strat_variable
  
  if (input$auxiliary_variable == "Aucune") {
    strat_data$sample %>%
      group_by(.data[[strat_col]]) %>%
      summarise(N = n(), .groups = "drop")
  } else {
    strat_data$sample %>%
      group_by(.data[[strat_col]], .data[[input$auxiliary_variable]]) %>%
      summarise(Freq = n(), .groups = "drop") %>%
      tidyr::pivot_wider(names_from = input$auxiliary_variable, values_from = Freq, values_fill = 0)
  }
})


# Allocation Table
output$strat_allocation_table <- DT::renderDataTable({
  req(strat_data$allocation)
  DT::datatable(strat_data$allocation, options = list(scrollX = TRUE, pageLength = 10), width = '100%')
})

# Sample Table
output$strat_sample <- DT::renderDataTable({
  req(strat_data$sample)
  DT::datatable(strat_data$sample, options = list(scrollX = TRUE, pageLength = 10), width = '100%')
})
######
output$plot_allocation_nh <- renderPlot({
  req(strat_data$allocation, input$strat_variable)
  
  df <- strat_data$allocation %>%
    mutate(Strate = reorder(.data[[input$strat_variable]], -nh))
  
  ggplot(df, aes(x = Strate, y = nh)) +
    geom_bar(stat = "identity", fill = "#0073C2FF") +
    labs(title = "Allocations proportionnelles (nh) par strate",
         x = "Strate", y = "Taille allouée (nh)") +
    theme_minimal()
})

output$download_plot_allocation <- downloadHandler(
  filename = function() { "graphique_allocation_nh.png" },
  content = function(file) {
    ggsave(file, plot = {
      df <- strat_data$allocation %>%
        mutate(Strate = reorder(.data[[input$strat_variable]], -nh))
      ggplot(df, aes(x = Strate, y = nh)) +
        geom_bar(stat = "identity", fill = "#0073C2FF") +
        labs(title = "Allocations proportionnelles (nh) par strate",
             x = "Strate", y = "Taille allouée (nh)") +
        theme_minimal()
    }, width = 8, height = 5)
  }
)

######




# Downloads
output$strat_download_sample <- downloadHandler(
  filename = function() { "echantillon_stratifie.csv" },
  content = function(file) { write.csv(strat_data$sample, file, row.names = FALSE) }
)

output$strat_download_allocation <- downloadHandler(
  filename = function() { "allocation_stratifiee.csv" },
  content = function(file) { write.csv(strat_data$allocation, file, row.names = FALSE) }
)
