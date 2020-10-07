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

  get '/employees/new' do
    if Helpers.is_logged_in?(session)
      redirect '/home'
    else
      erb :"/employees/new"
    end
  end

  post '/employees/new' do
    @employee = Employee.find_by(email: params[:email])
    if @employee == nil
      params.each do |param|
        if param[1].empty?
          redirect '/employees/new'
        else
        end
      end
      new_employee = Employee.new(first_name: params[:first_name], last_name: params[:last_name], job_title: params[:job_title], email: params[:email], birthdate: params[:birthdate], password: params[:password])
      new_employee.store_id = Store.find_by(location: params[:job_location]).id
      new_employee.save
      session[:id] = @employee.id
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
    # binding.pry
    @update = Update.new(content: params[:content])
    @update.employee_id = session[:id]
    @update.save
    # binding.pry
    redirect "/home"
  end

  get '/updates/:id/edit' do
    # binding.pry
    @update = Update.find_by(id: params[:id])
    if @update.employee_id == session[:id]
      erb :"/updates/edit"
    else
      redirect '/home'
    end
    
  end

  patch '/updates/:id' do
    binding.pry
    @update = Update.find_by(id: params[:id])
    @update.content = params[:content]
    @update.save
    redirect '/home'
  end

  get '/updates/:id/delete' do
    @update = Update.find_by(id: params[:id])
    @update.delete
    redirect '/home'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
