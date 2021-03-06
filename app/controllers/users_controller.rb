class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user


  def add_friend
    if Friendship.find_by_user_id_and_friend_id(current_user.id, @user.id).blank? &&
       Friendship.find_by_user_id_and_friend_id(@user.id, current_user.id).blank?
      friendship = Friendship.create(:user_id => current_user.id,
                        :friend_id => @user.id)
    end
    redirect_to :back
  end

  private
  def set_user
    @user = User.find_by_uuid(params[:id])
    if @user.blank?
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
