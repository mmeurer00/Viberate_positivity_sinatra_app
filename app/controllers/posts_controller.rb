class PostsController < ApplicationController
    get '/posts' do
      if logged_in?
        @posts = Post.all
        erb :'posts/posts'
      else
        redirect to '/login'
      end
    end
  
    get '/posts/new' do
      if logged_in?
        erb :'posts/create_posts'
      else
        redirect to '/login'
      end
    end

    post '/posts' do
        if logged_in?
            if params[:content] == ""
                redirect to "/posts/new"
            else
                @posts = current_user.posts.build(content: params[:content])
                if @post.save
                    redirect to "/posts/#{@post.id}"
                else
                    redirect to "/posts/new"
                end
            end
        else
          redirect to '/login'
        end
    end
end
    