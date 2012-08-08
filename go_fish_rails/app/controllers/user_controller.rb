class UserController < ApplicationController

	def show
	  @user = User.find(params[:id])
	  render :show_player
	end

	def edit
	  @user = User.find(params[:id])
	  @address = @user.address
	  if @address == nil then
	    @address = @user.build_address({:name => @user.name})
	  end
	  render :edit_player
	end

	def update
	  @user = User.find(params[:id])
	  @address = @user.address
	  if @address == nil then
	    @address = @user.build_address({:name => @user.name})
	  end
	  #@address.update_attributes(params[:address])
	  #@user.update_attributes(params[:user])
	  if @address.update_attributes(params[:address]) == false then
	    flash[:notice] = "Your address is incomplete. All address fields are required."
	    redirect_to edit_url(@user.id)
	  elsif @user.update_attributes(params[:user]) == false then
	    flash[:notice] = "Your name is blank. Please re-enter your name."
	    redirect_to edit_url(@user.id)
	  else
	    flash[:notice] = "User profile saved successfully."
	    redirect_to play_url(@user.id)
	  end
	end

	def play
	  @user = User.find(params[:id])
	  @games = @user.results.where(:winner => nil)
	  render :user_player
	end

	def checkpoint
	  @user = User.find_by_username(params[:user][:username])
	  if @user == nil then
	    flash[:notice] = "Authentication Error. Please try again."
	    redirect_to root_url() and return
	  end

	  if !@user.password == params[:user][:password] then
	    flash[:notice] = "Authentication Error. Please try again."
	    redirect_to root_url() and return
	  end

	  session[:user_id] = @user.id
	  if @user.address then
	    redirect_to play_url(@user.id) and return
	  else
	    flash[:notice] = "You need to add a street address to your profile to continue."
	    redirect_to edit_url(@user.id)
	  end
	end

	def register
	  @user = User.create(:name => params[:user][:name], :username => params[:user][:username])
	    @user.password = params[:user][:password]
	    @user.name = params[:user][:name]
	    if @user.save == false then
	      flash[:notice] = "That username is already taken. Please choose another."
	      redirect_to root_url() and return
	    end
	    session[:user_id] = @user.id
	    flash[:notice] = "You need to add a street address to your profile to continue."
	    redirect_to edit_url(@user.id)
	end

	def list
	  @users = User.all
	  render :list_players
	end

	def reset
	  @user = User.find(params[:id])
	  if params[:token] == nil then
	    @user.token = ('a'..'z').to_a.shuffle[0,8].join
	    @user.token_expires_at = Date.next
	    @user.save
	    render :text => @user.token
	  else
	    if @user.token == params[:token] && (@user.token_expires_at <=> Date.today) > 0 then
	      render :text => "recovery in progress"
	    end
	  end
	end
end
