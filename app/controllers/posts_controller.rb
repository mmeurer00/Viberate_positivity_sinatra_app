class PostsController < ApplicationController
    get '/posts' do
      redirect_login
        @posts = Post.all
        erb :'/posts/index'
    end

    get '/friends/posts' do
      if logged_in?
        posts = Post.all
        erb :'/posts/friend_posts'
      else
        redirect to '/login'
      end
    end
  
    get '/posts/new' do
      if logged_in?
        erb :'posts/new'
      else
        redirect to '/login'
      end
    end

    post '/posts' do
      if logged_in?
        @post = Post.new(params["post"])
        if params[:content] == ""
          "Error the content is blank, write something!"
        redirect "posts/new"
        else 
          if @post.positive_post?
            @post.user = current_user
            if @post.save
                redirect "/posts/#{@post.id}"
            else
                redirect "/posts/new"
            end
          else 
            flash[:error] = "Uh Oh! It looks like the message you we're trying to post contains some negativity. Try rephrasing it!"
            redirect 'posts/new'
          end
        end
      else
        redirect to '/login'
      end
    end

    get '/posts/:id' do
      if logged_in?
        @post = Post.find_by_id(params[:id])
        erb :'/posts/show_post'
      else
        redirect to '/login'
      end
    end

    get '/posts/:id/edit' do
      if logged_in?
        @post = Post.find_by_id(params[:id])
        if @post && @post.user == current_user
          erb :'/posts/edit_post'
        else
          redirect to '/posts'
        end
      else
        redirect to '/login'
      end
    end
  
  patch '/posts/:id' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
        if @post && @post.user == current_user
          @post.update(content: params["content"])
          if params[:content] == ""
            flash[:error] = "Oops! Looks like you didn't write anything, let's fix that!"
            redirect to "/posts/#{@post.id}/edit"
          else
            if @post.positive_post?
              redirect to "/posts/#{@post.id}"
            else
              flash[:error] = "Uh Oh! It looks like the message you we're trying to post contains some negativity. Try rephrasing it!"
              redirect to "/posts/#{@post.id}/edit"
            end
          end
        else
          redirect to '/posts'
        end
      else
        redirect to '/login'
    end
  end
    
    delete '/posts/:id' do
      if logged_in?
        @post = Post.find_by_id(params[:id])
        if @post.user == current_user
        erb :'/posts/show_post'
        @post.destroy
        end
        redirect to '/posts'
      else
        redirect to '/login'
      end
    end
end