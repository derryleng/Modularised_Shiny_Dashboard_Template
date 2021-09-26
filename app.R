(function(req_file, install = T, update = F, silent = F) {
  # Installs (CRAN only) and loads packages listed in req.txt
  # req_file - .txt file containing list of required packages (one per line)
  req <- scan(req_file, character(), quiet = T)

  if (update) update.packages(repos = "https://cloud.r-project.org", ask = F)

  if (length(req) > 0 & install) {
    missing_packages <- req[!(req %in% installed.packages()[,"Package"])]
    if (length(missing_packages) > 0) {
      install.packages(missing_packages, repos = "https://cloud.r-project.org", dependencies = T, clean = T)
    }
  }

  if (silent) {
    suppressPackageStartupMessages(invisible(lapply(req, library, character.only = T)))
  } else {
    lapply(req, library, character.only = T)
  }

})("req.txt", silent = F)

# Imports from all mod_ui.R and mod_server.R files
invisible(lapply(list.files(path = "modules/", pattern = "mod_ui.R|mod_server.R", recursive = T, full.names = T), source))

# Imports from settings.R and functions.R
invisible(lapply(list.files(pattern = "settings.R|functions.R"), source))

# ----------------------------------------------------------------------- #
# UI ----------------------------------------------------------------------
# ----------------------------------------------------------------------- #

header <- dashboardHeader(
  title = "Example",
  titleWidth = sidebarWidth,
  headerButtonUI("header_test", "question")
)

sidebar <- dashboardSidebar(
  width = sidebarWidth,
  sidebarMenu(
    id = "tabs",
    lapply(names(sidebarSettings), function(x) {
      tab_title <- sidebarSettings[[x]][1]
      tab_icon <- sidebarSettings[[x]][2]
      sidebarTabUI(x, tab_title, tab_icon)
    })
  )
)

body <- dashboardBody(

  useShinyjs(),

  # Load all CSS files within www folder
  lapply(list.files("www", pattern = ".css"), function(x) tags$link(rel = "stylesheet", type = "text/css", href = x)),

  # Load all JS files within www folder
  lapply(list.files("www", pattern = ".js"), function(x) tags$script(src = x)),

  # Apply minor page layout adjustment
  tags$script(HTML("$('body').addClass('fixed');")),

  # Apply all module UI content defined in mod_ui.R files
  evalParse(
    "tabItems(", paste0(
      sapply(names(sidebarSettings), function(x) {
        paste0("tabItem(\"", x, "\",", x, "_ui(\"", x ,"\")", ")", collapse = ",")
      }),
      collapse = ","
    ), ")"
  ),

  # Loading spinner
  conditionalPanel(
    condition = "$('html').hasClass('shiny-busy')",
    id = "spinner_wrapper",
    htmltools::HTML('<div class="spinner"></div>')
  )

)

ui <- dashboardPage(title = "Modularised Shiny Dashboard", skin = "red", header, sidebar, body)

# ----------------------------------------------------------------------- #
# Server ------------------------------------------------------------------
# ----------------------------------------------------------------------- #

server <- function(input, output, session) {

  # Example header button dialogue
  onclick("header_test", showModal(modalDialog("Example header button")))

  # Stop app on session end
  session$onSessionEnded(function() {
    stopApp()
  })

  # Keep track of modules that haven't been loaded
  unloaded_tabs <- reactiveVal(names(sidebarSettings))

  # Call modules
  observeEvent(input$tabs, {
    for (x in names(sidebarSettings)) {
      if (input$tabs == x & x %in% unloaded_tabs() & exists(paste0(x, "_server"))) {
        unloaded_tabs(unloaded_tabs()[unloaded_tabs() != x])
        callModule(evalParse(x, "_server"), x)
      }
    }
  })

}

shinyApp(ui, server)
