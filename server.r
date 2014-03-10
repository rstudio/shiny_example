# a sample R interface from shiny website
# the basic commands ot plot rnoms have the following structure
# to combine with other plotting options, it is then adapted with a switch statement,
# this structure can be used to implement our splitted codes 
library(maptools)

shinyServer(function(input, output) {

  # Reactive expression to generate the requested distribution. This is 
  # called whenever the inputs change. The output renderers defined 
  # below then all used the value computed from this expression
  data <- reactive({  
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)

    dist(input$n)
  })

  # Generate a plot of the data. Also uses the inputs to build the 
  # plot label. Note that the dependencies on both the inputs and
  # the data reactive expression are both tracked, and all expressions 
  # are called in the sequence implied by the dependency graph
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n

    hist(data(), 
         main=paste('r', dist, '(', n, ')', sep=''))
  })

  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(data())
  })

  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(x=data())
  })
  
  
  # testing nni
   output$nniOutputnnd <- renderPlot({
    #dist <- rnorm(input$nniInput)
    #hist(dist)
    nm <- readShapeSpatial("data/nniDataIn.shp")
    nmp <- as(nm, "SpatialPoints")
    nm_ppp <- as(nmp, "ppp")
    nnd <- nndist(nm_ppp)
    hist(nnd)
   })
   
   output$nniOutputnni <- renderPlot({
    #dist <- rnorm(input$nniInput)
    #hist(dist)
    nm <- readShapeSpatial("data/nniDataIn.shp")
    nmp <- as(nm, "SpatialPoints")
    nm_ppp <- as(nmp, "ppp")
    nni <- nnfun(nm_ppp)
    plot(nni)
   })

   output$nniOutputGtest <- renderPlot({
    #dist <- rnorm(input$nniInput)
    #hist(dist)
    nm <- readShapeSpatial("data/nniDataIn.shp")
    nmp <- as(nm, "SpatialPoints")
    nm_ppp <- as(nmp, "ppp")
    G <- Gest(nm_ppp)
    plot(G)
   })   
   
  output$clarkevans <- renderPrint({
    nm <- readShapeSpatial("data/nniDataIn.shp")
    nmp <- as(nm, "SpatialPoints")
    nm_ppp <- as(nmp, "ppp")
    clarkevans(nm_ppp)
    clarkevans.test(nm_ppp)
  })
   
})
