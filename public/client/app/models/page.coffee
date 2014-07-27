class Page extends Backbone.Model
  url : ->
    "http://#{app.domain}/sites/#{@getSite().id}/pages/"

  getSite: ->
    @site

  setSite: (site) ->
    @site = site

  getPath: ->
    @get('path')

  getSnippet: ->
    $(@get("content")).text().slice(0,50) + "..."

  getElements: ->
    @elements ||= @_parseElements()

  _parseElements: ->
    doc = $("<div>" + @get('content') + "</div>")

    index = 0

    array = for element in doc.children()
      el = new PageElement { 
        content : $('<div>').append($(element).clone().removeAttr('contenteditable')).html()
        position : ++index
      }
      el.setPage(@)
      el

    new PageElementCollection(array)

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