class WelcomeController < ApplicationController
  def index
    render :index
  end
	def canvas
		rank = ["2","3","4","5","6","7","8","9","10","J", "Q", "K", "A"]
		suit = ["C", "D", "S", "H"]  
		@cards = []
		rank.map{|r| suit.map {|s| @cards << s.downcase+r.downcase}}
		@cards << "back"
		render :canvas
	end

	def drawing
		puts params
		render :text => ""
	end
end
