function(input, output) {
  
  observeEvent(
    input$updateButton,
    output$map <- renderLeaflet(
      leaflet(data_earth) %>%
        setView(lng = 35, lat = 38, zoom = 6) %>%
        addProviderTiles(input$sel_basemap) %>%
        addPolygons(
          data = Turkiye,
          label = ~Turkiye$IlAdi,
          color = input$sel_col,
          weight = input$sel_weight,
          opacity = input$sel_opacity, 
          fillOpacity = input$sel_fillopacity,
          highlightOptions = highlightOptions(color = "darkblue", weight=3,bringToFront = TRUE))%>%
        addHeatmap(
          lng = ~longitude,
          lat = ~latitude,
          intensity = input$sel_mag,
          blur = input$sel_blur,
          max = input$sel_max,
          radius = input$sel_rad
        ) %>%
        addMiniMap() %>%
        addMeasure(position="topleft",
                   primaryLengthUnit="kilometers",
                   primaryAreaUnit="hectares") %>%
        addScaleBar(position = "bottomleft") %>%
        addGraticule(interval = 1)
      )
    )
  
  observeEvent(
    input$updateButton,

    output$map_statistic <- renderPlotly({
      corr <- cor(select_if(data_earth, is.numeric))
      plot_ly(colors = "RdBu") %>%
        add_heatmap(x = rownames(corr), y = colnames(corr), z = corr) %>%
        colorbar(limits = c(-1, 1))%>%
        layout(title = 'Veriler Arasındaki Korelasyon')
      })
    )
  
  observeEvent(input$resetButton, {
    reset("sel_year")
  })
  observeEvent(input$resetButton, {
    reset("colors")
  })
  observeEvent(input$resetButton, {
    reset("sel_mag")
  })
  observeEvent(input$resetButton, {
    reset("sel_blur")
  })
  observeEvent(input$resetButton, {
    reset("sel_max")
  })
  observeEvent(input$resetButton, {
    reset("sel_rad")
  })
  
  output$data_dt <- renderDT({
    datatable(data_earth, 
              filter = 'top',
              extensions = "Buttons",
              options = list(
                searchHighlight = TRUE,
                dom = 'l<"sep">lfrtiBp',
                lengthMenu = list(c(5,10,50,-1), c("5","10","50","All")),
                buttons = list(c('copy','csv','excel','print'))
                )
              )
    })
}