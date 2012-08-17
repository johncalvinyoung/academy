##= require ./Drawable
window.Point = class Point extends Drawable
	constructor: (@_x,@_y) ->
	x: -> return @_x
	y: -> return @_y
	offsetBy: (xOrPoint, y) ->
		if y == undefined
			if (xOrPoint instanceof Point)
				return @offsetBy(xOrPoint.x(), xOrPoint.y())
			else
				return @offsetBy(xOrPoint, xOrPoint)
		new Point(@x() + xOrPoint, @y() + y)

