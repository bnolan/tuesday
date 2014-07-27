class Router extends Backbone.Router
  routes : {
    "" : "listPages"
    "pages/new" : "newPage"
    "pages/:page" : "listElements"
    "pages/:page/elements/:element/edit" : "editElement"
  } 

  initialize: (site) ->
    @site = site
    @el = $('body')
    @showSpinner()

  showSpinner: ->
    @el.empty().html("<center class='spinner'>Loading yo...</center>")

  setView: (view) ->
    if @view
      @view.undelegateEvents()

    @view = view

  listPages: ->
    @setView new PageList {
      el : @el.empty()
      model : @site
      collection : @site.getPages()
    }

  newPage: ->
    page = new Page { title : 'New Page' }

    @setView new PageEdit {
      el : @el.empty()
      model : page
    }

  # editPage: (id) ->
  #   page = @site.pages.get(id)

  #   @setView new PageEdit { 
  #     el : @el.empty()
  #     model : page
  #     collection : page.getElements()
  #   }

  listElements: (id) ->
    page = @site.getPages().get(id)

    @setView new ElementList {
      el : @el.empty()
      model : page
      collection : page.getElements()
    }


  editElement: (pageId, id) ->
    page = @site.getPages().get(pageId)
    element = page.getElements().get(id)
    nodeName = element.getNodeName()

    view = if nodeName== "p"
        new ParagraphElementEdit {
          el : @el.empty()
          model : element
        }
      else if nodeName == "h1"
        new HeaderElementEdit {
          el : @el.empty()
          model : element
        }
      else if nodeName == "div" and element.getComponent == "img"
        new ImageElementEdit {
          el : @el.empty()
          model : element
        }
      else if nodeName == "div"
        new ComponentElementEdit {
          el : @el.empty()
          model : element
        }

    @setView view

@Router = Router
