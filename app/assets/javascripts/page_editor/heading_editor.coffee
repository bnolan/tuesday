class HeadingEditor extends ElementEditor
  initialize: ->
    @template = $("script#heading-edit").html()
    @nodeName = @model.getNodeName()
    @render()

  events: {
    "click .save" : 'onSave'
    'click .delete' : 'onDelete'
    'change select' : 'onSelect'
  }

  onSelect: ->
    @nodeName = @$("select").val()

  focus: ->
    @$("input").focus()

  render: ->
    @$el.html @template
    @$("input").val(@model.getText())
    @$("select").val(@nodeName)
    @delegateEvents()
    @focus()

  getContent: ->
    "<#{@nodeName}>" + @$("input").val() + "</#{@nodeName}>"

  onSave: =>
    @model.set { content : @getContent() }
    @save()

@HeadingEditor = HeadingEditor
