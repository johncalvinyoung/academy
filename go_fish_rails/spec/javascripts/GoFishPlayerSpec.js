describe("Go Fish Player", function(){
	var player;

	beforeEach(function(){
		player = new GoFishPlayer("John");
	});

	it("has a name", function(){
		expect(player.name=="John").toBe(true);
	});

	it("has a hand", function(){
		expect(player.hand instanceof Array).toBe(true);
	});

	it("can report number of cards", function(){
		expect(player.numberOfCards()).toBe(0);
		player.hand.push(new PlayingCard(7,"Spades"));
		expect(player.numberOfCards()).toBe(1);
	});

	it("will give you a card upon request", function() {
		player.hand.push(new PlayingCard(7,"Spades"));
		player.hand.push(new PlayingCard(7,"H"));
		player.hand.push(new PlayingCard(8,"H"));
		var requested = player.give("7");
		expect(requested[0].rank() == "7").toBe(true);
		expect(player.numberOfCards()).toBe(1);
	});

	it("stores an array of books", function(){
		expect(player.books.length).toBe(0);
	});
	
	it("will check for books upon command", function(){
		player.hand.push(new PlayingCard("q","Spades"));
		player.hand.push(new PlayingCard("Q","H"));
		player.hand.push(new PlayingCard("J","H"));
		player.hand.push(new PlayingCard("Q", "C"));
		player.hand.push(new PlayingCard("q", "D"));
		player.checkForBooks();
		expect(player.books.length).toBe(1);
		expect(player.hand.length).toBe(1);
	});

	it("can store a decision", function(){
		expect(player.decision).not.toBe(undefined);
		expect(player.decision instanceof Array);
	});
});
