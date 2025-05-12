fluidPage(
  # Suppress error messages
  tags$style(
    type = 'text/css',
    ".shiny-output-error { visibility: hidden; }",
    ".shiny-output-error:before { visibility: hidden; }"
  ),
  
  # Load custom error component
  source("./ui_CustomError.R", local = TRUE)[1],
  
  fluidRow(conditionalPanel("output.ValPlots",
                            
                            # Centered results (box width = 10)
                            column(width = 10,
                                   box(
                                     title = "Résultats de l’échantillonnage (SAS)", 
                                     width = 12, status = "info", solidHeader = TRUE,
                                     
                                     h4("Échantillon généré"),
                                     DT::dataTableOutput("sas_sample"), br(),
                                     
                                     
                                     
                                     h4("Tableau comparatif des proportions"),
                                     DT::dataTableOutput("sas_comparison_table"), br(),
                                     
                                     h4("Graphique comparatif"),
                                     plotlyOutput("sas_comparison_plot", height = 400)
                                   ),
                                   
                                   # 🟦 Download buttons BELOW the result box
                                   box(
                                     width = 12, status = "primary", solidHeader = TRUE,
                                     column(6, downloadButton("sas_download_sample", "📥 Télécharger l’échantillon")),
                                     column(6, downloadButton("sas_download_table", "📥 Télécharger le tableau comparatif"))
                                   )
                            ),
                            
                            # Controls on the right (box width = 2)
                            column(width = 2,
                                   box(
                                     title = "Paramètres", width = 12, status = "primary", solidHeader = TRUE,
                                     numericInput("sas_sample_size", "Taille de l’échantillon :", min = 1, value = 30),
                                     uiOutput("sas_comparison_var"),
                                     actionButton("sas_generate", "Générer l’échantillon", icon = icon("random"))
                                   )
                            )
  ))
)
