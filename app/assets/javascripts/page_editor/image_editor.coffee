class ImageEditor extends ElementEditor
  initialize: ->
    @template = $("script#image-edit").html()
    @src = $(@model.get('content')).attr('src')
    @render()

  events: {
    "click .save" : 'onSave'
    'click .delete' : 'onDelete'
  }

  setSrc: (src) ->
    @src = src
    @$("img").attr('src', @src)

  render: ->
    @$el.html @template
    @$("img").attr('src', @src)
    @$('input[type=file]').on 'change', @doUpload
    @delegateEvents()

  doUpload: (e) =>
    data = new FormData()
    $.each e.target.files, (key, value) -> data.append('image[image]', value)

    $.ajax {
      url : @$("form").attr("action") # /sites/#{router.site.id}/images"
      type : 'POST'
      data : data
      cache : false
      dataType : 'json'
      processData : false
      contentType: false
      success: (data, textStatus, jqXHR) =>
        console.log "Woo!"
        # console.log textStatus

        @setSrc(data.image)

      error: =>
        console.log "booo!"
    }


  getContent: ->
    "<img src='#{@src}' />" # <img src='#{@nodeName}>" + @$("input").val() + "</#{@nodeName}>"

  onSave: =>
    @model.set { content : @getContent() }
    @save()

@ImageEditor = ImageEditor
