window.Drawable = class Drawable
  constructor: ->
  draw: (context) ->
    @_saveAndSetProperties(context)
    @_draw(context)
    @_restoreProperties(context)

  _saveAndSetProperties: (context) ->
    context.save()
    for name, value of @properties
      context[name] = value

  _draw: (context) ->
    context.beginPath()
    context.arc(@x,@y,@radius,0,Math.PI*2,true)
    context.closePath()
    context.fill()
    context.stroke()

  _restoreProperties: (context) ->
    context.restore()
