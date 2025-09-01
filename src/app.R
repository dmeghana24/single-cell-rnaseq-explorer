library(shiny)
library(Seurat)

ui <- fluidPage(
  titlePanel("scRNA-seq Data Explorer"),
  sidebarLayout(
    sidebarPanel(
      fileInput("rdsFile", "Upload Processed Seurat Object (.rds)"),
      sliderInput("pc", "PCA Components to Plot", min=1, max=20, value=1)
    ),
    mainPanel(
      plotOutput("pcaPlot")
    )
  )
)

server <- function(input, output) {
  seuratObj <- reactive({
    req(input$rdsFile)
    readRDS(input$rdsFile$datapath)
  })
  
  output$pcaPlot <- renderPlot({
    req(seuratObj())
    DimPlot(seuratObj(), reduction = "pca", dims = c(input$pc, input$pc+1))
  })
}

shinyApp(ui, server)
