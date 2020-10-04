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

  post '/login' do
    @employee = Employee.find_by(params[:email])
    if @employee && @employee.authenticate(params["employee"][:password])
      erb :home
    else
      erb :login_error
    end
    
  end

end
