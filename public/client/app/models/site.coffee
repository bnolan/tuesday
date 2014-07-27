class Site extends Backbone.Model
  url : 'site'

  getPages: ->
    @pages ||= new PageCollection(@get('pages'))

  load : (user, host, callbacks) ->
    $.ajax {
      url : "http://#{host}/sites/2.json"

      success : (response) =>
        @set(response)
        @setSiteOnPages()

        callbacks.success()

      error: callbacks.error

      crossDomain : true

      # xhrFields : {
      #   withCredentials: true
      # }
    }

  setSiteOnPages: ->
    for page in @getPages().models
      page.setSite(@)

@Site = Site

