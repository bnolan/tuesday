class ParagraphElementEdit extends ElementEdit
  initialize: ->
    @template = $templates.editorsParagraph
    @render()

  render: ->
    @$el.html @template(@)

    # @$(".toolbar").css {
    #   top : $(window).height() - @$(".toolbar").height() - 260 # todo detect the keyboard size
    # }

    @$(".editing-field").children().attr('contenteditable', true)

    @delegateEvents()

    setTimeout( =>
      @focus()
    , 100)

    if @model.getNodeName() != "p"
      @$(".toolbar button + button + button").hide()

  focus: ->
    p = @$(".editing-field *")[0]
    s = window.getSelection()
    r = document.createRange()
    r.setStart(p, 0)
    r.setEnd(p, 0)
    s.removeAllRanges()
    s.addRange(r)

  events: {
    "click .save" : 'onSave'
    'click .delete' : 'onDelete'
    "click .bold " : 'onBold'
    "click .italic" : 'onItalic'
    "click .createlink" : 'onCreateLink'
    "keypress .editing-field" : 'onKeypress'
  }

  onKeypress: (e) =>
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

  onBold: ->
    document.execCommand("bold", false)

  onItalic: ->
    document.execCommand("italic", false)

  onCreateLink: ->
    url = prompt("Enter url for link...")

    if url
      if url.match(/\:\/\//)
        document.execCommand("createlink", false, url)
      else
        alert "Please enter a complete url including http://..."

@ParagraphElementEdit = ParagraphElementEdit