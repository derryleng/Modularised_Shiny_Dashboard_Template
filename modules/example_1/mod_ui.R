example_1_ui <- function(id) {
	ns <- NS(id)
	div(
	    box(
	        title = "Box 1",
	        width = NULL,
	        collapsible  = T,
	        collapsed = F,
	        pickerInput_customised(ns("dropdown1"), "Numbers", seq(1, 10, 1)),
	        textOutput(ns("out"))
	    )
	)
}
