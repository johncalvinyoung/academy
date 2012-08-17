##= require ./Drawable

window.Circle = class Circle extends Drawable
	constructor: (@x, @y, @radius, @properties={}) ->
		@_draggable = false
	x: -> return @x
	y: -> return @y
	_draw: (context) ->
		context.beginPath()
		context.arc(@x,@y,@radius,0,Math.PI*2,true)
		context.closePath()
		context.fill()
		context.stroke()
	contains: (point) ->
		dX = (point.x() - @x)^2
		dY = (point.y() - @y)^2
		distance = Math.sqrt(dY*dY+dX*dX)
		#document.getElementById('banner').innerHTML = dX+" "+dY+" "+distance
		return (distance <= @radius)
	draggable: ->
		return @_draggable
