class PageElement extends Backbone.Model
  getNodeName : ->
    @getNode().nodeName.toLowerCase()

  getNode: ->
    $(@get('content'))[0]

  setInnerContent: (html) ->
    @set {
      content : "<#{@getNodeName()}>#{html}</#{@getNodeName()}>"
    }

  getPage: ->
    @page

  setPage: (page) ->
    @page = page

  destroy: ->
    @getPage().getElements().remove(this)

@PageElement = PageElement
