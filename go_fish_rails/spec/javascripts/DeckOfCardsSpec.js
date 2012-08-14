
describe("Deck of Cards", function() {
	var deck;

	beforeEach(function() {
		deck = new DeckOfCards();
	});

	it("contains 52 cards", function() {
    expect(deck.numberOfCards()).toBe(52);
  });

	it("is shuffled", function() {
		card = deck.cards[0];
		deck.shuffle();
		card2 = deck.cards[0];
		expect(card.rank==card2.rank).not.toBe(true);
	});

	describe("draw", function() {
		it("draws top card", function() {
			var card = deck.draw();
			expect(card instanceof PlayingCard).toBe(true);
			expect(deck.numberOfCards()).toBe(51);
		});
	});
});
