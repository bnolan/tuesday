class ElementEditor extends Backbone.View
  # These aren't inherited, add something here and you have to copy paste it below, just so you know
  events: {
    "click .save" : 'onSave'
    'click .delete' : 'onDelete'
  }
  
  save: ->
    @model.getPage().save {}, {
      success : =>
        window.location.hash = ""
      error: =>
        alert "COULDNT SAVE YO"
    }

  onDelete: ->
    @model.destroy()
    @save()

@ElementEditor = ElementEditor