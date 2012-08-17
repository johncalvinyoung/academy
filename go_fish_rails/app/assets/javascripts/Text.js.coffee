window.Text = class Text extends Drawable
	constructor: (@x, @y, @string, @properties={}) ->
		@_draggable = false
	x: -> return @x
	y: -> return @y
	_draw: (context) ->
		#split idea from StackOverflow
		lines = @string.split('\n')
		y = @y
		for line in lines
			context.fillText(line, @x, y)
			context.fill()
			y+=24
	contains: (point) ->
		return false
	draggable: ->
		return @_draggable
