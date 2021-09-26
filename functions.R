# ----------------------------------------------------------------------- #
# Functions (General) -----------------------------------------------------
# ----------------------------------------------------------------------- #

# Usage: x %!in% y; this is equivalent to !(x %in% y)
'%!in%' <- function(x, y) !('%in%'(x, y))

# Evaluate a string (or multiple comma-separated strings) as R code
evalParse <- function(...) {
  return(eval(parse(text = paste0(..., collapse = ","))))
}

# ----------------------------------------------------------------------- #
# UI Wrapper Functions ----------------------------------------------------
# ----------------------------------------------------------------------- #

# Used to make buttons on the header bar
headerButtonUI <- function(id, icon_str) {
  tags$li(
    class = "dropdown header_button",
    id = id,
    icon(icon_str)
  )
}

sidebarTabUI <- function(id, text_str, icon_str) {
  menuItem(
    text = text_str,
    tabName = id,
    icon = icon(icon_str)
  )
}

pickerInput_customised <- function(
  inputId,
  label = NULL,
  choices = NULL,
  selected = NULL,
  multiple = T,
  options = pickerOptions(
    container = "body",
    actionsBox = T,
    liveSearch = T,
    virtualScroll = T,
    width = "auto"
  ),
  choicesOpt = NULL,
  width = "220px",
  inline = F,
  ...
) {
  pickerInput(
    inputId = inputId,
    label = label,
    choices = choices,
    selected = selected,
    multiple = multiple,
    options = options,
    choicesOpt = choicesOpt,
    width = width,
    inline = inline,
    ...
  )
}
