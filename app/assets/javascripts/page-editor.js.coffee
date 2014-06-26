class PageEditor extends Backbone.View
  initialize: ->
    @template = $("script#page-edit").html()
    @render()

  render: ->
    @$el.html @template

    div = @$(".page")

    @collection.each (element) =>
      $(element.get('content')).attr('data-cid', element.cid).appendTo div

    div.sortable({
      axis : 'y'
      stop: ( e, ui ) =>
        # resort the pages
        index = 0
        
        for el in @$(".page").children()
          @collection.get($(el).attr('data-cid')).set {
            position : ++index
          }

        @collection.sort()

        @model.save()

    }).disableSelection()

    @delegateEvents()

    div.children().doubleTap(@onDblClick)

  events: {
    "click .home" : 'onHome'
    "click .addElement" : 'onAddElement'
    "click .paragraph" : 'onParagraph'
    "click .heading" : 'onHeading'
  }

  onHome: ->
    window.location.hash = "#"

  onAddElement: ->
    @$(".subtoolbar").toggle()

  onParagraph: ->
    @addElement("<p>Your content goes here...</p>")

  onHeading: ->
    @addElement("<h1>Heading</h1>")

  addElement: (html) ->
    position = if @collection.isEmpty()
        1
      else
        @collection.last().get('position') + 1 
    
    el = new PageElement { 
      position : position
      page_id : @model.id
      content : html
    }

    @collection.add(el)

    window.location.hash = "pages/#{@model.id}/edit/#{el.cid}"

  onDblClick: (e) =>
    el = $(e.currentTarget)
    window.location.hash = "pages/#{@model.id}/edit/#{el.attr('data-cid')}"

@PageEditor = PageEditor