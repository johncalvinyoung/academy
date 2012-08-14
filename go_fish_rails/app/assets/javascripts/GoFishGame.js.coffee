window.GoFishGame = class GoFishGame
	constructor: (names) ->
		@deck = new DeckOfCards()
		@players = new Array()
		@currentPlayer
		for name in names
			@players.push(new GoFishPlayer(name))
		
	deal: ->
		@deck.shuffle()
		for player in @players
			for n in [1..5]
				player.hand.push(@deck.draw())
	start: ->
		@currentPlayer = @players[0]
	score: ->
		scores = new Array()
		for player in @players
			scores.push(player.books.length)
		maxScore = Math.max.apply( Math, scores )
		if scores.filter((s)->s==maxScore).length >1
			return @players.filter((p) -> p.books.length == maxScore)
		else
			return @players[scores.indexOf(maxScore)]
		
