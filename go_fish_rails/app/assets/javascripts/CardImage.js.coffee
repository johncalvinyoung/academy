##= require ./Drawable
window.CardImage = class CardImage extends Drawable
	constructor: (@x, @y, @rank, @suit, @visible = true, @properties={}) ->
		@_draggable = false
	x: -> return @x
	y: -> return @y
	rank: -> return @rank
	suit: -> return @suit
	_draw: (context) ->
		if @visible == true
			img = document.getElementById(@suit.toLowerCase()+@rank.toLowerCase())
		else
			img = document.getElementById("back")
		context.drawImage(img, @x, @y)
	contains: (point) ->
		xContains = (point.x() >= @x && point.x() <= @x+72)
		yContains = (point.y() >= @y && point.y() <= @y+96)
		return (xContains && yContains)
	draggable: ->
		return @_draggable
