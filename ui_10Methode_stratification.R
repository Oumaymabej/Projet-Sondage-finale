fluidPage(
  tags$style(
    type = 'text/css',
    ".shiny-output-error { visibility: hidden; }",
    ".shiny-output-error:before { visibility: hidden; }"
  ),
  
  source("./ui_CustomError.R", local = TRUE)[1],
  
  fluidRow(
    column(width = 10,
           box(
             title = "Résultats de la Stratification à Allocation Proportionnelle", 
             width = 12, status = "info", solidHeader = TRUE,
             
             h4("Tableau des allocations (nh)"),
             DT::dataTableOutput("strat_allocation_table"), br(),
             
             h4("Statistiques descriptives par strate et variable auxiliaire"),
             tableOutput("strat_descriptive_stats"), br(),
             
             h4("Échantillon stratifié"),
             DT::dataTableOutput("strat_sample"), br(),
             
             
             h4("Graphique des allocations (nh) par strate"),
             plotOutput("plot_allocation_nh")
             
             
           ),
           
           box(
             width = 12, status = "primary", solidHeader = TRUE,
             column(6, downloadButton("strat_download_sample", "📥 Télécharger l’échantillon")),
             column(6, downloadButton("strat_download_allocation", "📥 Télécharger les allocations")),
             column(6, downloadButton("download_plot_allocation", "📥 Télécharger le graphique d'allocation"))
           )
    ),
    
    column(width = 2,
           box(
             title = "Paramètres", width = 12, status = "primary", solidHeader = TRUE,
             numericInput("strat_sample_size", "Taille de l’échantillon :", min = 1, value = 30),
             uiOutput("strat_variable"),
             uiOutput("auxiliary_variable"),
             actionButton("strat_generate", "Générer l’échantillon", icon = icon("layer-group"))
           )
    )
  )
)
