class PageList extends Backbone.View
  initialize: ->
    @template = $templates.pagesList
    @render()

  render: ->
    @$el.html @template(@)

    # @$(".site-name").html(@model.get('name'))
    # @$(".site-subdomain").html(@model.get('subdomain') + ".tuesdayapp.com")

    # ul = @$(".page-list")

    # @collection.each (page) ->
    #   $("<li />").text(page.get('title')).attr('data-id', page.id).appendTo ul

    # ul.sortable({
    #   axis : 'y'
    #   stop: ( e, ui ) =>
    #     # resort the pages
    #     index = 0
        
    #     # for el in @$(".page > *")
    #     #   @collection.get($(el).attr('data-cid')).set {
    #     #     position : ++index
    #     #   }

    #     #   @model.save()

    # }).disableSelection()

    @delegateEvents()

  events: {
    'click .page-list li' : 'onClick'
    'click .addPage' : 'onAddPage'
  }

  onClick: (e) =>
    el = $(e.currentTarget)
    window.location.hash = "pages/" + el.attr('data-id')

  onAddPage: ->
    window.location.hash = "pages/new"

@PageList = PageList