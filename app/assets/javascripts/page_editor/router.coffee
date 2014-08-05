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
    model = @page.getElements().get(cid)

    view = if model.isParagraph()
        new ParagraphEditor { el : @el.empty(), model : model }
      else if model.isHeading()
        new HeadingEditor { el : @el.empty(), model : model }
      else if model.isImage()
        new ImageEditor { el : @el.empty(), model : model }

    @setView(view)

@Router = Router