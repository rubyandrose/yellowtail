class FriendsController < ApplicationController
  def index
    @users = User.all
  end
end
