class PageEditor extends Backbone.View
  initialize: ->
    @template = $("script#page-edit").html()
    @render()

  render: ->
    @$el.html @template

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

    @$(".page-name").text(@model.get('title'))
    @$(".page-path").text('/' + @model.get('path'))

    @delegateEvents()

    div.children().click(@onDblClick)

  events: {
    "click .home" : 'onHome'
    "click .addElement" : 'onAddElement'
    "click .paragraph" : 'onAddParagraph'
    "click .heading" : 'onAddHeading'
    "click .image" : 'onAddImage'
  }

  onHome: ->
    window.location.hash = "#"

  onAddElement: ->
    @$(".subtoolbar").toggle()

  onAddParagraph: ->
    @addElement("<p>Your content goes here...</p>")

  onAddHeading: ->
    @addElement("<h1>Heading</h1>")

  onAddImage: ->
    @addElement("<img src='/imagenotfound.png' />")

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

    window.location.hash = "elements/#{el.cid}/edit"

  onDblClick: (e) =>
    el = $(e.currentTarget)
    window.location.hash = "elements/#{el.attr('data-cid')}/edit"

@PageEditor = PageEditor
