$(document).ready ->
  css_path = "assets/stylesheets/"
  sw = $("#style-switcher")

  sw.find(".fa.fa-cogs").click ->
    sw.toggleClass("open")

  sw.find(".style-switcher-color").click ->
    btn = $(this)
    target = $(btn.data("switch-target"))
    switch_to = $(this).data("switch-to")
    target.attr("href", "#{css_path}#{switch_to}")
    localStorage.setItem("colors", switch_to)

    setDefault(btn)
    false

  sw.find(".style-switcher-button").click ->
    btn = $(this)
    unless btn.parent().hasClass("style-switcher-reset")
      setDefault(btn)
    action = btn.data("switch-to").split(":")
    target = $(btn.data("switch-target"))

    switch action[0]
      when "addClass"
        target.addClass(action[1])
        localStorage.setItem("layout", action[1])
      when "removeClass"
        target.removeClass(action[1])
        localStorage.removeItem("layout", action[1])
      when "reset"
        target.find("[data-switch-default]").click()
        localStorage.removeItem("colors")
        localStorage.removeItem("layout")
    false

  cls = localStorage.getItem("colors")
  if cls != null && sw.find(".style-switcher-color[data-switch-to='#{cls}']").length > 0
    $("#colors").attr("href", "#{css_path}#{cls}")
    setDefault(sw.find("[data-switch-to='#{cls}']"))

  lls = localStorage.getItem("layout")
  if lls != null && sw.find(".style-switcher-button[data-switch-to='addClass:#{lls}']").length > 0
    $("body").addClass(lls)
    setDefault(sw.find("[data-switch-to='addClass:#{lls}']"))

setDefault = (s) ->
  s.parent().find("a").removeClass("active")
  s.addClass("active")
  s
