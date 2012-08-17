function PlayingCard(rank,suit) {
	this._rank = rank.toString().toUpperCase();
	this._suit = suit.toUpperCase().slice(0,1);
	this.rank = function(){ return this._rank };
	this.suit = function(){ return this._suit };
}

PlayingCard.prototype = {
	toString: function() {
		return "[object PlayingCard: "+this.rank()+this.suit()+"]";
	},
	value: function() {
		var ranks = ["2","3","4","5","6","7","8","9","10","J", "Q", "K", "A"];
		return 2+ranks.indexOf(this.rank());
	}
}

function DeckOfCards() {
	this.cards = new Array();
	var ranks = ["2","3","4","5","6","7","8","9","10","J", "Q", "K", "A"];
	var suits = ["C","D","S","H"];

	for(var i=0; i< ranks.length; i++) {
		for (var j=0; j< suits.length; j++) {
			this.cards.push(new PlayingCard(ranks[i],suits[j]));
		}
	}
}

DeckOfCards.prototype = {
	numberOfCards: function() {
		return this.cards.length;
	},
	draw: function() {
		return this.cards.pop();
	},
	cards: function() {
		return this.cards;
	},
	shuffle: function() {
		//shuffle borrowed from dtm.livejournal.com
  	var i, j, t;
  	for (i = 1; i < this.cards.length; i++) {
    	j = Math.floor(Math.random()*(1+i));  // choose j in [0..i]
    	if (j != i) {
      	t = this.cards[i];                        // swap list[i] and list[j]
      	this.cards[i] = this.cards[j];
      	this.cards[j] = t;
    	}
  	}


	}
}
