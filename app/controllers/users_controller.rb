class UsersController < ApplicationController
  get '/users/search' do
    if User.where(user_name: params["search"]).length > 0
      redirect "/users/#{params["search"]}"
    else
      redirect '/'
    end
  end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
     
      erb :'users/show'
    end
  
    get '/signup' do
      if !logged_in?
        erb :'users/new_user', locals: {message: "Please create an account before attempting to sign in."}
      else
        redirect to '/posts'
      end
    end
  
    post '/signup' do
        @user = User.new(params[:user])
        if @user.save
          session[:user_id] = @user.id
          redirect to '/posts'
        else
          redirect to '/signup'
        end
    end

    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/posts'
      end
    end
  
    post '/login' do
      user = User.find_by(:user_name => params[:user_name])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "/posts"
      else
        redirect to '/signup'
      end
    end
  
    get '/logout' do
      if logged_in?
        session[:user_id] = []
        redirect to '/login'
      else
        redirect to '/'
      end
    end

end