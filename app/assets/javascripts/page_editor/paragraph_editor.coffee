class ParagraphEditor extends ElementEditor
  initialize: ->
    @template = $("script#paragraph-edit").html()
    @render()

  focus: ->
    p = @$(".editing-field *")[0]
    s = window.getSelection()
    r = document.createRange()
    r.setStart(p, 0)
    r.setEnd(p, 0)
    s.removeAllRanges()
    s.addRange(r)

  getSelection: ->
    sel = window.getSelection()
    container = document.createElement("div")
    if rangeCount = sel.rangeCount
      rangeCount--
      for i in [0..rangeCount]
        container.appendChild(sel.getRangeAt(i).cloneContents())
    container.innerHTML

  render: ->
    @$el.html @template
    @$(".editing-field").html(@model.get('content')).children().attr('contenteditable', true)
    @delegateEvents()
    setTimeout( =>
      @focus()
    , 100)

  events: {
    "click .save" : 'onSave'
    'click .delete' : 'onDelete'
    "click .bold " : 'onBold'
    "click .italic" : 'onItalic'
    "click .createlink" : 'onCreateLink'
    "keypress .editing-field" : 'onKeypress'
  }

  onKeypress: (e) =>
    # this is mankychops
    if e.keyCode==13
      e.preventDefault()
      selection = window.getSelection()
      range = selection.getRangeAt(0)
      br = document.createElement("br")
      textNode = document.createTextNode("\u00a0"); # Passing " " directly will not end up being shown correctly
      range.deleteContents() # required or not?
      range.insertNode(br)
      range.collapse(false)
      range.insertNode(textNode)
      range.selectNodeContents(textNode)
      selection.removeAllRanges()
      selection.addRange(range)
      return true

  disableEditable: ->
    @$(".editing-field > *").removeAttr('contenteditable')
    
  onSave: =>
    @disableEditable()
    @model.set { content : @$(".editing-field").html() }
    @save()

  onBold: =>
    document.execCommand("bold", false)

  onItalic: =>
    document.execCommand("italic", false)

  onCreateLink: =>
    if @getSelection().match /<a/
      document.execCommand("unlink", false, false)
    else if url = prompt("Enter URL to link to")
      document.execCommand("createlink", false, url)
    else
      # do nothing?
@ParagraphEditor = ParagraphEditor