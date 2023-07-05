# Load Shiny library
library(shiny)

# Source the file containing the analysis functions
source("analysis_functions.R")

# Define UI
ui <- fluidPage(
  titlePanel("Single Cell RNA-Seq Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      actionButton("load_button", "Load libraries"),
      actionButton("init_button", "Initialize Seurat object"),
      actionButton("qc_button", "Perform QC"),
      actionButton("filter_button", "Filter data"),
      actionButton("normalize_button", "Normalize data"),
      actionButton("identify_button", "Identify highly variable features"),
      actionButton("scale_button", "Scale data"),
      actionButton("linear_dim_button", "Perform linear dimensionality reduction"),
      actionButton("cluster_button", "Cluster data"),
      actionButton("nonlinear_dim_button", "Perform non-linear dimensionality reduction")
    ),
    mainPanel(
      # Output will be displayed here
    )
  )
)

# Define server logic
server <- function(input, output) {
  observeEvent(input$load_button, {
    loadLibraries()
  })
  observeEvent(input$init_button, {
    initializeSeuratObject()
  })
  observeEvent(input$qc_button, {
    performQC()
  })
  observeEvent(input$filter_button, {
    filterData()
  })
  observeEvent(input$normalize_button, {
    normalizeData()
  })
  observeEvent(input$identify_button, {
    identifyHighlyVariableFeatures()
  })
  observeEvent(input$scale_button, {
    scaleData()
  })
  observeEvent(input$linear_dim_button, {
    performLinearDimensionalityReduction()
  })
  observeEvent(input$cluster_button, {
    clusterData()
  })
  observeEvent(input$nonlinear_dim_button, {
    performNonLinearDimensionalityReduction()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
