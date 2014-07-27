class PageElementCollection extends Backbone.Collection
  model: PageElement

  comparator: (a,b) ->
    if a.get('position') < b.get('position')
      -1
    else if a.get('position') == b.get('position')
      0
    else
      1

@PageElementCollection = PageElementCollection