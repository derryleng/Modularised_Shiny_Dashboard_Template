example_2_ui <- function(id) {
	ns <- NS(id)
	div(
	    box(
	        title = "Box 2",
	        width = NULL,
	        collapsible  = T,
	        collapsed = T,
	        "Nothing interesting happens."
	    )
	)
}
