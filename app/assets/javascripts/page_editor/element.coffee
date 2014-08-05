class PageElement extends Backbone.Model
  getNodeName : ->
    @getNode().nodeName.toLowerCase()

  getText: ->
    $(@get('content')).text()

  isParagraph: ->
    @getNodeName() == "p"

  isHeading: ->
    @getNodeName()[0] == "h"

  isImage: ->
    @getNodeName() == "img"

  getNode: ->
    $(@get('content'))[0]

  setInnerContent: (html) ->
    @set {
      content : "<#{@getNodeName()}>#{html}</#{@getNodeName()}>"
    }

  getPage: ->
    router.page

  destroy: ->
    @getPage().getElements().remove(this)

@PageElement = PageElement

class PageElementCollection extends Backbone.Collection
  model: PageElement

  comparator: (a,b) ->
    if a.get('position') < b.get('position')
      -1
    else if a.get('position') == b.get('position')
      0
    else
      1

@PageElementCollection = PageElementCollection
