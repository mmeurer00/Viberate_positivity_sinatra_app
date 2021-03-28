class FollowersController < ApplicationController

    post '/users/:id/follow' do
        follow_user = User.find_by_id(params[:id])

        if !current_user.following.include?(follow_user)
            current_user.following << follow_user
        end
        if !follow_user.followers.include?(current_user)
            follow_user.followers << current_user
        end
        redirect '/following'
       
    end

    get '/following' do
        
    
        erb :'/users/following'
    end

    post '/users/:id/unfollow' do
        follow_user = User.find_by_id(params[:id])
        if follow_user.followers.include?(current_user)
            follow_user.followers.destroy(current_user)
        end
        redirect "/following"
    end
end