describe "Go Fish Game", ->
	beforeEach -> @game = new GoFishGame(["John","Susanna","Simon","Rosie"])

	it "has players", ->
		expect(@game.players.length == 4).toBe(true)
		expect(@game.players[0] instanceof GoFishPlayer).toBe(true)

	it "has a deck", ->
		expect(@game.deck instanceof DeckOfCards).toBe(true)
	
	it "deals cards to players", ->
		@game.deal()
		expect(@game.players[0].hand.length).toBe(5)
		expect(@game.deck.numberOfCards()).toBe(32)

	it "sets the current player upon command", ->
		@game.deal()
		@game.start()
		expect(@game.currentPlayer == @game.players[0]).toBe(true)

describe "scoring", ->
	beforeEach ->
		@game = new GoFishGame(["John","Susanna","Simon","Rosie"])
		@game.deal()
		@game.start()

	it "returns a single winner upon command", ->
		@game.players[0].books.push(new Book("Q"))
		winner = @game.score()
		expect(winner == @game.currentPlayer).toBe(true)
	
	it "returns an array of tied winners", ->
		@game.players[1].books.push(new Book("K"))
		@game.players[3].books.push(new Book("3"))
		winner = @game.score()
		expect(winner[0] == @game.players[1]).toBe(true)
		expect(winner[1] == @game.players[3]).toBe(true)
