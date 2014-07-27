class ElementEditor extends Backbone.View
  initialize: ->
    @template = $("script#element-edit").html()
    @render()

  focus: ->
    p = @$(".editing-field *")[0]
    s = window.getSelection()
    r = document.createRange()
    r.setStart(p, 0)
    r.setEnd(p, 0)
    s.removeAllRanges()
    s.addRange(r)

  render: ->
    @$el.html @template
    @$(".toolbar").css {
      top : $(window).height() - @$(".toolbar").height() - 260 # todo detect the keyboard size
    }
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

  save: ->
    console.log "saving #{@model.cid}"

    @model.getPage().save {}, {
      success : =>
        window.location.hash = ""
      error: =>
        alert "COULDNT SAVE YO"
    }

  onDelete: ->
    @model.destroy()
    @save()

  onBold: ->
    document.execCommand("bold", false)

  onItalic: ->
    document.execCommand("italic", false)

  onCreateLink: ->
    document.execCommand("createlink", false, "http://googs/")

@ElementEditor = ElementEditor