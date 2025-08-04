class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @tracked_friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @tracked_friends = current_user.friends
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      
      if @friends
        render 'users/my_friends'
      else
        flash[:alert] = "Could not find user"
        redirect_to my_friends_path
      end
    else
      flash[:alert] = "Please enter a friend name or email to search"
      redirect_to my_friends_path
    end
  end

end
