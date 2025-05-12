# Méthode SAS (Aléatoire Simple Sans Remise)

output$sas_comparison_var = renderUI({
  selectInput("sas_comparison_var", "Variable comparative échantillon-cadre :",
              choices = selectdata()$FeatureValue[selectdata()$FeatureName == "Variable qualitative"],
              selected = rdimensions()[1])
})

sas_data <- reactiveValues(sample = NULL)

observeEvent(input$sas_generate, {
  req(finalInputData(), input$sas_sample_size, input$sas_comparison_var)
  
  data <- finalInputData()
  total_size <- nrow(data)
  sample_size <- min(input$sas_sample_size, total_size)
  
  set.seed(123)  # for reproducibility
  sas_data$sample <- data[sample(1:total_size, sample_size, replace = FALSE), ]
})

output$sas_sample <- DT::renderDataTable({
  req(sas_data$sample)
  
  n <- nrow(sas_data$sample)
  lm <- unique(c(5, 10, 25, 50, 100, n))
  lm <- lm[lm <= n]
  
  DT::datatable(
    sas_data$sample,
    options = list(
      lengthMenu = lm,
      pageLength = min(10, n),
      scrollX = TRUE,
      scrollY = '500px',
      autoWidth = TRUE
    ),
    width = '100%'
  )
})

output$sas_comparison_table <- DT::renderDataTable({
  req(sas_data$sample, input$sas_comparison_var)
  
  cadre <- finalInputData()[[input$sas_comparison_var]]
  ech <- sas_data$sample[[input$sas_comparison_var]]
  
  cadre_prop <- prop.table(table(cadre)) * 100
  ech_prop <- prop.table(table(ech)) * 100
  
  levels_all <- union(names(cadre_prop), names(ech_prop))
  
  comparison <- data.frame(
    Modalité = levels_all,
    Proportion_Cadre = round(cadre_prop[levels_all], 2),
    Proportion_Échantillon = round(ech_prop[levels_all], 2),
    Delta = round(ech_prop[levels_all] - cadre_prop[levels_all], 2)
  )
  
  comparison[is.na(comparison)] <- 0
  
  n <- nrow(comparison)
  lm <- unique(c(5, 10, 25, n))
  lm <- lm[lm <= n]
  
  DT::datatable(
    comparison,
    options = list(
      lengthMenu = lm,
      pageLength = min(10, n),
      scrollX = TRUE,
      scrollY = '500px',
      autoWidth = TRUE
    ),
    width = '100%'
  )
})


output$sas_comparison_plot <- renderPlotly({
  req(sas_data$sample, input$sas_comparison_var)
  
  full_prop <- prop.table(table(finalInputData()[[input$sas_comparison_var]])) * 100
  sample_prop <- prop.table(table(sas_data$sample[[input$sas_comparison_var]])) * 100
  levels_all <- union(names(full_prop), names(sample_prop))
  
  df <- data.frame(
    Modalité = rep(levels_all, 2),
    Proportion = c(full_prop[levels_all], sample_prop[levels_all]),
    Groupe = rep(c("Cadre", "Échantillon"), each = length(levels_all))
  )
  df$Proportion[is.na(df$Proportion)] <- 0
  
  plot_ly(df, x = ~Modalité, y = ~Proportion, color = ~Groupe, type = "bar", barmode = "group") %>%
    layout(title = "Comparaison des proportions")
})

output$sas_download_sample <- downloadHandler(
  filename = function() {
    "echantillon_sas.csv"
  },
  content = function(file) {
    req(sas_data$sample)
    write.csv(sas_data$sample, file, row.names = FALSE)
  }
)

output$sas_download_table <- downloadHandler(
  filename = function() {
    "comparatif_sas.csv"
  },
  content = function(file) {
    req(sas_data$sample, input$sas_comparison_var)
    
    full_prop <- prop.table(table(finalInputData()[[input$sas_comparison_var]])) * 100
    sample_prop <- prop.table(table(sas_data$sample[[input$sas_comparison_var]])) * 100
    comparison <- data.frame(
      Modalité = names(full_prop),
      Proportion_Cadre = round(full_prop, 2),
      Proportion_Échantillon = round(sample_prop[names(full_prop)], 2)
    )
    comparison[is.na(comparison)] <- 0
    write.csv(comparison, file, row.names = FALSE)
  }
)
