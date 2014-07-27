class ElementList extends Backbone.View
  initialize: ->
    @template = $templates.elementsList
    @render()

  render: ->
    @$el.html @template(@)

    div = @$(".page")

    @collection.each (element) =>
      $(element.get('content')).attr('data-cid', element.cid).appendTo div

    # div.sortable({
    #   axis : 'y'
    #   stop: ( e, ui ) =>
    #     # resort the pages
    #     index = 0
        
    #     for el in @$(".page").children()
    #       @collection.get($(el).attr('data-cid')).set {
    #         position : ++index
    #       }

    #     @collection.sort()

    #     @model.save()

    # }).disableSelection()

    @delegateEvents()

  events: {
    "click .home" : 'onHome'
    "click .addElement" : 'onAddElement'
    "click .paragraph" : 'onParagraph'
    "click .heading" : 'onHeading'
    "click .image" : 'onImage'
    "click .snippet" : 'onSnippet'
    "click .page>*" : 'onClick'
  }

  onHome: ->
    window.location.hash = "#"

  onAddElement: ->
    @$(".subtoolbar").toggle()

  onParagraph: ->
    @addElement("<p>Your content goes here...</p>")

  onHeading: ->
    @addElement("<h1>Heading</h1>")

  onImage: ->
    if url = prompt("Enter URL to your image")
      @addElement("<img src='#{url}' />")

  onSnippet: ->
    alert "not implemented"

  addElement: (html) ->
    position = if @collection.isEmpty()
        1
      else
        @collection.last().get('position') + 1 
    
    el = new PageElement { 
      position : position
      content : html
    }

    el.setPage(@model)
    
    @collection.add(el)

    window.location.hash = "pages/#{@model.id}/elements/#{el.cid}/edit"

  onClick: (e) =>
    el = $(e.currentTarget)
    window.location.hash = "pages/#{@model.id}/elements/#{el.attr('data-cid')}/edit"

@ElementList = ElementList