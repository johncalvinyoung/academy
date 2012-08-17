##= require ./Drawable
window.Rectangle = class Rectangle extends Drawable
	constructor: (@x, @y, @l, @h, @fill = false, @properties={}) ->
		@_draggable = false
	x: -> return @x
	y: -> return @y
	_draw: (context) ->
		if @fill == true
			context.fillRect(@x,@y,@l,@h)
		else
			context.strokeRect(@x,@y,@l,@h)
	contains: (point) ->
		xContains = (point.x() >= @x && point.x() <= @x+@l)
		yContains = (point.y() >= @y && point.y() <= @y+@h)
		return (xContains && yContains)
	draggable: ->
		return @_draggable

