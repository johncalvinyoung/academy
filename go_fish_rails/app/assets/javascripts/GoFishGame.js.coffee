window.GoFishGame = class GoFishGame
	constructor: (names) ->
		@deck = new DeckOfCards()
		@players = new Array()
		@messages = ""
		@currentPlayer
		for name in names
			@players.push(new GoFishPlayer(name, this))
		
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
	end: ->
		for player in @players
			if player.hand.length == 0
				return true
		if @deck.numberOfCards() == 0
			return true
		else
			return false
	addMessage: (message) ->
		console.log(message)
		@messages += message+"\n"
	checkMessages: ->
		message = @messages
		@messages = ""
		return message

