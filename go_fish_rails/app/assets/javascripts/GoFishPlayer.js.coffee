window.GoFishPlayer = class GoFishPlayer
	constructor: (@name, game) ->
		@hand = new Array()
		@books = new Array()
		@decision = new Array(2)
		@game = game

	opponents: =>
		return @game.players.filter((element)=> 
			return (element.name != @name))

	give: (searchRank) ->
		requested = new Array()
		for n in [0..@hand.length-1]
			if @hand[n].rank() == searchRank
				requested.push(@hand[n])
		@hand = @hand.filter((element) ->
			return (element.rank() != searchRank))
		return requested
	numberOfCards: -> return @hand.length
	checkForBooks: ->
		cardRanks = new Array()
		ranks = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
		for rank in ranks
			cardRanks[rank] = 0
		for card in @hand
			cardRanks[card.rank()] += 1
		for rank,value of cardRanks
			if value == 4
				@books.push(new Book(rank))
				@game.addMessage(@name+" added a book of "+rank+"s!")
				@hand = @hand.filter((element) ->
					return (element.rank() != rank))
	searchForTopRank: ->
		ranks = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
		cardRanks = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
		for card in @hand
			cardRanks[card.value()] += 1
		cardMax = Math.max.apply( Math, cardRanks)
		rankIndex = cardRanks.indexOf(cardMax)
		return ranks[rankIndex-2]

	takeTurn: =>
		opponent = @decision[0]
		rank = @decision[1]
		nextPlayer = @
		cards = opponent.give(rank)
		@game.addMessage(@name+" asked "+opponent.name+" for "+rank+"s.")
		if cards.length > 0
			for card in cards
				@hand.push(card)
			@game.addMessage(@name+" received cards from "+opponent.name)
		else
			card = @game.deck.draw()
			if card != undefined
				@game.addMessage("Go Fish!")
				@hand.push(card)
				if card.rank() != rank
					nextPlayer = opponent
		@checkForBooks()
		@decision = []
		return nextPlayer
	
