class PageList extends Backbone.View
  initialize: ->
    @template = $("script#page-list").html()
    @render()

  render: ->
    @$el.html @template

    ul = @$(".page-list")

    @collection.each (page) ->
      $("<li />").text(page.get('title')).attr('data-id', page.id).appendTo ul

    ul.sortable({
      axis : 'y'
      stop: ( e, ui ) =>
        # resort the pages
        index = 0
        
        # for el in @$(".page > *")
        #   @collection.get($(el).attr('data-cid')).set {
        #     position : ++index
        #   }

        #   @model.save()

    }).disableSelection()

    @delegateEvents()

  events: {
    'click .page-list li' : 'onClick'
    'click .addPage' : 'onAddPage'
  }

  onClick: (e) =>
    el = $(e.currentTarget)
    window.location.hash = "page/" + el.attr('data-id')

  onAddPage: ->
    window.location.hash = "page/new"

@PageList = PageList