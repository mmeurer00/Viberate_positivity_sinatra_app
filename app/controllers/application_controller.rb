require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, ENV["SESSION_SECRET"]
        set :show_exceptions, :after_handler
        use Rack::Flash, :sweep => true
    end

    get '/' do
        erb :index
    end

    not_found do
        erb :'oops'
    end

  helpers do

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def following?
        user = User.find_by_slug(params[:slug])
        current_user.following.include?(user)
    end

    
  end


end