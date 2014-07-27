class Application
  constructor: ->
    @site = new Site {
    }

  start: ->
    @domain = window.location.host # .split(":")[0] + ":3500"

    @site.load { name : "ben", password : "froggy" }, @domain, {
      success : @startRouter
      error : ->
        alert "Oh knoes"
    }

  startRouter: =>
    @router = new Router(@site)
    Backbone.history.start()

@Application = Application