describe("Book", function() {
	var book;

	beforeEach(function() {
		book = new Book("5");
	});

	it("is of a certain rank", function(){
		expect(book.rank=="5").toBe(true);
	});
});
