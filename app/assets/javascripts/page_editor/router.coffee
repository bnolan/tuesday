class Router extends Backbone.Router
  routes : {
    "" : "editPage"
    "elements/:element/edit" : "editElement"
  } 

  initialize: (@site, @page) ->
    @el = $('.edit-container')

  showSpinner: ->
    @el.empty().html("<center class='spinner'>Loading yo...</center>")

  setView: (view) ->
    if @view
      @view.undelegateEvents()

    @view = view

  editPage: (id) ->
    @setView new PageEditor { 
      el : @el.empty()
      model : @page
      collection : @page.getElements()
    }

  editElement: (cid) ->
    @setView new ElementEditor {
      el : @el.empty()
      model : @page.getElements().get(cid)
    }

@Router = Router