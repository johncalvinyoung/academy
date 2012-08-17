describe "Point", ->
	beforeEach ->
		@point = new Point(50,60)

	it "should have an x and y", ->
		expect(@point.x()).toBe(50)
		expect(@point.y()).toBe(60)

	it "should return a new point offset by another point", ->
		offsetPoint = @point.offsetBy(new Point(2,2))
		expect(offsetPoint.x()).toBe(52)
		expect(offsetPoint.y()).toBe(62)

	it "should return a new point offset by a number in both x and y", ->
		offsetPoint = @point.offsetBy(4,6)
		expect(offsetPoint.x()).toBe(54)
		expect(offsetPoint.y()).toBe(66)
