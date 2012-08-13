class PlayerController < ApplicationController
	before_filter :authenticate_user!

	def play
	  @user = current_user
		if @user.address == nil then
			flash[:notice] = "You must add an address before continuing."
			redirect_to address_path and return
		end
		@games = @user.results.where(:winner => nil)
	  render :user_player
	end

	def show
		@user = User.find(params[:id])
		if @user == current_user then
			@games = @user.results.where(:winner => nil)
			render :user_player
		else
			render :show_player
		end
	end

	def list
		@users = User.all
		render :list_players
	end


	def edit
	  @user = current_user
		@address = @user.address
	  if @address == nil then
	    @address = @user.build_address({:name => @user.name})
	  end
	  render :edit_player
	end

	def update
	  @user = current_user
	  @address = @user.address
	  if @address == nil then
	    @address = @user.build_address({:name => @user.name})
	  end
	  if @address.update_attributes(params[:address]) == false then
	    flash[:notice] = "Your address is incomplete. All address fields are required."
	    redirect_to address_url(@user.id)
	  elsif @user.update_attributes(params[:user]) == false then
	    flash[:notice] = "Your name is blank. Please re-enter your name."
	    redirect_to address_url()
	  else
	    flash[:notice] = "User profile saved successfully."
	    redirect_to play_url()
	  end
	end

end
