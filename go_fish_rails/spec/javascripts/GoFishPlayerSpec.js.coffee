describe "Go Fish Player", ->
	beforeEach ->
		@player = new GoFishPlayer("John")

	it "has a name", ->
		expect(@player.name == "John").toBe(true)
	
	it "has a hand", ->
		expect(@player.hand instanceof Array).toBe(true)

	it "can report number of cards", ->
		expect(@player.numberOfCards()).toBe(0)
		@player.hand.push(new PlayingCard(7,"Spades"))
		expect(@player.numberOfCards()).toBe(1)

	it "will give you a card upon request", ->
		@player.hand.push(new PlayingCard(7,"Spades"))
		@player.hand.push(new PlayingCard(7,"H"))
		@player.hand.push(new PlayingCard(8,"H"))
		requested = @player.give("7")
		expect(requested[0].rank() == "7").toBe(true)
		expect(@player.numberOfCards()).toBe(1)

	it "stores an array of books", ->
		expect(@player.books.length).toBe(0)
	
	it "will check for books upon command", ->
		@player.hand.push(new PlayingCard("q","Spades"))
		@player.hand.push(new PlayingCard("Q","H"))
		@player.hand.push(new PlayingCard("J","H"))
		@player.hand.push(new PlayingCard("Q", "C"))
		@player.hand.push(new PlayingCard("q", "D"))
		@player.checkForBooks()
		expect(@player.books.length).toBe(1)
		expect(@player.hand.length).toBe(1)

	it "can store a decision", ->
		expect(@player.decision).not.toBe(undefined)
		expect(@player.decision instanceof Array)
	
	it "can determine the top rank in its hand", ->
		@player.hand.push(new PlayingCard("Q","H"))
		@player.hand.push(new PlayingCard("J","H"))
		@player.hand.push(new PlayingCard("Q", "C"))
		@player.hand.push(new PlayingCard("q", "D"))
		topRank = @player.searchForTopRank()
		expect(topRank).toBe("Q")

	describe "Player in Go Fish Game", ->
		beforeEach ->
			@game = new GoFishGame(["John", "Matt", "Sam", "Seth"])
			@player = @game.players[0]
			@game.deal()
			@game.start()

		it "stores a reference to the game", ->
			expect(@player.game instanceof GoFishGame).toBe(true)

		it "stores an array of opponents", ->
			opponents = @player.opponents()
			expect(opponents.length).toBe(3)
			expect(opponents[0] instanceof GoFishPlayer).toBe(true)

		it "can take a turn", ->
			@player.hand = []
			@player.hand.push(new PlayingCard("Q","H"))
			@player.hand.push(new PlayingCard("J","H"))
			@player.hand.push(new PlayingCard("Q", "C"))
			@player.hand.push(new PlayingCard("q", "D"))

			@game.players[2].hand = []
			@game.players[2].hand.push(new PlayingCard("2","S"))
			@game.players[2].hand.push(new PlayingCard("Q","S"))

			@player.decision = [@game.players[2], "Q"]
			nextPlayer = @player.takeTurn()
			expect(@player.books.length).toBe(1)
			expect(@player.hand.length).toBe(1)
			expect(@game.players[2].hand.length).toBe(1)
			expect(nextPlayer==@player).toBe(true)

		it "can take a turn that results in drawing a card", ->
			@player.hand = []
			@player.hand.push(new PlayingCard("Q","H"))
			@player.hand.push(new PlayingCard("J","H"))
			@player.hand.push(new PlayingCard("Q", "C"))

			@game.players[2].hand = []
			@game.players[2].hand.push(new PlayingCard("2","S"))
			@game.players[2].hand.push(new PlayingCard("K","S"))

			@player.decision = [@game.players[2], "Q"]
			nextPlayer = @player.takeTurn()
			expect(@game.deck.numberOfCards()).toBe(31)
			expect(@player.hand.length).toBe(4)
			expect(@game.players[2].hand.length).toBe(2)
			expect(nextPlayer==@game.players[2]).toBe(true)

		it "can take a turn that results in drawing a card successfully", ->
			@player.hand = []
			@player.hand.push(new PlayingCard("Q","H"))
			@player.hand.push(new PlayingCard("J","H"))
			@player.hand.push(new PlayingCard("Q", "C"))
			@player.hand.push(new PlayingCard("Q","S"))

			@game.players[2].hand = []
			@game.players[2].hand.push(new PlayingCard("2","S"))
			@game.players[2].hand.push(new PlayingCard("K","S"))

			@game.deck.cards.push(new PlayingCard("Q", "D"))

			@player.decision = [@game.players[2], "Q"]
			nextPlayer = @player.takeTurn()
			expect(@game.deck.numberOfCards()).toBe(32)
			expect(@player.hand.length).toBe(1)
			expect(@player.books.length).toBe(1)
			expect(@game.players[2].hand.length).toBe(2)
			expect(nextPlayer==@game.players[0]).toBe(true)
