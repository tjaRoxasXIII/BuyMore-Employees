require './config/environment'

class ApplicationController < Sinatra::Base

  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "thisisthequickanddirtyway"
  end

  get "/" do
    erb :index
  end

  get '/employees/new' do
    erb :"/employees/new"
  end

  post '/employees/new' do
    @employee = Employee.find_by(email: params[:email])
    if @employee == nil
      new_employee = Employee.new(first_name: params[:first_name], last_name: params[:last_name], job_title: params[:job_title], email: params[:email], birthdate: params[:birthdate], password: params[:password])
      new_employee.store_id = Store.find_by(location: params[:job_location]).id
      new_employee.save
      redirect "/home"
    else
      redirect '/employees/new'
    end
  end

  post '/login' do
    # binding.pry
    @employee = Employee.find_by(email: params[:email])
    if @employee && @employee.authenticate(params[:password])
      session[:id] = @employee.id
      redirect "/home"
    else
      erb :login_error
    end
    
  end

  get '/home' do
    erb :"store/home"
  end

  get '/store/info' do 
    erb :"store/info"
  end

  post '/updates/new' do
    binding.pry
    @update = Update.new(content: params[:content])
    @update.employee_id = session[:id]
    binding.pry
    erb :"/store/home"
  end
end
