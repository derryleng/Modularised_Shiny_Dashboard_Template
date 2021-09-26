example_1_server <- function(input, output, session) {
	observeEvent(input$dropdown1, {
	  output$out <- renderText({
	    if (length(input$dropdown1) > 0) {
	      paste0("You've selected ", paste(input$dropdown1, collapse = ", "))
	    } else {
	      paste0("You've selected nothing!")
	    }
	  })
	})
}
