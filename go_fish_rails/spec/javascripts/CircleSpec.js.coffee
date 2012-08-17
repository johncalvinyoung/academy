describe 'Circle', =>
	beforeEach ->
		@circle = new Circle(100, 50, 20)
	it "should have expected center and radius", ->
		expect(@circle.radius).toBe(20)
		expect(@circle.x).toBe(100)
		expect(@circle.y).toBe(50)

	it "should contain relevant points", ->
		expect(@circle.contains(new Point(100,50))).toBe(true)
		#need to add further cases for other shapes	
