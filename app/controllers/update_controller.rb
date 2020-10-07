class UpdateController < ApplicationController

    post '/updates/new' do
        binding.pry
        @update = Update.new(content: params[:content])
        @update.employee_id = session[:id]
        @update.save
        redirect "/home"
    end
    
    get '/updates/:id/edit' do
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
    
end