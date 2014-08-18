
class App
  constructor: ->
    $(".expando button").click @onExpando
    $(".tabs li").click @onTabClick

  # pages#show
  onExpando: ->
    $(".left-column").toggle()

  # site#theme
  onTabClick: (e) ->
    li = $(e.currentTarget)
    name = li.attr('for')

    $(".pane").hide().filter("[name='#{name}']").show()
    li.siblings().removeClass('active')
    li.addClass('active')

@App = App