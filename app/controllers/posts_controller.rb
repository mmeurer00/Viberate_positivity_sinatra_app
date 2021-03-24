class PostsController < ApplicationController
    get '/posts' do
      if logged_in?
        @posts = Post.all
        erb :'/posts/index'
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
          #if params[:content] == ""
              #rediect "/posts/new"
          #else
              @post = Post.new(params["post"])
              if @post.save
                  redirect "/posts/#{@post.id}"
              else
                  redirect "/posts/new"
              end
          #end
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
              redirect to "/posts/#{@post.id}"
          else
              redirect to "/posts/#{@post.id}/edit"
          end
            redirect to '/posts'
      else
      end
        redirect to '/login'
    end
  
    delete '/posts/:id/delete' do
      if logged_in?
        @post = Post.find_by_id(params[:id])
        if @post && @post.user == current_user
          @post.destroy
        end
        redirect to '/posts'
      else
        redirect to '/login'
      end
    end
end
    