# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Router extends Backbone.Router
  routes : {
    "" : "pageList"
    "page/new" : "newPage"
    "page/:page" : "editPage"
    "page/:page/edit/:element" : "editElement"
  } 

  initialize: (pages) ->
    @pages = pages
    @el = $('.container')

  showSpinner: ->
    @el.empty().html("<center class='spinner'>Loading yo...</center>")

  pageList: ->
    new PageList {
      el : @el.empty()
      collection : @pages
    }

  newPage: ->
    page = new Page { title : 'New Page' }

    new PageDetails {
      el : @el.empty()
      model : page
    }

  editPage: (id) ->
    page = @pages.get(id)

    new PageEditor { 
      el : @el.empty()
      model : page
      collection : page.getElements()
    }

  editElement: (pageId, elementCid) ->
    new ElementEditor {
      el : @el.empty()
      model : @pages.get(pageId).getElements().get(elementCid)
    }

@Router = Router

class PageElement extends Backbone.Model
  getNodeName : ->
    @getNode().nodeName.toLowerCase()

  getNode: ->
    $(@get('content'))[0]

  setInnerContent: (html) ->
    @set {
      content : "<#{@getNodeName()}>#{html}</#{@getNodeName()}>"
    }

  getPage: ->
    router.pages.get(@get('page_id'))

  destroy: ->
    @getPage().getElements().remove(this)

@PageElement = PageElement

class PageElementCollection extends Backbone.Collection
  model: PageElement

  getByUUID: (uuid) ->
    @find (el) -> el.get('uuid') == uuid

  comparator: (a,b) ->
    if a.get('position') < b.get('position')
      -1
    else if a.get('position') == b.get('position')
      0
    else
      1

@PageElementCollection = PageElementCollection

class Page extends Backbone.Model
  url : 'pages'

  getElements: ->
    @elements ||= @_parseElements()

  _parseElements: ->
    if @get('elements') && !_.isEmpty(@get('elements'))
      array = for element in @get('elements')
        new PageElement element
      new PageElementCollection(array)
    else
      new PageElementCollection

  autoPath: ->
    @get('title').toLowerCase().replace(/[^a-z0-9\-_]+/,'-')

  toJSON: ->
    {
      id : @get('id')
      title : @get('title')
      position : @get('position')
      elements : @getElements().toJSON()
    }
  # save: ->
  #   $.ajax {
  #     data : json

  #   }
  #   alert 'eh.'
@Page = Page

class PageCollection extends Backbone.Collection
  model : Page

  comparator: (a,b) ->
    if a.get('position') < b.get('position')
      -1
    else if a.get('position') == b.get('position')
      0
    else
      1

@PageCollection = PageCollection

class ElementEditor extends Backbone.View
  initialize: ->
    @template = $("script#element-edit").html()
    @render()

  focus: ->
    p = @$(".editing-field > *:first")[0]
    s = window.getSelection()
    r = document.createRange()
    r.setStart(p, 0)
    r.setEnd(p, 0)
    s.removeAllRanges()
    s.addRange(r)

  render: ->
    @$el.html @template
    @$(".toolbar").css {
      top : $(window).height() - @$(".toolbar").height() - 320 # todo detect the keyboard size
    }
    @$(".editing-field").html(@model.get('content'))
    @focus()
    @delegateEvents()

    if @model.getNodeName() != "p"
      @$(".toolbar button + button + button").hide()

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


  onSave: =>
    @model.set { content : @$(".editing-field").html() }
    @save()

  save: ->
    @model.getPage().save {}, {
      success : =>
        window.location.hash = "page/#{@model.getPage().id}"
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



# @editor = $("<div />").addClass("editor").html().appendTo $(".container")
# @editor.find(".editing-field").html(el.html())

# @focus(@editor.find(".editing-field")[0])


# @editor.find(".toolbar").find('.save').click (e) =>

# @editor.find(".toolbar").find('[data-action]').click (e) =>
#   el = $(e.currentTarget)
#   action = el.attr("data-action")

#   if action == "createlink"
#     document.execCommand("createlink", false, "http://blah/")
#   else
#     document.execCommand(action, false)

# class Editor
#   constructor: ->
#     @page = $(".page")

#     window.scrollTo(0,1)

#     # @page.children().attr("contenteditable", true)
#     @page.sortable({
#       axis : 'y'
#     }).disableSelection()
#     @page.children().doubleTap(@onDblClick)    

#     # for x in @page.children()
#     #   @addEditor($(x))

#   addEditor: (el) ->
#     overlay = $("<div />").addClass("overlay").appendTo @page

#     overlay.attr('el', el)

#     position = el.offset()

#     overlay.css {
#       left : position.left + 10
#       top : position.top - @page.offset().top + 2
#       width : $(document).width() - 20
#       height : el.height() - 4
#     }

#     overlay.click (e) =>
#       @onClick(el, overlay)

#   onClick: (el, overlay) ->
#     $("<input type='text'")

#   showEditor: (el) ->
#     $(".page-view").hide()

#     new RichTextEditor { 
#       el : $("<div />").appendTo(".container")
#       model : new PageElement { id : el.id, content : "<" + el[0].nodeName + ">" + el.html() + "</" + el[0].nodeName + ">" }
#     }

# @Editor = Editor