Book = function Book(rank){
	this.rank = rank.toString().toUpperCase();
}

Book.prototype = {
	toString: function() {
		return "[object Book: "+this.rank()+"]";
	}
}
