# Modularised Shiny Dashboard Template

This is a template for a [modularised](https://shiny.rstudio.com/articles/modules.html) [Shiny](https://shiny.rstudio.com/) application using the [Shiny Dashboard](https://rstudio.github.io/shinydashboard/) package.

- Each tab in the Shiny dashboard is a separate module.
- Each module is contained in a separate folder in the */modules* directory.
- Each module folder must contain at least two files:
  - mod_ui.R - this must contain a function defining the UI elements of the module.
  - mod_server.R - this must contain a function defining the Server elements of the module.
  - See the example modules for details.
- To display a new module, it must be specified in *sidebarSettings* in *settings.R*.
- Don't change the *dashboardPage* skin, change theme colours in */www/theme.css* instead.
