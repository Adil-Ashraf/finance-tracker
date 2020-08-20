class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save 
      flash[:notice]= "Added to friends"
    else
      flash[:alert] = "There is somthing wrong with tracking requst"
    end
    redirect_to my_friends_path

  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy 
    flash[:notice] = "stopped following"
    redirect_to my_friends_path
  end
end
