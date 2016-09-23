$(window).load ->
  ###
  * --------------------------------------------------------------------------------------------------------------------
  * isotope portfolio filtration
  * --------------------------------------------------------------------------------------------------------------------
  ###
  if jQuery().isotope
    $portfolio = $("#portfolio-container")
    $portfolio.isotope
      layoutMode: 'sloppyMasonry'
      itemSelector: ".portfolio-item"

    $("#portfolio-filter a").click ->
      $(this).closest("ul").find("li").removeClass("active")
      $(this).parent().addClass("active")
      selector = $(this).attr("data-filter")
      $portfolio.isotope filter: selector
      false