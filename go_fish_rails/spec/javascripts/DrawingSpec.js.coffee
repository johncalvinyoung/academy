describe "Drawing", ->
	beforeEach ->
		@drawing = new Drawing(null)
		@drawing.figures.push(new Circle(50,50,20))
		@drawing.figures[0]._draggable = true
		
#	it "should detect if we click inside a figure", ->
#		circle = @drawing.figures[0]
#		centerX = circle.x
#		centerY = circle.y
#		click = new Point(centerX, centerY)
#		@drawing.mouseDown(click)
#		#@drawing.mouseMove(new Point(centerX+10, centerY+5))
#		expect(circle.contains(click).toBe(true)
