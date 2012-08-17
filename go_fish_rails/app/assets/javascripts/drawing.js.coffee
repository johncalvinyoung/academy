##= require ./Drawable

$ ->
	canvas = document.getElementById('drawing')
	if canvas
		drawing = new Drawing(canvas)
		drawing.game = new GoFishGame(["John", "Caleb", "Matthew", "Samuel"])
		drawing.game.deal()
		drawing.game.currentPlayer = drawing.game.players[2]
		drawing.init()
		drawing.figures.push(new Text(400,300,"Please click anywhere to start a game."))
		drawing.paint()

window.Drawing = class Drawing extends Drawable
	constructor: (@canvas) ->
		@properties =
			lineWidth: 2
			fillStyle: 'black'
			strokeStyle: 'yellow'
			font: '20pt Gill Sans'
			textAlign: 'center'
		circle1 = new Circle(140,150,50,{fillStyle: 'green'})
		circle2 = new Circle(20,50,30)
		circle2._draggable = true
		@figures = []
		@images = []
		@initializeMouseObservers() if @canvas
		@mouseOffset = [0,0]
		@game

	init: (context = @canvas.getContext('2d')) ->
		@render()
		for image in @images
			image.onload = ->
				context.drawImage(image[0],image[1],image[2])

	toJSON: ->
		{drawing: "#{@images.length}"}

	paint: (context = @canvas.getContext('2d'))=>
		context.clearRect(0,0,$(@canvas).width(), $(@canvas).height())
		@draw(context)

	_draw: (context) ->
		for figure in @figures
			figure.draw(context)
		for image in @images
			context.drawImage(image[0],image[1],image[2])

	mouseMove: (point) ->
		if @selectedFigure
			@selectedFigure.x = point.x() - @mouseOffset.x()
			@selectedFigure.y = point.y() - @mouseOffset.y()
			if @canvas
				context = @canvas.getContext('2d')
				context.clearRect(0,0,$(@canvas).width(), $(@canvas).height())
				@paint(context)

	mouseUp: (point) ->
		@selectedFigure = null
		@mouseOffset = new Point(0,0) #[0,0]

	contains: (point,pointA,pointB) ->
		handX = (point.x() >= pointA.x()  && point.x() <= pointB.x())
		handY = (point.y() >= pointA.y() && point.y() <= pointB.y())
		return (handX && handY)

	mouseDown: (point) ->
		if @game.currentPlayer == @game.players[0]
			if @contains(point, new Point(200,400), new Point(600,500))
				figureArray = Object.create(@figures).filter((element)->
					return (element instanceof CardImage))
				for figure in figureArray
					if (figure.contains(point))
						@selectedCard = figure
						@game.players[0].decision[1] = @selectedCard.rank

			# this checks if you click on any user's name
			if @contains(point, new Point(0,200), new Point(120,400))
				@game.players[0].decision[0] = @game.players[1]
			if @contains(point, new Point(200,0), new Point(600,100))
				@game.players[0].decision[0] = @game.players[2]
			if @contains(point, new Point(660,200), new Point(800,400))
				@game.players[0].decision[0] = @game.players[3]

		#if ((@game.players[0].decision[0] instanceof GoFishPlayer) && (@game.players[0].decision[1] != undefined))
		#	alert("You have set your decision: "+@game.players[0].decision[0].name+" & "+@game.players[0].decision[1]+" Click to play on.")
		
		@game.messages = ""
		@playGame()
		@paint()
		

		#for figure in @figures
		#	if (figure.contains(point) && figure.draggable() == true)
		#		@selectedFigure = figure
		#		@mouseOffset = new Point(point.x() - figure.x, point.y() - figure.y)
		#if @canvas
		#	context = @canvas.getContext('2d')
		#	context.clearRect(0,0,$(@canvas).width(), $(@canvas).height())
		#	@paint(context)
			#postUrl = $(@canvas).data('save')
			#$.post(postUrl, @toJSON())
			#context.fillRect(point.x()-5,point.y()-5,10,10)

	initializeMouseObservers: ->
		$(@canvas).on("mousedown", @mousedown_event)
		$(@canvas).on("mousemove", @mousemove_event)
		$(@canvas).on("mouseup", @mouseup_event)
	
	mousedown_event: (event) =>
		@mouseDown(@mousePosition(event))

	mousemove_event: (event) => @mouseMove(@mousePosition(event))

	mouseup_event: (event) => @mouseUp(@mousePosition(event))

	mousePosition: (event) ->
		offset = $(@canvas).offset()
		point = new Point(event.clientX-offset.left, event.clientY-offset.top)

	render: ->
		@figures = []
		@images = []
		starting = new Point(200, 400)
		@figures.push(new Text(400,550,@game.players[0].name+" ("+@game.players[0].books.length+")"))
		hand = @game.players[0].hand.sort((a,b)->
			return a.value() - b.value())
	
		for card in hand
			#img = new Image()
			#img.src = './assets/cards/'+card.suit().toLowerCase()+card.rank().toLowerCase()+'.png'
			#@images.push([img,starting.x(),starting.y()])
			@figures.push(new CardImage(starting.x(),starting.y(),card.rank(),card.suit()))
			starting = new Point(starting.x()+20,starting.y())

		starting = new Point(120, 200)
		@figures.push(new Text(60,300,@game.players[1].name+"\n("+@game.players[1].books.length+")"))
		for card in @game.players[1].hand
			@figures.push(new CardImage(starting.x(),starting.y(),card.rank(),card.suit(),false))
			starting = new Point(starting.x(),starting.y()+20)

		starting = new Point(200, 80)
		@figures.push(new Text(400,40,@game.players[2].name+" ("+@game.players[2].books.length+")"))
		for card in @game.players[2].hand
			@figures.push(new CardImage(starting.x(),starting.y(),card.rank(),card.suit(),false))
			starting = new Point(starting.x()+20,starting.y())

		starting = new Point(600, 200)
		@figures.push(new Text(740,300,@game.players[3].name+"\n("+@game.players[3].books.length+")"))
		for card in @game.players[3].hand
			@figures.push(new CardImage(starting.x(),starting.y(),card.rank(),card.suit(),false))
			starting = new Point(starting.x(),starting.y()+20)

		@figures.push(new Text(400,200,@game.messages, {font: "12pt Gill Sans"}))
		@figures.push(new Text(100,40,"Deck: "+@game.deck.numberOfCards()))
		#alert(@game.players[0].decision[0].name)
		#@figures.push(new Text(700,40,"test"+@game.players[0].decision[1]))
		#@figures.push(new Circle(300, 450,20))
		if @turn == true
			@figures.push(new Text(400, 350, "Please click on a card and a player", {font: "12pt Gill Sans"}))
			#@figures.push(@selectedCard) unless @selectedCard == undefined
			@figures.push(new Rectangle(@selectedCard.x,@selectedCard.y,71,96)) unless @selectedCard == undefined
			@selectedCard == undefined
			

	renderEnd: ->
		@images = []
		@figures = []
		document.getElementById('title').innerHTML = "Hope you enjoyed playing Go Fish!"
		@figures.push(new Text(400,250,"GAME OVER"))
		y = 280
		if (@winners instanceof Array)
			@figures.push(new Text(400,y, "Winners: "))
			y += 24
			for winner in @winners
				@figures.push(new Text(400, y, winner.name))
				y += 24
		else
			@figures.push(new Text(400,y,"Winner: "))
			y += 24
			@figures.push(new Text(400, y, @winners.name))

	playGame: ->
		if @game.end() == false
			if @game.currentPlayer.name != @game.players[0].name
				currentPlayer = @game.currentPlayer
				opponents = currentPlayer.opponents()
				
				@turn = false
				rand = Math.floor(Math.random()*3)
				opponent = opponents[rand]
				rank = currentPlayer.searchForTopRank()
				currentPlayer.decision = [opponent, rank]
				@game.currentPlayer = currentPlayer.takeTurn()
				setTimeout(=>
					@game.messages = ""
					@playGame()
					@paint()
				,1000)
			else
				@turn = true
				currentPlayer = @game.currentPlayer
				if ((currentPlayer.decision[0] instanceof GoFishPlayer) && (currentPlayer.decision[1] != undefined))
					@game.currentPlayer = currentPlayer.takeTurn()
					if @game.currentPlayer != @game.players[0]
						# unset turn-only variables and queue up the refresh
						@turn = false
						@selectedCard = undefined
						setTimeout(=>
							@game.messages = ""
							@playGame()
							@paint()
						,1000)
			@render()
		else
			@winners = @game.score()
			@renderEnd()
