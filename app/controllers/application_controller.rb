require './config/environment'

class ApplicationController < Sinatra::Base

  enable :sessions
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get '/employees/new' do
    erb :"/employees/new"
  end

  post '/employees/new' do
    
  end

end
