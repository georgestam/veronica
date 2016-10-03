###
* --------------------------------------------------------------------------------------------------------------------
* Name: Jednotka - Multipurpose Website HTML Template
* Author: http://themeforest.net/user/BublinaStudio
* Version: 1.8
* --------------------------------------------------------------------------------------------------------------------
###

$(document).ready ->
  setValidateForm()
  setIEHelperClassses()

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * Fixed header
  * --------------------------------------------------------------------------------------------------------------------
  ###
  $header   = $("#header")
  $carousel = $(".hero-carousel")
  $main     = $("#main")

  if $header.attr("fixed")
    $header.addClass("header--default")

    $(window).scroll ->
      if $(window).scrollTop() >= $carousel.height() - 150
        $header.addClass("header--fixed")
        $main.addClass("main--header-fixed")
      else
        $header.removeClass("header--fixed")
        $main.removeClass("main--header-fixed")

      if $(window).scrollTop() > $carousel.height()
        $header.addClass("header--visible")
      else
        $header.removeClass("header--visible")


  ###
  * --------------------------------------------------------------------------------------------------------------------
  * bootstrap carousel definition
  * --------------------------------------------------------------------------------------------------------------------
  ###
  if jQuery().carousel
    $('.carousel.carousel-auto').carousel()

    $('.carousel.carousel-auto').on "swipeleft", (e) ->
      $(this).carousel('next')
    $('.carousel.carousel-auto').on "swiperight", (e) ->
      $(this).carousel('prev')

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * circle statistics
  * --------------------------------------------------------------------------------------------------------------------
  ###
  if jQuery().knob
    $("[data-stat='circle']").each (i, el) ->
      $(el).knob()
  # --------------------------------------------------------------------------------------------------------------------

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * setting up bootstrap tooltips
  * --------------------------------------------------------------------------------------------------------------------
  ###
  touch = false
  if window.Modernizr
    touch = Modernizr.touch
  unless touch
    $("body").on "mouseenter", ".has-tooltip", ->
      el = $(this)
      if el.data("tooltip") is `undefined`
        el.tooltip
          placement: el.data("placement") or "top"
          container: "body"
      el.tooltip "show"

    $("body").on "mouseleave", ".has-tooltip", ->
      $(this).tooltip "hide"

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * replacing *.svg images for *.png for browsers without *.svg support
  * --------------------------------------------------------------------------------------------------------------------
  ###
  if window.Modernizr && Modernizr.svg == false
    $("img[src*=\"svg\"]").attr "src", ->
      $(this).attr("src").replace ".svg", ".png"

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * setting placeholders for browsers without placeholder support
  * --------------------------------------------------------------------------------------------------------------------
  ###
  if window.Modernizr && Modernizr.input.placeholder == false
    $("[placeholder]").focus(->
      input = $(this)
      if input.val() is input.attr("placeholder")
        input.val ""
        input.removeClass "placeholder"
    ).blur(->
      input = $(this)
      if input.val() is "" or input.val() is input.attr("placeholder")
        input.addClass "placeholder"
        input.val input.attr("placeholder")
    ).blur()
    $("[placeholder]").parents("form").submit ->
      $(this).find("[placeholder]").each ->
        input = $(this)
        input.val ""  if input.val() is input.attr("placeholder")

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * flexslider
  * --------------------------------------------------------------------------------------------------------------------
  ###
  $(window).load ->
    if jQuery().flexslider
      $flexslider = $('.flexslider')
      $allSlides = $flexslider.find('.item')
      $flexslider.addClass("fade-loading")

      $('.flexslider').flexslider
        animation: 'fade'
        pauseOnHover: true
        slideshowSpeed: 5000
        animationSpeed: 400
        prevText: ''
        nextText: ''
        before: (slider) ->
          $activeSlide = $flexslider.find('.flex-active-slide')

          if $activeSlide.index() == $allSlides.length - 1
            $allSlides.eq(0).find('.animate').children().addClass("animate").removeClass("animated")
            $allSlides.not('.flex-active-slide').find('.animate').children().addClass("animate").removeClass("animated")
          else
            $allSlides.not('.flex-active-slide').find('.animate').children().addClass("animate").removeClass("animated")

          setTimeout (->
            $allSlides.eq(slider.animatingTo).find('.animate').children().addClass("animated").removeClass("animate")
          ), 50

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * setting up countdown plugin
  * --------------------------------------------------------------------------------------------------------------------
  ###
  $("[data-countdown]").countdown() if jQuery().countdown
  # --------------------------------------------------------------------------------------------------------------------

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * Fixed panel
  * --------------------------------------------------------------------------------------------------------------------
  ###
  $mainContent = $("#main-content")

  if ($mainContent.length > 0)
    $sidebar      = $(".sidebar", "#main-content")
    contentTop    = $mainContent.offset().top
    paddingTop    = $mainContent.css("paddingTop")
    padding       = parseInt(paddingTop.substr(0, paddingTop.length-2))
    scrollHeight  = $mainContent.outerHeight() - $sidebar.outerHeight() + padding

    if $sidebar.hasClass("sidebar-fixed")
      $sidebar.parent().css({ position: "relative"})
      $sidebar.css({ position: "absolute"})
      $(window).scroll ->
        if ($(this).scrollTop() >= contentTop && $(this).scrollTop() <= scrollHeight)
          top = $(window).scrollTop() - contentTop
          $sidebar.css({ top: top })
        if $(this).scrollTop() < contentTop
          $sidebar.css({ top: 0 })
        if $(this).scrollTop() > scrollHeight
          $sidebar.css({ top: scrollHeight - contentTop })

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * scroll top button
  * --------------------------------------------------------------------------------------------------------------------
  ###
  $("#scroll-to-top").on "click", (e) ->
    $("body, html").animate
      scrollTop: 0
    , 800
    false

  $(window).load ->
    $scrollToTop = $("#scroll-to-top")
    defaultBottom = $scrollToTop.css("bottom")
    scrollArea = ->
      $(document).outerHeight() - $("#footer").outerHeight() - $(window).outerHeight()

    if $('body').hasClass("boxed")
      $(window).scroll ->
        if $(this).scrollTop() > 500
          $scrollToTop.addClass "in"
        else
          $scrollToTop.removeClass "in"
    else
      $(window).scroll ->
        if $(this).scrollTop() > 500
          $scrollToTop.addClass "in"
        else
          $scrollToTop.removeClass "in"
        if $(this).scrollTop() >= scrollArea()
          $scrollToTop.css bottom: $(this).scrollTop() - scrollArea() + 10
        else
          $scrollToTop.css bottom: defaultBottom

  ###
  * --------------------------------------------------------------------------------------------------------------------
  * setting up nivo lightbox
  * --------------------------------------------------------------------------------------------------------------------
  ###

  if jQuery().nivoLightbox
    $("[data-lightbox]").nivoLightbox()

  ###
   * --------------------------------------------------------------------------------------------------------------------
   * ajax contact form
   * --------------------------------------------------------------------------------------------------------------------
   ###

  $(".form-contact").on "submit", (e) ->
    if $(this).valid()
      e.preventDefault()

      submit = $(this).find(".form-contact-submit")
      submit.button("loading")

      success = $(this).find(".form-contact-success")
      error = $(this).find(".form-contact-error")
      inputs = $(this).find("input, textarea")

      $.ajax
        type: "POST"
        url: "contact.php"
        data: $(this).serialize()
        success: (data) ->
          if data is "success"
            success.removeClass "hidden"
            error.addClass "hidden"
            inputs.val ""
          else
            error.removeClass "hidden"
            success.addClass "hidden"
         complete: ->
           submit.button("reset")

###
* --------------------------------------------------------------------------------------------------------------------
* form validation
* --------------------------------------------------------------------------------------------------------------------
###
@setValidateForm = (selector = $(".form-validation")) ->
  if jQuery().validate
    selector.each (i, elem) ->
      $(elem).validate
        errorElement: "span"
        errorClass: "help-block has-error"
        errorPlacement: (err, e) ->
          e.closest('.control-group').append err

        highlight: (e) ->
          $(e).closest('.control-group').addClass('has-error')

        unhighlight: (e) ->
          $(e).closest('.control-group').removeClass('has-error')

###
* --------------------------------------------------------------------------------------------------------------------
* internet explorer helpers classes :last-child, :nth-child
* --------------------------------------------------------------------------------------------------------------------
###
@setIEHelperClassses = ->
  if /msie/.test(navigator.userAgent.toLowerCase())
    $('*:last-child').addClass "last-child"
    $('*:nth-child(odd)').addClass "nth-child-odd"
    $('*:nth-child(even)').addClass "nth-child-even"