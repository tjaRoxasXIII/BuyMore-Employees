require './config/environment'

class ApplicationController < Sinatra::Base

  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "thisisthequickanddirtyway"
  end

  get "/" do
    if Helpers.is_logged_in?(session)
      redirect '/home'
    else
      erb :index
    end
  end

  post '/login' do
    @employee = Employee.find_by(email: params[:email])
    if @employee && @employee.authenticate(params[:password])
      session[:id] = @employee.id
      redirect "/home"
    else
      erb :login_error
    end
    
  end

  get '/home' do
    if Helpers.is_logged_in?(session)
      erb :"store/home"
    else
      redirect '/'
    end
  end

  get '/store/info' do 
    if Helpers.is_logged_in?(session)
      erb :"store/info"
    else  
      redirect '/'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
