
class App
  constructor: ->
    $(".expando button").click @onExpando

  onExpando: ->
    $(".left-column").toggle()

@App = App