class ElementEdit extends Backbone.View
  save: ->
    @model.getPage().save {}, {
      success : =>
        window.location.hash = "pages/#{@model.getPage().id}"
      error: =>
        alert "COULDNT SAVE YO"
    }

  destroy: ->
    @model.destroy()
    @save()


@ElementEdit = ElementEdit