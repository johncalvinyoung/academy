GoFishPlayer = function GoFishPlayer(name){
	this.name = name;
	this.hand = new Array();
	this.books = new Array();
	this.decision = new Array(2);
}

GoFishPlayer.prototype = {
	numberOfCards: function(){
		return this.hand.length;
	},
	give: function(searchRank){
		var requested = new Array();
		var card;
		for(var i=0; i<this.hand.length; i++){
			if(this.hand[i].rank()==searchRank){
				card = this.hand.splice(i,1);
				i-=1;
				requested.push(card[0]);
			}
		}
		if (requested.length > 0){
			return requested;
		} else {
			return [];
		}
	},
	checkForBooks: function(){
		var cardRanks = new Array();
		var ranks = ["2","3","4","5","6","7","8","9","10","J","Q","K"];
		for(var i in ranks) {
			cardRanks[ranks[i]] = 0;
		}
		for(var i in this.hand) {
			cardRanks[this.hand[i].rank()] += 1;
		}

		for(var i in cardRanks) {
			if(cardRanks[i] == 4) {
				this.books.push(new Book(i));
				this.hand = this.hand.filter(function(element){
					return (element.rank() != i);
				});
			}
		}
	}
}
