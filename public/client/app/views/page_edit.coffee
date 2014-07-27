class PageEdit extends Backbone.View
  initialize: ->
    @template = $("script#page-details").html()
    @render()

  render: ->
    @$el.html @template

    ul = @$(".page-list")

    @$("[name='title']").val(@model.get('title'))
    @onTitleChange()

    @delegateEvents()

  events: {
    'click .save' : 'onSave'
    'click .delete' : 'onDelete'
    'keyup input' : 'onTitleChange'
  }

  onSave: ->
    @model.save {}, {
      success: =>
        window.location.hash = ""
        window.location.reload()

      error: =>
        alert "Unable to save your page"
    }

  onDelete: ->
    window.location.hash = ""

  onTitleChange: =>
    path = @model.autoPath()

    @model.set { 
      title : @$("[name='title']").val() 
      path : path
    }

    @$(".path").text(path)

@PageEdit = PageEdit