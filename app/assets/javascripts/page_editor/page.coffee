class Page extends Backbone.Model
  url : ->
    '/sites/' + router.site.id + '/pages/'

  getElements: ->
    @elements ||= @_parseElements()

  _parseElements: ->
    doc = $("<div>" + @get('content') + "</div>")
    # doc = $("<div><h1>Something</h1><p>New page...</p></div>")

    index = 0

    array = for element in doc.children()
      new PageElement { 
        content : $('<div>').append($(element).clone().removeAttr('contenteditable')).html()
        position : ++index
        page_id : @id
      }

    new PageElementCollection(array)
    # if @get('elements') && !_.isEmpty(@get('elements'))
    # else
    #   new PageElementCollection

  getElementsAsHtml: ->
    html = ''

    @getElements().each (el) ->
      html += el.get('content')

    console.log html

    html

  autoPath: ->
    @get('title').toLowerCase().replace(/[^a-z0-9\-_]+/g,'-')

  toJSON: ->
    {
      id : @get('id')
      title : @get('title')
      position : @get('position')
      content : @getElementsAsHtml()
      path : @get('path')
    }

@Page = Page


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