var pltDim = [0, 0];
$(document).on("shiny:filedownload", function(e){
  pltDim[0] = document.getElementById("#[track_visualiser]pltmap").clientWidth;
  pltDim[1] = document.getElementById("#[track_visualiser]pltmap").clientHeight;
  Shiny.onInputChange("#[track_visualiser]pltDim", pltDim);
});
