class SiteCollection extends Backbone.Collection
  model : Site

  comparator: (a,b) ->
    if a.get('name') < b.get('name')
      -1
    else if a.get('name') == b.get('name')
      0
    else
      1

@SiteCollection = SiteCollection