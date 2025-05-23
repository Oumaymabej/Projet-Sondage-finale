fluidPage(
  tags$head(tags$script(
    HTML(
      "Shiny.addCustomMessageHandler(
      'resetValue',function(variableName) {
      Shiny.onInputChange(variableName, null);});"
  )
  )),
  fluidRow(
    box(title = "Entrer votre fichier de données", width = 4, status = "primary", solidHeader = TRUE,
        collapsible = TRUE,
        
        uiOutput("FileInput"),
        uiOutput("SelectSheet"),
        conditionalPanel("input.fileType == 'excel'|| input.fileType == 'csv'",
                         checkboxInput("header", "Header", TRUE)),
        conditionalPanel("input.fileType == 'csv'", 
                         radioButtons("sep", "Separator", c( Comma = ",", Semicolon = ";", Tab = "\t"), ",",
                                      inline = TRUE)),
        actionButton("btSubmit", "Soumettre"),
        htmlOutput("InputValidation")
        )),
  fluidRow(
    tabBox(title = "Traitement des données", width = 15,id = "InputData",
           tabPanel("Structure", 
                    conditionalPanel("output.ValFlag", htmlOutput("dataInfo")),
                    conditionalPanel("output.ValFlag", verbatimTextOutput("strData"))),
    
    
           tabPanel("Prévisualisation",
                    conditionalPanel("output.ValFlag", DT::dataTableOutput("DataTable"))),
           tabPanel("Choisir les attributs des colonnes",
                    conditionalPanel("output.ValFlag", withSpinner(uiOutput("SelDimMeas")), 
                                     ),
                    actionButton("validerplz", "Affecter")
           ),
           tabPanel("Néttoyage de la data",
                    fluidRow(
                      column(
                        width = 12,
                        box(
                          title = "Identification des valeurs manquantes",
                          status = "primary",
                          solidHeader = TRUE,
                          width = 12,
                          highchartOutput("missing_histogram")
                        ),
                        conditionalPanel(
                          condition = "output.hasMissing == true",
                          box(
                            title = "Voulez-vous traiter les valeurs manquantes ?",
                            status = "primary",
                            solidHeader = TRUE,
                            width = 12,
                            selectInput("treatMissingChoice", "Choix :", choices = c("Non", "Oui"))
                          )
                        ),
                        conditionalPanel(
                          condition = "output.hasMissing == true && input.treatMissingChoice == 'Oui'",
                          box(
                            title = "Gestion des valeurs manquantes",
                            status = "primary",
                            solidHeader = TRUE,
                            width = 12,
                            conditionalPanel("output.ValFlag", withSpinner(uiOutput("imputationOptions"))),
                            actionButton("applyChanges", "Valider"),
                            collapsible = TRUE
                          )
                        )
                      )
                    ),
                    actionButton("btExplore", "Explorer la data")
           )
           
          
))
)










